
PROGRAM _INIT
	(* Insert code here *)
	Recipe.RecipeXml.Enable:=TRUE;
	Recipe.RecipeUI.Enable:=TRUE;
	Recipe.RecipeRegPar.Enable:=TRUE;
	Recipe.FileManagerUI.Enable:=TRUE;
	Recipe.State:=STATE_WAIT_RECIPE;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	Recipe.RecipeXml.MpLink:=ADR(gRecipeXml);
	Recipe.RecipeXml.DeviceName:=ADR(Recipe.RecipeData.DeviceName);
	Recipe.RecipeXml.FileName:=ADR('recipe');
	
	Recipe.RecipeUI.MpLink:=ADR(gRecipeXml);
	Recipe.RecipeUI.UIConnect:=ADR(Recipe.RecipeUIConnect);
	Recipe.RecipeUISetup.Confirmation.RecipeLoad:=TRUE;
	Recipe.RecipeUISetup.Confirmation.RecipeDelete:=TRUE;
	Recipe.RecipeUISetup.Confirmation.RecipeSave:=TRUE;
	Recipe.RecipeUISetup.Confirmation.RecipeCreate:=TRUE;
	Recipe.RecipeUISetup.Confirmation.RecipeRename:=TRUE;
	Recipe.RecipeUI.UISetup:=Recipe.RecipeUISetup;
	
	Recipe.RecipeRegPar.MpLink:=ADR(gRecipeXml);
	Recipe.RecipeRegPar.PVName:=ADR('gRecipeValues');
	
	Recipe.FileManagerUI.MpLink:=ADR(gFileManagerUI);
	Recipe.FileManagerUI.UIConnect:=ADR(Recipe.FileManagerUIConnect);
	Recipe.FileManagerUI.UISetup:=Recipe.FileManagerSetup;
	
	Recipe.FileManagerUIConnect.DeviceList.DeviceNames[0]:=Recipe.RecipeData.DeviceName;
	
	CASE Recipe.State OF
		STATE_WAIT_RECIPE:
			IF Recipe.RecipeUIConnect.Status=mpRECIPE_UI_STATUS_LOAD THEN
				Recipe.State:=STATE_LOAD_RECIPE;
			ELSIF Recipe.RecipeUIConnect.MessageBox.Type=mpRECIPE_UI_MSG_CONFIRM_SAVE THEN
				Recipe.State:=STATE_SAVE_RECIPE;
			END_IF;
		STATE_LOAD_RECIPE:
			IF Recipe.RecipeUIConnect.Status=mpRECIPE_UI_STATUS_IDLE THEN
				gRecipeLoaded:=TRUE;
				uiRecipeBottlePerMinute := gRecipeValues[1].Velocity;
				uiRecipeBottlePerHour := gRecipeValues[1].Velocity;
				uiBottlePerHour:=gRecipeValues[1].Velocity;
				uiBottlePerMinute:=gRecipeValues[1].Velocity;
				gAxes.Ctrl.MpTransporterAxisPar.Velocity:=gRecipeValues[1].Velocity;
				
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].CamProfileIndex:=gRecipeValues[1].CamProfileIndex;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterCompDistance:=gRecipeValues[1].MasterCompDistance;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveCompDistance:=gRecipeValues[1].SlaveComDistance;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterFactor:=gRecipeValues[1].MasterFactor;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveFactor:=gRecipeValues[1].SlaveFactor;
				//gCamSequencer.Ctrl.MpAxisCamSequencer_0.Update:=TRUE;

				//gAxes.Ctrl.MpTransporterAxisPar.Velocity:=gRecipeValues[2].Velocity;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].CamProfileIndex:=gRecipeValues[2].CamProfileIndex;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterCompDistance:=gRecipeValues[2].MasterCompDistance;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveCompDistance:=gRecipeValues[2].SlaveComDistance;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor:=gRecipeValues[2].MasterFactor;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor:=gRecipeValues[2].SlaveFactor;
			
				IF gCamSequencer.Ctrl.MpAxisCamSequencer_0.StartSequence=TRUE AND gCamSequencer.Ctrl.MpAxisCamSequencer_0.ActualStateIndex=2 THEN
					gCamSequencer.Ctrl.MpAxisCamSequencer_1.Update:=TRUE;
					gAxes.Cmd.Auto.Update:=TRUE;
					Recipe.State:=STATE_WAIT_RECIPE;
				ELSIF gCamSequencer.Ctrl.MpAxisCamSequencer_0.StartSequence=FALSE THEN
					gCamSequencer.Ctrl.MpAxisCamSequencer_1.Update:=TRUE;
					gAxes.Cmd.Auto.Update:=TRUE;
					Recipe.State:=STATE_WAIT_RECIPE;
				END_IF
			END_IF;	
			
		STATE_SAVE_RECIPE:
				gRecipeValues[1].Velocity:=gAxes.Ctrl.MpTransporterAxisPar.Velocity;
				gRecipeValues[1].CamProfileIndex:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].CamProfileIndex;
				gRecipeValues[1].MasterCompDistance:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterCompDistance;
				gRecipeValues[1].SlaveComDistance:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveCompDistance;
				gRecipeValues[1].MasterFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterFactor;
				gRecipeValues[1].SlaveFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveFactor;
	
				gRecipeValues[2].Velocity:=gAxes.Ctrl.MpTransporterAxisPar.Velocity;
				gRecipeValues[2].CamProfileIndex:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].CamProfileIndex;
				gRecipeValues[2].MasterCompDistance:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterCompDistance;
				gRecipeValues[2].SlaveComDistance:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveCompDistance;
				gRecipeValues[2].MasterFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor;
				gRecipeValues[2].SlaveFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor;
				Recipe.State:=STATE_WAIT_RECIPE;

	END_CASE;
	
	Recipe.RecipeXml();
	Recipe.RecipeRegPar();
	Recipe.RecipeUI();
	Recipe.FileManagerUI();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

