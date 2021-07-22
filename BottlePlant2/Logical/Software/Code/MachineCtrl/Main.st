
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
			MachineAxesPosition.Tasma:=gAxes.Ctrl.MpTransporterAxis.Position;
			MachineAxesPosition.Wozek:=gAxes.Ctrl.MpCartAxis.Position;
			MachineAxesPosition.Nalewak:=gAxes.Ctrl.MpPourerAxis.Position;
			AdrAxesPositions:=ADR(MachineAxesPosition);
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
				//pojawiaja sie przyciski od jog
				Machine.States.MachineState:=STATE_WAIT_FOR_CMD_MACHINE;
			END_IF;
		STATE_AUTO_MACHINE:
//			IF gAxes.Ctrl.MpTransporterAxis.MoveActive OR gAxes.Ctrl.MpTransporterAxis.MoveActive THEN
//	  			zabezpieczenie ze jesli jetw ruchu to nie mozna z manual do auto
			//			END_IF;
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
				gAxes.Ctrl.MpTransporterAxisPar.Position:=gAxes.Ctrl.MpTransporterAxis.Position+(500-brmfmod(LREAL_TO_REAL(gAxes.Ctrl.MpTransporterAxis.Position),500))+500;
				gAxes.Cmd.Auto.Update:=TRUE;
				gAxes.Ctrl.MpTransporterAxis.MoveAbsolute:=TRUE;
			END_IF
		

			
			
		
		
		
		//next case to wait for cmd
			

	END_CASE;

//	Machine.SequencerCtrl.MpAxisCamSequencer_0.MpLink:=ADR(gCartAxisCfg);
//	Machine.SequencerCtrl.MpAxisCamSequencer_0.MpLinkMaster:=ADR(gTranAxisCfg);	
//	Machine.SequencerCtrl.MpAxisCamSequencer_0.Parameters:=ADR(Machine.SequencerCtrl.MpAxisCamSequencerPar_0);
//	Machine.SequencerCtrl.MpAxisCamSequencer_0();
	

	
	//	Machine.SequencerCtrl.MpAxisCamSequencer_1.MpLink:=ADR(gPourAxisCfg);
	//	Machine.SequencerCtrl.MpAxisCamSequencer_1.MpLinkMaster:=ADR(gCartAxisCfg);	
	//	Machine.SequencerCtrl.MpAxisCamSequencer_1.Parameters:=ADR(Machine.SequencerCtrl.MpAxisCamSequencerPar_1);
//	//Machine.SequencerCtrl.MpAxisCamSequencer_1.Signal1:=Machine.SequencerCtrl.MpAxisCamSequencer_0.InCompensation;
//	Machine.SequencerCtrl.MpAxisCamSequencer_1();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

