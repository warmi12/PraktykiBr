
PROGRAM _INIT
	(* Insert code here *)
	Machine.States.MachineState:=STATE_INIT_MACHINE;

END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	CASE Machine.States.MachineState OF
		STATE_INIT_MACHINE:
			IF gAxes.State.Auto=STATE_WAIT_FOR_CMD_AXES THEN
				Machine.GUI.uiShowLayer[0]:=0;
			END_IF;
			//jeden przycisk do home ktory pozwala zbazowac wszystkie ale nie pokolei
			//ten button wywoluje gaxes.cmd.home
			IF gAxes.Ctrl.MpTransporterAxis.IsHomed AND gAxes.Ctrl.MpCartAxis.IsHomed AND gAxes.Ctrl.MpPourerAxis.IsHomed THEN
				//ustawiamy odpowiedni layer
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			END_IF;
			//zamiast main moze wait for cmd?
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

			Machine.GUI.uiShowLayer[0]:=1; //strona glowna
		STATE_START_MACHINE:
			//layer taki jak w home
			gAxes.Cmd.Auto.MoveVelocity:=TRUE;
			Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			//wylaczenie odpowiednich leyerow
		STATE_STOP_MACHINE:
			
			gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=FALSE;
			Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			//wlaczenie layeru w ktorym sa podlaczone przyciski z komendami hommowania
		STATE_MANUAL_MACHINE:
			IF gAxes.Ctrl.MpTransporterAxis.MoveActive THEN
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				//alarm maszyna w ruchu nie mozesz przejsc do tryby manualnego
			ELSE
				gAxes.SequencerCtrl.MpAxisCamSequencer_0.StartSequence:=FALSE;
				gAxes.SequencerCtrl.MpAxisCamSequencer_1.StartSequence:=FALSE;
				gAxes.SequencerCtrl.MpAxisCamSequencer_0.EndSequence:=TRUE;
				gAxes.SequencerCtrl.MpAxisCamSequencer_1.EndSequence:=TRUE;
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
					gAxes.SequencerCtrl.MpAxisCamSequencer_0.EndSequence:=FALSE;
					gAxes.SequencerCtrl.MpAxisCamSequencer_1.EndSequence:=FALSE;
					//gAxes.Cmd.Auto.MoveVelocity:=TRUE;
					Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
				END_IF
				
			END_IF;
//			IF gAxes.Ctrl.MpPourerAxis.Position <> 0 THEN
//				gAxes.Ctrl.MpPourerAxis.MoveAbsolute:=TRUE;
//			ELSE
//				gAxes.Ctrl.MpPourerAxis.MoveAbsolute:=FALSE;
//			END_IF
//			
//			IF gAxes.Ctrl.MpCartAxis.Position <> 0 AND gAxes.Ctrl.MpPourerAxis.Position=0 THEN
//				gAxes.Ctrl.MpCartAxis.MoveAbsolute:=TRUE;
//			ELSE
//				gAxes.Ctrl.MpCartAxis.MoveAbsolute:=FALSE;
//			END_IF
//		
//			IF gAxes.Ctrl.MpPourerAxis.Position=0 AND gAxes.Ctrl.MpCartAxis.Position=0 AND NOT(gAxes.Ctrl.MpTransporterAxis.MoveActive) THEN
//				gAxes.Ctrl.MpTransporterAxisPar.Position:=gAxes.Ctrl.MpTransporterAxis.Position+(500-brmfmod(LREAL_TO_REAL(gAxes.Ctrl.MpTransporterAxis.Position),500));
//				gAxes.Cmd.Auto.Update:=TRUE;
//				gAxes.Ctrl.MpTransporterAxis.MoveAbsolute:=TRUE;
//			END_IF
//		
//			IF gAxes.Ctrl.MpTransporterAxis.InPosition THEN
//				gAxes.Ctrl.MpTransporterAxis.MoveAbsolute:=FALSE;
//				gAxes.Ctrl.MpTransporterAxis.Update:=FALSE;
//				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
//				//odpowiednilayer?
//			END_IF;	
	END_CASE;
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

