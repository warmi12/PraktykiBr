
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
	
	(* Warunek przej�cia do stanu error | AND jest po to aby nie wchodzi� tam za ka�dym razem i nie wy�iwetla� message boxa *)
	IF (gAxes.State.Auto=STATE_ERROR_AXES OR gCamSequencer.State=STATE_ERROR_SEQUENCER) AND (Machine.States.MachineState <> STATE_ERROR_MACHINE)THEN
		Machine.GUI.uiShowLayer[5]:=0; //message box
	  	Machine.States.MachineState:=STATE_ERROR_MACHINE;
	END_IF;
	
	CASE Machine.States.MachineState OF
		STATE_INIT_MACHINE:
			(* Je�li kto� si� zaloguje  przejd� do odpowiedniej strony, kt�ra umo�liwa bazowanie *)
			IF gCurrentUser <> 0 THEN
				IF Machine.GUI.uiCurrentPage=0 THEN
					Machine.Status:='INITIAL';
	  				Machine.GUI.uiShowPage:=1;
				END_IF;
				
				IF gAxes.State.Auto=STATE_HOME_AXES THEN
					Machine.Status:='HOMMING';
				END_IF;
			
				(* Je�li osie zosta�y poprawnie zbazowane przejd� do main page *)
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
			(* Sprawdzamy czy od uruchomienia maszyny zosta�a z�adowana jakakolwiek receptura *)
			IF gRecipeLoaded THEN
				(* Je�eli poni�sze inputy ustawione sa na true tzn �e nalewaki, wozek s� na miejscu -> mo�na zaczyna�
					Je�li nie przechodzimy do trybu, kt�ry umie�cni nalewaki i w�zek na odpowiedniej pozycji
					Zabezpieczenie przed przej�ciem z manual do automat oraz z error do autmat*)
				IF gCamSequencer.Ctrl.MpAxisCamSequencer_0.StartSequence=TRUE AND gCamSequencer.Ctrl.MpAxisCamSequencer_1.StartSequence=TRUE THEN
					Machine.Status:='AUTOWORKING';
					gAxes.Cmd.Auto.MoveVelocity:=TRUE;
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				ELSE
					Machine.Status:='PREPARING';
					Machine.States.MachineState:=STATE_AUTO_MACHINE;
				END_IF;
			ELSE
				//wy�wietlenie message boxa, �e nie wczytano �adnej recipe
				Machine.GUI.uiShowLayer[2]:=0;
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			END_IF;
		STATE_STOP_MACHINE:
			Machine.Status:='STOPPED';
			gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=FALSE;
			Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
		STATE_MANUAL_MACHINE:
			//je�li maszyna w ruchu nie przejdziesz do manual mode
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
				(* Je�li nalewaki nie s� w pozycji 0 -> moveabsolute *)
				IF gAxes.Ctrl.MpPourerAxis.Position <> 0 THEN
					gAxes.Ctrl.MpPourerAxis.MoveAbsolute:=TRUE;
				ELSE
					gAxes.Ctrl.MpPourerAxis.MoveAbsolute:=FALSE;
				END_IF
				
				(* Powr�t w�zka do 0 gdy nalewaki s� w 0 *)
				IF gAxes.Ctrl.MpCartAxis.Position <> 0 AND gAxes.Ctrl.MpPourerAxis.Position=0 THEN
					gAxes.Ctrl.MpCartAxis.MoveAbsolute:=TRUE;
				ELSE
					gAxes.Ctrl.MpCartAxis.MoveAbsolute:=FALSE;
				END_IF
				
				(* Kiedy w�zek i nalewaki s� na odpowiednim miejscu, mo�na przygotowa� cam seq 
					Przej�� do znowu do poprzedniego stanu i uruchomi� maszyne*)
				IF gAxes.Ctrl.MpPourerAxis.Position=0 AND gAxes.Ctrl.MpCartAxis.Position=0 THEN
					gCamSequencer.Ctrl.MpAxisCamSequencer_0.EndSequence:=FALSE;
					gCamSequencer.Ctrl.MpAxisCamSequencer_1.EndSequence:=FALSE;
					gCamSequencer.Ctrl.MpAxisCamSequencer_0.StartSequence:=TRUE;
					gCamSequencer.Ctrl.MpAxisCamSequencer_1.StartSequence:=TRUE;
					Machine.States.MachineState:=STATE_START_MACHINE;
				END_IF
			END_IF;
		STATE_HOME_TRANSPORTER_MACHINE:
			(* Jesli o� si� porusza nie wyukona sie bazowanie *)
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
			(* Jesli o� si� porusza nie wyukona sie bazowanie *)
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
			(* Jesli o� si� porusza nie wyukona sie bazowanie *)
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
			(* Zabezpieczenie uniemo�liwiaj�ce wylogowanie kiedy maszyna w ruchu  *)
			IF gAxes.Ctrl.MpTransporterAxis.MoveActive THEN
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				Machine.GUI.uiShowLayer[3]:=0;//message box
			ELSE
				Machine.GUI.uiShowLayer[4]:=0;//message box
				IF Machine.GUI.uiConfirm THEN //potwierdzenie wylogowanaia
					gLogOutUser:=TRUE;	
					(* Je�li nikt nie jest zalogowany tzn ze zosta� wylogowany -> poka� stron� z logowaniem *)
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
			(* oczekiwanie na zalogowanie i przej�cie do main page *)
			IF gCurrentUser>0 THEN
				Machine.GUI.uiShowPage:=2;
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			END_IF;
		
		STATE_UPDATE_SPEED_MACHINE:
			(* aktualizacja pr�dko�ci maszyny z poziomu gui, nie recipe *)
			gAxes.Ctrl.MpTransporterAxisPar.Velocity:=uiBottlePerMinute;
			uiBottlePerHour:=uiBottlePerMinute;
			gRecipeValues[2].Velocity:=gAxes.Ctrl.MpTransporterAxisPar.Velocity;
	        gAxes.Cmd.Auto.Update:=TRUE;
			Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;	
		STATE_ERROR_MACHINE:
			(* Je�li b��d to ko�czymy sekwencje  *)
			gCamSequencer.Ctrl.MpAxisCamSequencer_0.StartSequence:=FALSE;
			gCamSequencer.Ctrl.MpAxisCamSequencer_1.StartSequence:=FALSE;
			gCamSequencer.Ctrl.MpAxisCamSequencer_0.EndSequence:=TRUE;
			gCamSequencer.Ctrl.MpAxisCamSequencer_1.EndSequence:=TRUE;
			
			Machine.Timer.IN:=NOT(Machine.Timer.Q);
			Machine.Timer.PT:=T#300ms;
			Machine.Timer();
			
			Machine.GUI.uiAlarmStatus:=Machine.GUI.uiAlarmStatus XOR Machine.Timer.Q;
			
			IF EDGEPOS(Machine.Cmd.MachineCmd.ErrorReset)THEN
				Machine.Cmd.MachineCmd.ErrorReset:=FALSE;
				gAxes.Cmd.Auto.ErrorReset:=TRUE;
				gCamSequencer.Cmd.ErrorReset:=TRUE;
			END_IF;
			
			(* Okienko message box je�li confirm przenosi na alarmy je�li refuse znika *)
			IF EDGEPOS(Machine.GUI.uiConfirm) THEN
				Machine.GUI.uiConfirm:=0;
				Machine.GUI.uiShowLayer[5]:=1;
				Machine.GUI.uiShowPage:=3;
			ELSIF EDGEPOS(Machine.GUI.uiRefuse) THEN
				Machine.GUI.uiShowLayer[5]:=1;
				Machine.GUI.uiRefuse:=0;
			END_IF
			
			(* je�li nie ma b��d�w przejdz do odpowiedniego stanu *)
			IF gAxes.State.Auto<>STATE_ERROR_AXES AND gCamSequencer.State<>STATE_ERROR_SEQUENCER THEN
				Machine.GUI.uiAlarmStatus:=0;
				Machine.Timer.IN:=FALSE;
				Machine.Timer();
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			END_IF;
	END_CASE;
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

