
PROGRAM _INIT
	(* Insert code here *)
	Machine.SequencerCtrl.MpAxisCamSequencer_0.Enable:=TRUE;
	//Machine.SequencerCtrl.MpAxisCamSequencer_1.Enable:=TRUE;
	
	Machine.States.MachineState:=STATE_INIT_MACHINE;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Deceleration:=1000;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.Master:=ADR(gTranAxis);
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.StartState:=0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].Type:=ncS_START;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].Attribute:=ncAT_ONCE;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].NextState:=1;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].CompMode:=ncONLYCOMP_DIRECT;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].CamProfileIndex:=16#ffff;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].MasterCompDistance:=45.0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].SlaveCompDistance:=90.0;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].MasterFactor:=180*100;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].SlaveFactor:=180*100;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].Type:=ncST_END;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].Attribute:=ncAT_ONCE;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].NextState:=2;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].CompMode:=ncONLYCOMP_DIRECT;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].CamProfileIndex:=16#fffe;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].MasterCompDistance:=45.0;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].SlaveCompDistance:=-270;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].MasterFactor:=1;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].SlaveFactor:=0;
	
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].Type:=ncST_END;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].Attribute:=ncAT_ONCE;
	Machine.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].NextState:=1;
	
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
			//brmfmod()
			///
			MachineAxesPosition.Tasma:=posT;
			MachineAxesPosition.Wozek:=posW;
			MachineAxesPosition.Nalewak:=posN;
			AdrAxesPositions:=ADR(MachineAxesPosition);
			Machine.GUI.uiShowLayer[0]:=1;
			

	END_CASE;

	Machine.SequencerCtrl.MpAxisCamSequencer_0.MpLink:=ADR(gCartAxisCfg);
	Machine.SequencerCtrl.MpAxisCamSequencer_0.MpLinkMaster:=ADR(gTranAxisCfg);	
	Machine.SequencerCtrl.MpAxisCamSequencer_0.Parameters:=ADR(Machine.SequencerCtrl.MpAxisCamSequencerPar_0);
	Machine.SequencerCtrl.MpAxisCamSequencer_0();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

