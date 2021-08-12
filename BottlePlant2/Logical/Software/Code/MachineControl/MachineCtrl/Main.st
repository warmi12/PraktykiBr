
PROGRAM _INIT
	(* Insert code here *)
	Machine.States.MachineState:=STATE_INIT_MACHINE;
	(* Hide all layer *)
	FOR Machine.GUI.uiShowPage:=0 TO 5 DO
		Machine.GUI.uiShowLayer[Machine.GUI.uiShowPage]:=1;
	END_FOR;
	
	Machine.GUI.uiShowPage:=0;
	Machine.Status:='LOGIN';
END_PROGRAM

PROGRAM _CYCLIC
	Machine.GUI.uiCounterBottle:=UDINT_TO_INT(cntButelki); //przekazanie do gui liczby nalanych butelek
	
	(* Warunek przejœcia do stanu error | AND jest po to aby nie wchodziæ tam za ka¿dym razem i nie wyœiwetlaæ message boxa *)
	IF (gAxes.State.Auto=STATE_ERROR_AXES OR gCamSequencer.State=STATE_ERROR_SEQUENCER) AND (Machine.States.MachineState <> STATE_ERROR_MACHINE)THEN
		Machine.GUI.uiShowLayer[5]:=0; //message box
	  	Machine.States.MachineState:=STATE_ERROR_MACHINE;
	END_IF;
	
	CASE Machine.States.MachineState OF
		STATE_INIT_MACHINE:
			(* Jeœli ktoœ siê zaloguje  przejdŸ do odpowiedniej strony, która umo¿liwa bazowanie *)
			IF gCurrentUser <> 0 THEN
				IF Machine.GUI.uiCurrentPage=0 THEN
					Machine.Status:='INITIAL';
	  				Machine.GUI.uiShowPage:=1;
				END_IF;
				
				IF gAxes.State.Auto=STATE_HOME_AXES THEN
					Machine.Status:='HOMMING';
				END_IF;
			
				(* Jeœli osie zosta³y poprawnie zbazowane przejdŸ do main page *)
				IF gAxes.Ctrl.MpTransporterAxis.IsHomed AND gAxes.Ctrl.MpCartAxis.IsHomed AND gAxes.Ctrl.MpPourerAxis.IsHomed THEN
					Machine.GUI.uiShowPage:=2; //main page
					Machine.GUI.uiShowLayer[0]:=0;
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
					Machine.Status:='WAITING';
				END_IF;
			END_IF
		STATE_WAIT_FOR_CMD_MACHINE:
			IF EDGEPOS(Machine.Cmd.MachineCmd.Start) THEN
				Machine.Cmd.MachineCmd.Start:=FALSE;
				Machine.States.MachineState:=STATE_START_MACHINE;
				//odpowiedni layer, powinien bych chyba ten co w init
			END_IF;
			IF EDGEPOS(Machine.Cmd.MachineCmd.Stop) THEN
				//stop layer -> pokazuja sie przyciski od home kazdej osi
				Machine.Cmd.MachineCmd.Stop:=FALSE;
				Machine.States.MachineState:=STATE_STOP_MACHINE;
			END_IF;
			IF EDGEPOS(Machine.Cmd.MachineCmd.ManualCtrl) THEN
				Machine.Cmd.MachineCmd.ManualCtrl:=FALSE;
				Machine.States.MachineState:=STATE_MANUAL_MACHINE;
			END_IF
			IF EDGEPOS(Machine.Cmd.MachineCmd.AutoCtrl) THEN
				Machine.Cmd.MachineCmd.AutoCtrl:=FALSE;
				Machine.States.MachineState:=STATE_AUTO_MACHINE;
			END_IF
			IF EDGEPOS(Machine.Cmd.MachineCmd.EStop) THEN
				Machine.Cmd.MachineCmd.EStop:=FALSE;
				Machine.States.MachineState:=STATE_ESTOP_MACHINE;
			END_IF
			IF EDGEPOS(Machine.Cmd.MachineCmd.HomeTransporter) THEN
				Machine.Cmd.MachineCmd.HomeTransporter:=FALSE;
				Machine.States.MachineState:=STATE_HOME_TRANSPORTER_MACHINE;
			END_IF
			IF EDGEPOS(Machine.Cmd.MachineCmd.HomeCart) THEN
				Machine.Cmd.MachineCmd.HomeCart:=FALSE;
				Machine.States.MachineState:=STATE_HOME_CART_MACHINE;
			END_IF
			IF EDGEPOS(Machine.Cmd.MachineCmd.HomePourer) THEN
				Machine.Cmd.MachineCmd.HomePourer:=FALSE;
				Machine.States.MachineState:=STATE_HOME_POURER_MACHINE;
			END_IF
			IF EDGEPOS(Machine.Cmd.MachineCmd.LogOut) THEN
				Machine.Cmd.MachineCmd.LogOut:=FALSE;
				Machine.States.MachineState:=STATE_LOGOUT_MACHINE;
			END_IF
			IF EDGEPOS(Machine.Cmd.MachineCmd.UpdateSpeed) THEN
				Machine.Cmd.MachineCmd.UpdateSpeed:=FALSE;
				Machine.States.MachineState:=STATE_UPDATE_SPEED_MACHINE;
			END_IF
			IF EDGEPOS(Machine.Cmd.MachineCmd.ErrorReset) THEN
				Machine.Cmd.MachineCmd.ErrorReset:=FALSE;
			END_IF

		STATE_START_MACHINE:
			(* Sprawdzamy czy od uruchomienia maszyny zosta³a z³adowana jakakolwiek receptura *)
			IF gRecipeLoaded THEN
				(* Je¿eli poni¿sze inputy ustawione sa na true tzn ¿e nalewaki, wozek s¹ na miejscu -> mo¿na zaczynaæ
					Jeœli nie przechodzimy do trybu, który umieœcni nalewaki i wózek na odpowiedniej pozycji
					Zabezpieczenie przed przejœciem z manual do automat oraz z error do autmat*)
				IF gCamSequencer.Ctrl.MpAxisCamSequencer_0.StartSequence=TRUE AND gCamSequencer.Ctrl.MpAxisCamSequencer_1.StartSequence=TRUE THEN
					Machine.Status:='AUTOWORKING';
					gAxes.Cmd.Auto.MoveVelocity:=TRUE;
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				ELSE
					Machine.Status:='PREPARING';
					Machine.States.MachineState:=STATE_AUTO_MACHINE;
				END_IF;
			ELSE
				//wyœwietlenie message boxa, ¿e nie wczytano ¿adnej recipe
				Machine.GUI.uiShowLayer[2]:=0;
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			END_IF;
		STATE_STOP_MACHINE:
			Machine.Status:='STOPPED';
			gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=FALSE;
			Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
		STATE_MANUAL_MACHINE:
			//jeœli maszyna w ruchu nie przejdziesz do manual mode
			IF gAxes.Ctrl.MpTransporterAxis.MoveActive THEN
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				Machine.GUI.uiShowLayer[1]:=0; //message box
			ELSE
				Machine.Status:='MANUAL';
				Machine.GUI.uiShowPage:=6; //pokazanie strony manualnej
				gCamSequencer.Ctrl.MpAxisCamSequencer_0.StartSequence:=FALSE;
				gCamSequencer.Ctrl.MpAxisCamSequencer_1.StartSequence:=FALSE;
				gCamSequencer.Ctrl.MpAxisCamSequencer_0.EndSequence:=TRUE;
				gCamSequencer.Ctrl.MpAxisCamSequencer_1.EndSequence:=TRUE;
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			END_IF;
		STATE_AUTO_MACHINE:
			
			IF gAxes.Ctrl.MpTransporterAxis.MoveActive OR gAxes.Ctrl.MpTransporterAxis.MoveActive OR gAxes.Ctrl.MpPourerAxis.MoveActive THEN
				//zabezpieczenie ze jesli jest w ruchu to nie mozna z manual do auto
			ELSE
				(* Jeœli nalewaki nie s¹ w pozycji 0 -> moveabsolute *)
				IF gAxes.Ctrl.MpPourerAxis.Position <> 0 THEN
					gAxes.Ctrl.MpPourerAxis.MoveAbsolute:=TRUE;
				ELSE
					gAxes.Ctrl.MpPourerAxis.MoveAbsolute:=FALSE;
				END_IF
				
				(* Powrót wózka do 0 gdy nalewaki s¹ w 0 *)
				IF gAxes.Ctrl.MpCartAxis.Position <> 0 AND gAxes.Ctrl.MpPourerAxis.Position=0 THEN
					gAxes.Ctrl.MpCartAxis.MoveAbsolute:=TRUE;
				ELSE
					gAxes.Ctrl.MpCartAxis.MoveAbsolute:=FALSE;
				END_IF
				
				(* Kiedy wózek i nalewaki s¹ na odpowiednim miejscu, mo¿na przygotowaæ cam seq 
					Przejœæ do znowu do poprzedniego stanu i uruchomiæ maszyne*)
				IF gAxes.Ctrl.MpPourerAxis.Position=0 AND gAxes.Ctrl.MpCartAxis.Position=0 THEN
					gCamSequencer.Ctrl.MpAxisCamSequencer_0.EndSequence:=FALSE;
					gCamSequencer.Ctrl.MpAxisCamSequencer_1.EndSequence:=FALSE;
					gCamSequencer.Ctrl.MpAxisCamSequencer_0.StartSequence:=TRUE;
					gCamSequencer.Ctrl.MpAxisCamSequencer_1.StartSequence:=TRUE;
					Machine.States.MachineState:=STATE_START_MACHINE;
				END_IF
			END_IF;
		STATE_HOME_TRANSPORTER_MACHINE:
			(* Jesli oœ siê porusza nie wyukona sie bazowanie *)
			IF gAxes.Ctrl.MpTransporterAxis.MoveActive THEN
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			ELSE
				Machine.Status:='MANUAL HOMMING';
				gAxes.Cmd.Manual.TransporterHomming;
				IF gAxes.Ctrl.MpTransporterAxis.IsHomed THEN
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
					Machine.Status:='MANUAL';
				END_IF;
			END_IF;
		STATE_HOME_CART_MACHINE:
			(* Jesli oœ siê porusza nie wyukona sie bazowanie *)
			IF gAxes.Ctrl.MpPourerAxis.MoveActive THEN
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			ELSE
				Machine.Status:='MANUAL HOMMING';
				gAxes.Cmd.Manual.CartHomming:=TRUE;
				IF gAxes.Ctrl.MpCartAxis.IsHomed THEN
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
					Machine.Status:='MANUAL';
				END_IF;
			END_IF;
		STATE_HOME_POURER_MACHINE:
			(* Jesli oœ siê porusza nie wyukona sie bazowanie *)
			IF gAxes.Ctrl.MpCartAxis.MoveActive THEN
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			ELSE
				Machine.Status:='MANUAL HOMMING';
				gAxes.Cmd.Manual.PourerHomming:=TRUE;
				IF gAxes.Ctrl.MpPourerAxis.IsHomed THEN
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
					Machine.Status:='MANUAL';
				END_IF;
			END_IF;
		STATE_LOGOUT_MACHINE:
			(* Zabezpieczenie uniemo¿liwiaj¹ce wylogowanie kiedy maszyna w ruchu  *)
			IF gAxes.Ctrl.MpTransporterAxis.MoveActive THEN
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				Machine.GUI.uiShowLayer[3]:=0;//message box
			ELSE
				Machine.GUI.uiShowLayer[4]:=0;//message box
				IF Machine.GUI.uiConfirm THEN //potwierdzenie wylogowanaia
					gLogOutUser:=TRUE;	
					(* Jeœli nikt nie jest zalogowany tzn ze zosta³ wylogowany -> poka¿ stronê z logowaniem *)
					IF gCurrentUser=0 THEN
						Machine.Status:='LOGOUT';
						Machine.GUI.uiShowLayer[4]:=1;
						Machine.States.MachineState:=STATE_LOGIN_MACHINE;
						Machine.GUI.uiShowPage:=0;
						gLogOutUser:=FALSE;
						Machine.GUI.uiConfirm:=0;
					END_IF;
				(* odrzucenie logout *)
				ELSIF Machine.GUI.uiRefuse THEN
					Machine.GUI.uiShowLayer[4]:=1;
					Machine.GUI.uiRefuse:=0;
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				END_IF;
			END_IF;
		STATE_LOGIN_MACHINE:
			(* oczekiwanie na zalogowanie i przejœcie do main page *)
			IF gCurrentUser>0 THEN
				Machine.GUI.uiShowPage:=2;
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			END_IF;
		
		STATE_UPDATE_SPEED_MACHINE:
			(* aktualizacja prêdkoœci maszyny z poziomu gui, nie recipe *)
			gAxes.Ctrl.MpTransporterAxisPar.Velocity:=uiBottlePerMinute;
			uiBottlePerHour:=uiBottlePerMinute;
			gRecipeValues[2].Velocity:=gAxes.Ctrl.MpTransporterAxisPar.Velocity;
	        gAxes.Cmd.Auto.Update:=TRUE;
			Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;	
		STATE_ERROR_MACHINE:
			(* Jeœli b³¹d to koñczymy sekwencje  *)
			gCamSequencer.Ctrl.MpAxisCamSequencer_0.StartSequence:=FALSE;
			gCamSequencer.Ctrl.MpAxisCamSequencer_1.StartSequence:=FALSE;
			gCamSequencer.Ctrl.MpAxisCamSequencer_0.EndSequence:=TRUE;
			gCamSequencer.Ctrl.MpAxisCamSequencer_1.EndSequence:=TRUE;
			
			IF EDGEPOS(Machine.Cmd.MachineCmd.ErrorReset)THEN
				Machine.Cmd.MachineCmd.ErrorReset:=FALSE;
				gAxes.Cmd.Auto.ErrorReset:=TRUE;
				gCamSequencer.Cmd.ErrorReset:=TRUE;
			END_IF;
			
			(* Okienko message box jeœli confirm przenosi na alarmy jeœli refuse znika *)
			IF EDGEPOS(Machine.GUI.uiConfirm) THEN
				Machine.GUI.uiConfirm:=0;
				Machine.GUI.uiShowLayer[5]:=1;
				Machine.GUI.uiShowPage:=3;
			ELSIF EDGEPOS(Machine.GUI.uiRefuse) THEN
				Machine.GUI.uiShowLayer[5]:=1;
				Machine.GUI.uiRefuse:=0;
			END_IF
			
			(* jeœli nie ma b³êdów przejdz do odpowiedniego stanu *)
			IF gAxes.State.Auto<>STATE_ERROR_AXES AND gCamSequencer.State<>STATE_ERROR_SEQUENCER THEN
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			END_IF;
	END_CASE;
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

