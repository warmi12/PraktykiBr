
PROGRAM _INIT
	(* Insert code here *)
	Machine.States.MachineState:=STATE_INIT_MACHINE;
	FOR Machine.GUI.uiShowPage:=0 TO 5 DO
		Machine.GUI.uiShowLayer[Machine.GUI.uiShowPage]:=1;
	END_FOR;
	
	Machine.GUI.uiShowPage:=0;
	Machine.Status:='LOGIN';
END_PROGRAM

PROGRAM _CYCLIC
	Machine.GUI.uiCounterBottle:=UDINT_TO_INT(cntButelki);
	
	CASE Machine.States.MachineState OF
		STATE_INIT_MACHINE:
			IF gCurrentUser <> 0 THEN
				IF Machine.GUI.uiCurrentPage=0 THEN
					Machine.Status:='INITIAL';
	  				Machine.GUI.uiShowPage:=1;
				END_IF;
				
				IF gAxes.State.Auto=STATE_HOME_AXES THEN
					Machine.Status:='HOMMING';
				END_IF;
			
				IF gAxes.Ctrl.MpTransporterAxis.IsHomed AND gAxes.Ctrl.MpCartAxis.IsHomed AND gAxes.Ctrl.MpPourerAxis.IsHomed THEN
					//ustawiamy odpowiedni layer
					//	main page
					Machine.GUI.uiShowPage:=2; //main page
					Machine.GUI.uiShowLayer[0]:=0;
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
					Machine.Status:='WAITING';
					//Machine.GUI.uiShowLayer[4]:=0;
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
				Machine.Status:='STOP';
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
			IF EDGEPOS(Machine.Cmd.MachineCmd.Alarm) THEN
				Machine.Cmd.MachineCmd.Alarm:=FALSE;
				Machine.States.MachineState:=STATE_ALARM_MACHINE;
			END_IF
			IF EDGEPOS(Machine.Cmd.MachineCmd.Service) THEN
				Machine.Cmd.MachineCmd.Service:=FALSE;
				Machine.States.MachineState:=STATE_SERVICE_MACHINE;
			END_IF
//			//tochyba do wyjebania
//			IF EDGEPOS(Machine.Cmd.MachineCmd.Home) THEN
//				Machine.Cmd.MachineCmd.Home:=FALSE;
//				Machine.States.MachineState:=STATE_HOME_MACHINE;
//			END_IF
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
			IF EDGEPOS(Machine.Cmd.MachineCmd.UpdateSpeed) THEN
				Machine.Cmd.MachineCmd.UpdateSpeed:=FALSE;
				Machine.States.MachineState:=STATE_UPDATE_SPEED_MACHINE;
			END_IF
			
			

			//Machine.GUI.uiShowLayer[0]:=0; //strona glowna
		STATE_START_MACHINE:
			//layer taki jak w home
			IF gRecipeLoaded THEN
				Machine.Status:='AUTOWORKING';
				gCamSequencer.Ctrl.MpAxisCamSequencer_0.StartSequence:=TRUE;
				gCamSequencer.Ctrl.MpAxisCamSequencer_1.StartSequence:=TRUE;
				gAxes.Cmd.Auto.MoveVelocity:=TRUE;
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			ELSE
				Machine.GUI.uiShowLayer[2]:=0;
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			END_IF;

			//wylaczenie odpowiednich leyerow
		STATE_STOP_MACHINE:
			gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=FALSE;
			Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			//wlaczenie layeru w ktorym sa podlaczone przyciski z komendami hommowania
		STATE_MANUAL_MACHINE:
			IF gAxes.Ctrl.MpTransporterAxis.MoveActive THEN
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				Machine.GUI.uiShowLayer[1]:=0;
				//alarm maszyna w ruchu nie mozesz przejsc do tryby manualnego
			ELSE
				//show manual page
				gCamSequencer.Ctrl.MpAxisCamSequencer_0.StartSequence:=FALSE;
				gCamSequencer.Ctrl.MpAxisCamSequencer_1.StartSequence:=FALSE;
				gCamSequencer.Ctrl.MpAxisCamSequencer_0.EndSequence:=TRUE;
				gCamSequencer.Ctrl.MpAxisCamSequencer_1.EndSequence:=TRUE;
				//pojawiaja sie przyciski od jog
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			END_IF;
		STATE_AUTO_MACHINE:
			IF gAxes.Ctrl.MpTransporterAxis.MoveActive OR gAxes.Ctrl.MpTransporterAxis.MoveActive OR gAxes.Ctrl.MpPourerAxis.MoveActive THEN
				///zabezpieczenie ze jesli jetw ruchu to nie mozna z manual do auto
			ELSE
				IF gAxes.Ctrl.MpPourerAxis.Position <> 0 THEN
					gAxes.Ctrl.MpPourerAxis.MoveAbsolute:=TRUE;
				ELSE
					gAxes.Ctrl.MpPourerAxis.MoveAbsolute:=FALSE;
				END_IF
				
				IF gAxes.Ctrl.MpCartAxis.Position <> 0 AND gAxes.Ctrl.MpPourerAxis.Position=0 THEN
					gAxes.Ctrl.MpCartAxis.MoveAbsolute:=TRUE;
				ELSE
					gAxes.Ctrl.MpCartAxis.MoveAbsolute:=FALSE;
				END_IF
				
				IF gAxes.Ctrl.MpPourerAxis.Position=0 AND gAxes.Ctrl.MpCartAxis.Position=0 THEN
					gCamSequencer.Ctrl.MpAxisCamSequencer_0.EndSequence:=FALSE;
					gCamSequencer.Ctrl.MpAxisCamSequencer_1.EndSequence:=FALSE;
					//gAxes.Cmd.Auto.MoveVelocity:=TRUE;
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				END_IF
			END_IF;
		STATE_RECIPE_MACHINE:
		
		STATE_HOME_TRANSPORTER_MACHINE:
			IF gAxes.Ctrl.MpTransporterAxis.MoveActive THEN
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				//alarm maszyna w ruchu nie mozesz przejsc do tryby manualnego
			ELSE
				Machine.Status:='MANUAL HOMMING';
				IF gAxes.Ctrl.MpTransporterAxis.IsHomed THEN
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				END_IF;
			END_IF;
		STATE_HOME_CART_MACHINE:
			IF gAxes.Ctrl.MpTransporterAxis.MoveActive THEN
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				//alarm maszyna w ruchu nie mozesz przejsc do tryby manualnego
			ELSE
				Machine.Status:='MANUAL HOMMING';
				IF gAxes.Ctrl.MpCartAxis.IsHomed THEN
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				END_IF;
			END_IF;
		STATE_HOME_POURER_MACHINE:
			IF gAxes.Ctrl.MpTransporterAxis.MoveActive THEN
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				//alarm maszyna w ruchu nie mozesz przejsc do tryby manualnego
			ELSE
				Machine.Status:='MANUAL HOMMING';
				IF gAxes.Ctrl.MpPourerAxis.IsHomed THEN
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				END_IF;
			END_IF;
		STATE_UPDATE_SPEED_MACHINE:
			gAxes.Ctrl.MpTransporterAxisPar.Velocity:=uiBottlePerMinute;
			uiBottlePerHour:=uiBottlePerMinute;
			gRecipeValues[1].Velocity:=gAxes.Ctrl.MpTransporterAxisPar.Velocity;
	        gAxes.Cmd.Auto.Update:=TRUE;
			Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
		
		
	END_CASE;
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

