
PROGRAM _INIT
	(* Insert code here *)
	Recipe.State:=STATE_INIT_RECIPE;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	Recipe.Ctrl.MpLink:=ADR(gRecipeXml);
	Recipe.Ctrl.DeviceName:=ADR('USER');
	Recipe.Ctrl.FileName:=ADR(Recipe.NameOfRecipe); //to bedzie aktualizowane
	
	Recipe.CtrlPar.MpLink:=ADR(gRecipeXml);
	Recipe.CtrlPar.PVName:=ADR('Recipe.RecipeValues');
	
	CASE Recipe.State OF
		STATE_INIT_RECIPE:
			Recipe.Ctrl.Enable:=TRUE;
			Recipe.CtrlPar.Enable:=TRUE;
			//Recipe.Ctrl.FileName:=ADR('file1');??
			IF Recipe.Ctrl.Active AND Recipe.CtrlPar.Active THEN
	  			Recipe.State:=STATE_WAIT_FOR_CMD_RECIPE;
			END_IF;
		STATE_WAIT_FOR_CMD_RECIPE:
			IF EDGEPOS(Recipe.Cmd.Save) THEN
				Recipe.Cmd.Save:=FALSE;
				Recipe.State:=STATE_SAVE_RECIPE;
			ELSIF EDGEPOS(Recipe.Cmd.Load) THEN
				Recipe.Cmd.Load:=FALSE;
				Recipe.State:=STATE_LOAD_RECIPE;
			ELSIF EDGEPOS(Recipe.Cmd.AddRecipe) THEN
				Recipe.Cmd.AddRecipe:=FALSE;
				Recipe.State:=STATE_ADD_RECIPE;
			ELSIF EDGEPOS(Recipe.Cmd.ChangeRecipe) THEN
				Recipe.Cmd.ChangeRecipe:=FALSE;
				Recipe.State:=STATE_CHANGE_RECIPE;	
			ELSIF EDGEPOS(Recipe.Cmd.RemoveRecipe) THEN
				Recipe.Cmd.RemoveRecipe:=FALSE;
				Recipe.State:=STATE_REMOVE_RECIPE;	
			END_IF;
		STATE_SAVE_RECIPE:
			Recipe.RecipeValues[1].Velocity:=gAxes.Ctrl.MpTransporterAxisPar.Velocity;
			Recipe.RecipeValues[1].CamProfileIndex:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].CamProfileIndex;
			Recipe.RecipeValues[1].MasterCompDistance:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterCompDistance;
			Recipe.RecipeValues[1].SlaveComDistance:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveCompDistance;
			Recipe.RecipeValues[1].MasterFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterFactor;
			Recipe.RecipeValues[1].SlaveFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveFactor;
		
			Recipe.RecipeValues[2].Velocity:=gAxes.Ctrl.MpTransporterAxisPar.Velocity;
			Recipe.RecipeValues[2].CamProfileIndex:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].CamProfileIndex;
			Recipe.RecipeValues[2].MasterCompDistance:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterCompDistance;
			Recipe.RecipeValues[2].SlaveComDistance:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveCompDistance;
			Recipe.RecipeValues[2].MasterFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor;
			Recipe.RecipeValues[2].SlaveFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor;
			
			Recipe.Ctrl.Save:=TRUE;
			IF Recipe.Ctrl.CommandDone THEN
				Recipe.Ctrl.Save:=FALSE;
				Recipe.State:=STATE_WAIT_FOR_CMD_RECIPE;
			END_IF;
		STATE_LOAD_RECIPE:
			Recipe.Ctrl.Load:=TRUE;
			IF Recipe.Ctrl.CommandDone THEN
				Recipe.Ctrl.Load:=FALSE;
				Recipe.State:=STATE_WAIT_FOR_CMD_RECIPE;
			END_IF;
		STATE_ADD_RECIPE:
			Recipe.CntOfRecipes:=Recipe.CntOfRecipes+1;
			Recipe.NameOfRecipe:='Recipe';
			itoa(Recipe.CntOfRecipes,ADR(Recipe.TempString));
			strcat(ADR(Recipe.NameOfRecipe),ADR(Recipe.TempString));
			Recipe.State:=STATE_SAVE_RECIPE;
		STATE_CHANGE_RECIPE:
			//JAK TO ZROBIC?
			Recipe.NameOfRecipe:='Recipe';
		//POLACZYC Z CHOOSEN W GUI O TYLE, TAMTO UZALEZNIC OD ILOSCI WPROWADZONYCH
		STATE_REMOVE_RECIPE:
			Recipe.FDelete.enable  := 1;
			Recipe.FDelete.pDevice := Recipe.Ctrl.DeviceName;
			Recipe.FDelete.pName   := Recipe.Ctrl.FileName;
			(* Call FBK *)
			Recipe.FDelete();

		
			

	END_CASE;
	
	Recipe.Ctrl();
	Recipe.CtrlPar();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

