
PROGRAM _INIT
	(* Insert code here *)
	Machine.SequencerCtrl.MpAxisCamSequencer_0.Enable:=TRUE;
	Machine.SequencerCtrl.MpAxisCamSequencer_1.Enable:=TRUE;
	
	Machine.States.MachineState:=STATE_INIT_MACHINE;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Deceleration:=1000;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.Master:=ADR(gTranAxis);
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.StartState:=0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].Type:=ncS_START;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].Attribute:=ncAT_ONCE;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].NextState:=1;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].CompMode:=ncONLYCOMP_DIRECT;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].CamProfileIndex:=16#ffff;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].MasterCompDistance:=0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].SlaveCompDistance:=0;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].MasterFactor:=400*100;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].SlaveFactor:=400*100;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].Type:=ncST_END;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].Attribute:=ncAT_ONCE;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].NextState:=2;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].CompMode:=ncONLYCOMP_DIRECT;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].CamProfileIndex:=16#fffe;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].MasterCompDistance:=100;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].SlaveCompDistance:=-400;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].MasterFactor:=1;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].SlaveFactor:=1;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].Type:=ncST_END;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].Attribute:=ncAT_ONCE;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].NextState:=1;
	
	(* drugi seq *)
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Deceleration:=1000;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.Master:=ADR(gCartAxis);
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.StartState:=0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[0].Event[0].Type:=ncSIGNAL1;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[0].Event[0].Attribute:=ncAT_ONCE;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[0].Event[0].NextState:=1;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].CompMode:=ncONLYCOMP_DIRECT;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].CamProfileIndex:=16#fffe;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterCompDistance:=100.0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveCompDistance:=275.0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterFactor:=1;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveFactor:=0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Type:=ncST_END;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Attribute:=ncAT_ONCE;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].NextState:=2;
	
//	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].CompMode:=ncONLYCOMP_DIRECT;
//	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].CamProfileIndex:=16#ffff;
//	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterCompDistance:=0.0;
//	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveCompDistance:=0.0;
//	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor:=200*100;
//	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor:=0;
//	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Type:=ncST_END;
//	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Attribute:=ncAT_ONCE;
//	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].NextState:=3;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].CompMode:=ncONLYCOMP_DIRECT;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].CamProfileIndex:=16#fffe;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterCompDistance:=290.0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveCompDistance:=-275.0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor:=1;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor:=0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Type:=ncST_END;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Attribute:=ncAT_ONCE;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].NextState:=0;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[3].CompMode:=ncONLYCOMP_DIRECT;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[3].CamProfileIndex:=16#fffe;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[3].MasterCompDistance:=90.0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[3].SlaveCompDistance:=-470.0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[3].MasterFactor:=1;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[3].SlaveFactor:=0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[3].Event[0].Type:=ncST_END;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[3].Event[0].Attribute:=ncAT_ONCE;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[3].Event[0].NextState:=0;
	
	
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	CASE Machine.States.MachineState OF
		STATE_INIT_MACHINE:
			IF gAxes.State=STATE_WAIT_FOR_CMD_AXES THEN
				Machine.GUI.uiShowLayer[0]:=0;
			END_IF;
			
			IF gAxes.Ctrl.MpTransporterAxis.IsHomed AND gAxes.Ctrl.MpCartAxis.IsHomed AND gAxes.Ctrl.MpPourerAxis.IsHomed THEN
				Machine.States.MachineState:=STATE_MAIN_MACHINE;
			END_IF;
		STATE_MAIN_MACHINE:
			IF EDGEPOS(Machine.Cmd.MachineCmd.Start) THEN
				Machine.Cmd.MachineCmd.Start:=FALSE;
				Machine.SequencerCtrl.MpAxisCamSequencer_0.StartSequence:=TRUE;
				Machine.SequencerCtrl.MpAxisCamSequencer_1.StartSequence:=TRUE;
				gAxes.Cmd.MoveVelocity:=TRUE;
			END_IF;
			MachineAxesPosition.Tasma:=gAxes.Ctrl.MpTransporterAxis.Position;
			MachineAxesPosition.Wozek:=gAxes.Ctrl.MpCartAxis.Position;
			MachineAxesPosition.Nalewak:=gAxes.Ctrl.MpPourerAxis.Position;
			AdrAxesPositions:=ADR(MachineAxesPosition);
			Machine.GUI.uiShowLayer[0]:=1;
			

	END_CASE;

	Machine.SequencerCtrl.MpAxisCamSequencer_0.MpLink:=ADR(gCartAxisCfg);
	Machine.SequencerCtrl.MpAxisCamSequencer_0.MpLinkMaster:=ADR(gTranAxisCfg);	
	Machine.SequencerCtrl.MpAxisCamSequencer_0.Parameters:=ADR(Machine.SequencerCtrl.MpAxisCamSequencerPar_0);
	Machine.SequencerCtrl.MpAxisCamSequencer_0();
	
	IF Machine.SequencerCtrl.MpAxisCamSequencer_0.ActualStateIndex=1 THEN
		Machine.SequencerCtrl.MpAxisCamSequencer_1.Signal1:=TRUE;
	ELSE
		Machine.SequencerCtrl.MpAxisCamSequencer_1.Signal1:=FALSE;
	END_IF;
	
	Machine.SequencerCtrl.MpAxisCamSequencer_1.MpLink:=ADR(gPourAxisCfg);
	Machine.SequencerCtrl.MpAxisCamSequencer_1.MpLinkMaster:=ADR(gCartAxisCfg);	
	Machine.SequencerCtrl.MpAxisCamSequencer_1.Parameters:=ADR(Machine.SequencerCtrl.MpAxisCamSequencerPar_1);
	//Machine.SequencerCtrl.MpAxisCamSequencer_1.Signal1:=Machine.SequencerCtrl.MpAxisCamSequencer_0.InCompensation;
	Machine.SequencerCtrl.MpAxisCamSequencer_1();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

