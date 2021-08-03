
PROGRAM _INIT
	(* Insert code here *)
	gCamSequencer.Ctrl.MpAxisCamSequencer_0.Enable:=TRUE;
	gCamSequencer.Ctrl.MpAxisCamSequencer_1.Enable:=TRUE;
	
//	gCamSequencer.RecipeCtrl.Enable:=TRUE;
//	gCamSequencer.RecipeCtrlPar.Enable:=TRUE;
	
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
	
	(* Sytuacja nalewak inkrementalny *)
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

	
	(* Sytuacja nalewak na sztywno *) (* Kszta³ butelk itd rozkminic to co ma byc w rece oraz czujnik itd jak przekazywac jak zmieniac te opcje itd *)
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
//	gCamSequencer.RecipeCtrl.MpLink:=ADR(gRecipeXml);
//	gCamSequencer.RecipeCtrl.DeviceName:=ADR('USER');
//	gCamSequencer.RecipeCtrl.FileName:=ADR('file1');
//	gCamSequencer.RecipeCtrl();
//	gCamSequencer.RecipeCtrlPar.MpLink:=ADR(gRecipeXml);
//	gCamSequencer.RecipeCtrlPar.PVName:=ADR('gCamSequencer.RecipeValues');
//	gCamSequencer.RecipeCtrlPar();
	
	gCamSequencer.Ctrl.MpAxisCamSequencer_0.MpLink:=ADR(gCartAxisCfg);
	gCamSequencer.Ctrl.MpAxisCamSequencer_0.MpLinkMaster:=ADR(gTranAxisCfg);	
	gCamSequencer.Ctrl.MpAxisCamSequencer_0.Parameters:=ADR(gCamSequencer.Ctrl.MpAxisCamSequencerPar_0);
	
	
	gCamSequencer.Ctrl.MpAxisCamSequencer_1.MpLink:=ADR(gPourAxisCfg);
	gCamSequencer.Ctrl.MpAxisCamSequencer_1.MpLinkMaster:=ADR(gCartAxisCfg);	
	gCamSequencer.Ctrl.MpAxisCamSequencer_1.Parameters:=ADR(gCamSequencer.Ctrl.MpAxisCamSequencerPar_1);
	//Machine.gCamSequencer.Ctrl.MpAxisCamSequencer_1.Signal1:=Machine.gCamSequencer.Ctrl.MpAxisCamSequencer_0.InCompensation;
	
//	CASE gCamSequencer.State OF
////		STATE_SAVE_SEQUENCER:
////			gCamSequencer.RecipeValues[1].Velocity:=gAxes.Ctrl.MpTransporterAxisPar.Velocity;
////			gCamSequencer.RecipeValues[1].CamProfileIndex:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].CamProfileIndex;
////			gCamSequencer.RecipeValues[1].MasterCompDistance:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterCompDistance;
////			gCamSequencer.RecipeValues[1].SlaveComDistance:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveCompDistance;
////			gCamSequencer.RecipeValues[1].MasterFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterFactor;
////			gCamSequencer.RecipeValues[1].SlaveFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveFactor;
////		
////			gCamSequencer.RecipeValues[2].Velocity:=gAxes.Ctrl.MpTransporterAxisPar.Velocity;
////			gCamSequencer.RecipeValues[2].CamProfileIndex:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].CamProfileIndex;
////			gCamSequencer.RecipeValues[2].MasterCompDistance:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterCompDistance;
////			gCamSequencer.RecipeValues[2].SlaveComDistance:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveCompDistance;
////			gCamSequencer.RecipeValues[2].MasterFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor;
////			gCamSequencer.RecipeValues[2].SlaveFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor;
//			
//			//gCamSequencer.RecipeCtrl.Save:=TRUE;
//	//	STATE_LOAD_SEQUENCER:d
//			gCamSequencer.RecipeCtrl.Load:=TRUE;
		

	//	END_CASE;
	IF gCamSequencer.Ctrl.MpAxisCamSequencer_1.UpdateDone THEN
		gCamSequencer.Ctrl.MpAxisCamSequencer_1.Update:=FALSE;
	END_IF
	
	IF brmfmod(UDINT_TO_REAL(cntButelki),5.0)=0 AND EDGENEG(diButelka)THEN
		gCamSequencer.Ctrl.MpAxisCamSequencer_0.Signal1:=TRUE;
	ELSE
		gCamSequencer.Ctrl.MpAxisCamSequencer_0.Signal1:=FALSE;
	END_IF;
	
	IF brmfmod(UDINT_TO_REAL(cntButelki),5.0)=0 AND EDGENEG(diButelka) THEN
		gCamSequencer.Ctrl.MpAxisCamSequencer_1.Signal1:=TRUE;
	ELSE
		gCamSequencer.Ctrl.MpAxisCamSequencer_1.Signal1:=FALSE;
	END_IF;
	
	gCamSequencer.Ctrl.MpAxisCamSequencer_0();
	gCamSequencer.Ctrl.MpAxisCamSequencer_1();

END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

