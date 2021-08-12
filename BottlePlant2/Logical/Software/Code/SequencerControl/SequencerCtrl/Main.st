
PROGRAM _INIT
	(* Insert code here *)
	gCamSequencer.Ctrl.MpAxisCamSequencer_0.Enable:=TRUE;
	gCamSequencer.Ctrl.MpAxisCamSequencer_1.Enable:=TRUE;
	gCamSequencer.State:=STATE_WORK_SEQUENCER;
	
	(* Zdefiniowanie podstawowych parametrów sequencera *)
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Deceleration:=1000;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.Master:=ADR(gTranAxis);
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.StartState:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].Type:=ncSIGNAL1;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].Attribute:=ncAT_ONCE;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].NextState:=1;
	
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].CompMode:=ncOFF;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].CamProfileIndex:=16#ffff;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].MasterCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].SlaveCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].MasterFactor:=400*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].SlaveFactor:=400*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].Type:=ncST_END;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].Attribute:=ncST_END;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].NextState:=2;
	
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].CompMode:=ncOFF;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].CamProfileIndex:=16#ffff;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].MasterCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].SlaveCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].MasterFactor:=90*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].SlaveFactor:=-400*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].Type:=ncST_END;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].Attribute:=ncST_END;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].NextState:=0;
	
	(* drugi seq *)
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Deceleration:=1000;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.Master:=ADR(gCartAxis);
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.StartState:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[0].Event[0].Type:=ncSIGNAL1;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[0].Event[0].Attribute:=ncAT_ONCE;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[0].Event[0].NextState:=1;
	
	(* Nalewak inkrementalny -> nalewak idzie wraz z poziomem cieczy *)
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].CompMode:=ncOFF;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].CamProfileIndex:=16#ffff;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterFactor:=100*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveFactor:=215*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Type:=ncST_END;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Attribute:=ncAT_ONCE;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].NextState:=2;
	
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].CompMode:=ncOFF;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].CamProfileIndex:=16#ffff;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor:=215*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor:=-90*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Type:=ncST_END;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Attribute:=ncAT_ONCE;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].NextState:=3;
	
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].CompMode:=ncOFF;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].CamProfileIndex:=16#ffff;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].MasterCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].SlaveCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].MasterFactor:=54*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].SlaveFactor:=-65*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].Event[0].Type:=ncST_END;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].Event[0].Attribute:=ncAT_ONCE;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].Event[0].NextState:=4;
	
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[4].CompMode:=ncOFF;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[4].CamProfileIndex:=16#ffff;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[4].MasterCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[4].SlaveCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[4].MasterFactor:=22*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[4].SlaveFactor:=-60*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[4].Event[0].Type:=ncST_END;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[4].Event[0].Attribute:=ncAT_ONCE;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[4].Event[0].NextState:=0;

	
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].CompMode:=ncOFF;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].CamProfileIndex:=16#ffff;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterCompDistance:=0;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveCompDistance:=0;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterFactor:=100*100;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveFactor:=215*100;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Type:=ncST_END;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Attribute:=ncAT_ONCE;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].NextState:=2;
//	
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].CompMode:=ncOFF;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].CamProfileIndex:=16#ffff;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterCompDistance:=0;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveCompDistance:=0;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor:=200*100;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor:=0*100;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Type:=ncST_END;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Attribute:=ncAT_ONCE;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].NextState:=3;
//	
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].CompMode:=ncOFF;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].CamProfileIndex:=16#ffff;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].MasterCompDistance:=0;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].SlaveCompDistance:=0;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].MasterFactor:=90*100;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].SlaveFactor:=-215*100;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].Event[0].Type:=ncST_END;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].Event[0].Attribute:=ncAT_ONCE;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].Event[0].NextState:=0;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	gCamSequencer.Ctrl.MpAxisCamSequencer_0.MpLink:=ADR(gCartAxisCfg);
	gCamSequencer.Ctrl.MpAxisCamSequencer_0.MpLinkMaster:=ADR(gTranAxisCfg);	
	gCamSequencer.Ctrl.MpAxisCamSequencer_0.Parameters:=ADR(gCamSequencer.Ctrl.MpAxisCamSequencerPar_0);

	gCamSequencer.Ctrl.MpAxisCamSequencer_1.MpLink:=ADR(gPourAxisCfg);
	gCamSequencer.Ctrl.MpAxisCamSequencer_1.MpLinkMaster:=ADR(gCartAxisCfg);	
	gCamSequencer.Ctrl.MpAxisCamSequencer_1.Parameters:=ADR(gCamSequencer.Ctrl.MpAxisCamSequencerPar_1);

	IF gCamSequencer.Ctrl.MpAxisCamSequencer_0.Error OR gCamSequencer.Ctrl.MpAxisCamSequencer_1.Error THEN
		gCamSequencer.State:=STATE_ERROR_SEQUENCER;
	END_IF;
	
	CASE gCamSequencer.State OF
		STATE_WORK_SEQUENCER:
			IF gCamSequencer.Ctrl.MpAxisCamSequencer_1.UpdateDone THEN
				gCamSequencer.Ctrl.MpAxisCamSequencer_1.Update:=FALSE;
			END_IF
			(* Warunek wzbudzaj¹cy sygna³ sequencera na 1 *)
			(* Jeœli zmienna licz¹ca sygna³ z czujnika butelek jest podzielna przez 5 oraz sygna³ z tego czujnika ma zbocze opadaj¹ce TO
			5 butelek jest pod nalewakami, zaczynamy sekwencjê*)
			IF brmfmod(UDINT_TO_REAL(cntButelki),5.0)=0 AND EDGENEG(diButelka)THEN
				gCamSequencer.Ctrl.MpAxisCamSequencer_0.Signal1:=TRUE;
				gCamSequencer.Ctrl.MpAxisCamSequencer_1.Signal1:=TRUE;
			ELSE
				gCamSequencer.Ctrl.MpAxisCamSequencer_0.Signal1:=FALSE;
				gCamSequencer.Ctrl.MpAxisCamSequencer_1.Signal1:=FALSE;
			END_IF;
			
			IF gAxes.Ctrl.MpTransporterAxis.MoveActive AND (gCamSequencer.Ctrl.MpAxisCamSequencer_1.ActualStateIndex=2 OR gCamSequencer.Ctrl.MpAxisCamSequencer_1.ActualStateIndex=3) THEN
				DoPourer:=TRUE;
			ELSE
				DoPourer:=FALSE;
			END_IF
		STATE_ERROR_SEQUENCER:
			IF EDGEPOS(gCamSequencer.Cmd.ErrorReset) THEN
				gCamSequencer.Cmd.ErrorReset:=FALSE;
				gCamSequencer.Ctrl.MpAxisCamSequencer_0.ErrorReset:=TRUE;
				gCamSequencer.Ctrl.MpAxisCamSequencer_1.ErrorReset:=TRUE;
				//gCamSequencer.State:=STATE_WAIT_FOR_CMD_SEQUENCER;
			END_IF;
			IF NOT(gCamSequencer.Ctrl.MpAxisCamSequencer_0.Error) AND NOT(gCamSequencer.Ctrl.MpAxisCamSequencer_1.Error) THEN
				gCamSequencer.Ctrl.MpAxisCamSequencer_0.ErrorReset:=FALSE;
				gCamSequencer.Ctrl.MpAxisCamSequencer_1.ErrorReset:=FALSE;
	  			gCamSequencer.State:=STATE_WORK_SEQUENCER;
			END_IF;
	END_CASE;
	gCamSequencer.Ctrl.MpAxisCamSequencer_0();
	gCamSequencer.Ctrl.MpAxisCamSequencer_1();

END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

