
PROGRAM _INIT
	(* Insert code here *)
	gCamSequencer.Ctrl.MpAxisCamSequencer_0.Enable:=TRUE;
	gCamSequencer.Ctrl.MpAxisCamSequencer_1.Enable:=TRUE;
	gCamSequencer.State:=STATE_WAIT_FOR_CMD_SEQUENCER;
	
	(* Zdefiniowanie podstawowych parametrów sequencera *)
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Deceleration:=1000;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.Master:=ADR(gTranAxis);
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.StartState:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].Type:=ncSIGNAL1;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].Attribute:=ncAT_ONCE;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].NextState:=1;
	
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].CompMode:=ncONLYCOMP_DIRECT;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].CamProfileIndex:=16#ffff;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].MasterCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].SlaveCompDistance:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].MasterFactor:=400*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].SlaveFactor:=400*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].Type:=ncST_END;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].Attribute:=ncAT_ONCE;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].NextState:=2;
	
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].CompMode:=ncONLYCOMP_DIRECT;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].CamProfileIndex:=16#fffe;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].MasterCompDistance:=90;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].SlaveCompDistance:=-400;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].MasterFactor:=1;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].SlaveFactor:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].Type:=ncST_END;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].Attribute:=ncAT_ONCE;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].NextState:=0;
	
	(* drugi seq *)
	
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Deceleration:=1000;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.Master:=ADR(gCartAxis);
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.StartState:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[0].Event[0].Type:=ncSIGNAL1;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[0].Event[0].Attribute:=ncAT_ONCE;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[0].Event[0].NextState:=1;
	
	(* Nalewak inkrementalny -> nalewak idzie wraz z poziomem cieczy *)
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].CompMode:=ncONLYCOMP_DIRECT;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].CamProfileIndex:=16#fffe;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterCompDistance:=100.0;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveCompDistance:=275.0;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterFactor:=1;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveFactor:=0;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Type:=ncST_END;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Attribute:=ncAT_ONCE;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].NextState:=2;
//	
//
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].CompMode:=ncONLYCOMP_DIRECT;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].CamProfileIndex:=16#fffe;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterCompDistance:=290.0;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveCompDistance:=-275.0;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor:=1;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor:=0;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Type:=ncST_END;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Attribute:=ncAT_ONCE;
//	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].NextState:=0;

	
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].CompMode:=ncONLYCOMP_DIRECT;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].CamProfileIndex:=16#ffff;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterCompDistance:=100.0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveCompDistance:=275.0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterFactor:=200*100;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveFactor:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Type:=ncST_END;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Attribute:=ncAT_ONCE;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].NextState:=2;
	
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].CompMode:=ncONLYCOMP_DIRECT;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].CamProfileIndex:=16#fffe;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterCompDistance:=90.0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveCompDistance:=-275.0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor:=1;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor:=0;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Type:=ncST_END;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Attribute:=ncAT_ONCE;
	gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].NextState:=0;
	 
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	IF gCamSequencer.Ctrl.MpAxisCamSequencer_0.Error OR gCamSequencer.Ctrl.MpAxisCamSequencer_1.Error THEN
	  gCamSequencer.State:=STATE_ERROR_SEQUENCER;
	END_IF;
	
	gCamSequencer.Ctrl.MpAxisCamSequencer_0.MpLink:=ADR(gCartAxisCfg);
	gCamSequencer.Ctrl.MpAxisCamSequencer_0.MpLinkMaster:=ADR(gTranAxisCfg);	
	gCamSequencer.Ctrl.MpAxisCamSequencer_0.Parameters:=ADR(gCamSequencer.Ctrl.MpAxisCamSequencerPar_0);
	
	
	gCamSequencer.Ctrl.MpAxisCamSequencer_1.MpLink:=ADR(gPourAxisCfg);
	gCamSequencer.Ctrl.MpAxisCamSequencer_1.MpLinkMaster:=ADR(gCartAxisCfg);	
	gCamSequencer.Ctrl.MpAxisCamSequencer_1.Parameters:=ADR(gCamSequencer.Ctrl.MpAxisCamSequencerPar_1);
	//Machine.gCamSequencer.Ctrl.MpAxisCamSequencer_1.Signal1:=Machine.gCamSequencer.Ctrl.MpAxisCamSequencer_0.InCompensation;
	
	CASE gCamSequencer.State OF
		STATE_WAIT_FOR_CMD_SEQUENCER:
			
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
	  			gCamSequencer.State:=STATE_WAIT_FOR_CMD_SEQUENCER;
			END_IF;
	END_CASE;
	
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
	
	gCamSequencer.Ctrl.MpAxisCamSequencer_0();
	gCamSequencer.Ctrl.MpAxisCamSequencer_1();

END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

