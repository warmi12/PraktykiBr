
PROGRAM _INIT
	(* Insert code here *)
	Recipe.RecipeXml.Enable:=TRUE;
	Recipe.RecipeUI.Enable:=TRUE;
	Recipe.RecipeRegPar.Enable:=TRUE;
	Recipe.FileManagerUI.Enable:=TRUE;
	
	Recipe.RecipeDefaultValues[2].Velocity:=100;
	Recipe.RecipeDefaultValues[2].Height:=90;
	Recipe.RecipeDefaultValues[2].Volume:=400;
	Recipe.RecipeDefaultValues[2].MasterFactor:=215*100;
	Recipe.RecipeDefaultValues[2].SlaveFactor:=-90*100;
	
	Recipe.RecipeDefaultValues[3].Velocity:=100;
	Recipe.RecipeDefaultValues[3].Height:=65;
	Recipe.RecipeDefaultValues[3].Volume:=100;
	Recipe.RecipeDefaultValues[3].MasterFactor:=54*100;
	Recipe.RecipeDefaultValues[3].SlaveFactor:=-65*100;
	
	Recipe.RecipeDefaultValues[4].Velocity:=100;
	Recipe.RecipeDefaultValues[4].Height:=60;
	Recipe.RecipeDefaultValues[4].Volume:=0;
	Recipe.RecipeDefaultValues[4].MasterFactor:=22*100;
	Recipe.RecipeDefaultValues[4].SlaveFactor:=-60*100;
	
	(* DEFAULT FALUES FOR RECIPE *)
	gRecipeValues[2].Velocity:=Recipe.RecipeDefaultValues[2].Velocity;
	gRecipeValues[2].Height:=Recipe.RecipeDefaultValues[2].Height;
	gRecipeValues[2].Volume:=Recipe.RecipeDefaultValues[2].Volume;
	gRecipeValues[2].MasterFactor:=Recipe.RecipeDefaultValues[2].MasterFactor;
	gRecipeValues[2].SlaveFactor:=Recipe.RecipeDefaultValues[2].SlaveFactor;
	
	gRecipeValues[3].Velocity:=Recipe.RecipeDefaultValues[3].Velocity;
	gRecipeValues[3].Height:=Recipe.RecipeDefaultValues[3].Height;
	gRecipeValues[3].Volume:=Recipe.RecipeDefaultValues[3].Volume;
	gRecipeValues[3].MasterFactor:=Recipe.RecipeDefaultValues[3].MasterFactor;
	gRecipeValues[3].SlaveFactor:=Recipe.RecipeDefaultValues[3].SlaveFactor;
	
	gRecipeValues[4].Velocity:=Recipe.RecipeDefaultValues[4].Velocity;
	gRecipeValues[4].Height:=Recipe.RecipeDefaultValues[4].Height;
	gRecipeValues[4].MasterFactor:=Recipe.RecipeDefaultValues[4].MasterFactor;
	gRecipeValues[4].SlaveFactor:=Recipe.RecipeDefaultValues[4].SlaveFactor;
	
	Recipe.State:=STATE_INIT_RECIPE;
	gRecipeLoaded:=TRUE;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	Recipe.RecipeXml.MpLink:=ADR(gRecipeXml);
	Recipe.RecipeXml.DeviceName:=ADR(Recipe.RecipeData.DeviceName);
	Recipe.RecipeXml.FileName:=ADR('DefaultRecipe');
	
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
	
	Recipe.RecipeEdit.Name:=Recipe.RecipeUIConnect.Recipe.List.Names[Recipe.RecipeUIConnect.Recipe.List.SelectedIndex];
	
	(* Maszyna stanów kontroluj¹ca zapisywanie i wczytywanie z recipe do struktury  *)
	CASE Recipe.State OF
		STATE_INIT_RECIPE:
			(* Stan w którym zapisujemy domyœln¹ receptruê *)
			Recipe.RecipeXml.Save:=TRUE;
			IF Recipe.RecipeXml.CommandDone THEN
				Recipe.RecipeXml.Save:=FALSE;
				Recipe.State:=STATE_WAIT_RECIPE;
			END_IF;
			
		STATE_WAIT_RECIPE:
			(* Jesli receptura jest wczytywana, przejdz do odpowiedniego stanu  *)
			IF Recipe.RecipeUIConnect.Status=mpRECIPE_UI_STATUS_LOAD THEN
				Recipe.State:=STATE_LOAD_RECIPE;
			(* Jeœli wyskoczy³ message box prosz¹cy o potwierdzenie zapisu struktury do recipe, przejdz do odpowiedniego stanu  *)
//			ELSIF Recipe.RecipeUIConnect.MessageBox.Type=mpRECIPE_UI_MSG_CONFIRM_SAVE THEN
//				Recipe.State:=STATE_SAVE_RECIPE;
			ELSIF EDGEPOS(Recipe.Cmd.Edit) THEN
				Recipe.Cmd.Edit:=FALSE;
				Recipe.State:=STATE_EDIT_RECIPE;
			END_IF;
		STATE_LOAD_RECIPE:
			(* Jesli bloczek oczekuje na cmd tzn ¿e zosta³o wczytanie do struktury i mo¿na zaimplementowaæ zmiany ze struktury do camseq *)
			IF Recipe.RecipeUIConnect.Status=mpRECIPE_UI_STATUS_IDLE THEN
				gRecipeLoaded:=TRUE; //flaga informuj¹ca ¿e jakakolwiek receptura zosta³a waczytana
				
				(* Aktualizacja zmiennych z GUI *)
				uiRecipeBottlePerMinute := gRecipeValues[2].Velocity;
				uiRecipeBottlePerHour := gRecipeValues[2].Velocity;
				uiBottlePerHour:=gRecipeValues[2].Velocity;
				uiBottlePerMinute:=gRecipeValues[2].Velocity;
				
				(* Aktualizacja parametrów sequencera *)
				gAxes.Ctrl.MpTransporterAxisPar.Velocity:=gRecipeValues[2].Velocity;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor:=gRecipeValues[2].MasterFactor;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor:=gRecipeValues[2].SlaveFactor;
				
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].MasterFactor:=gRecipeValues[3].MasterFactor;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].SlaveFactor:=gRecipeValues[3].SlaveFactor;
				
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[4].MasterFactor:=gRecipeValues[4].MasterFactor;
				gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[4].SlaveFactor:=gRecipeValues[4].SlaveFactor;
			
				(* Update dokonanych zmian -> Update musi dokonaæ siê w odpowiednim state aby nie popsuæ pracy  *)
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
			(* Zapisanie aktualnych parametrów sequencera do struktury -> aktualizacja tylko wtedy gdy wyskoczy message box *)
			gRecipeValues[2].Velocity:=gAxes.Ctrl.MpTransporterAxisPar.Velocity;
			gRecipeValues[2].MasterFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterFactor;
			gRecipeValues[2].SlaveFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveFactor;

			gRecipeValues[3].Velocity:=gAxes.Ctrl.MpTransporterAxisPar.Velocity;
			gRecipeValues[3].MasterFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor;
			gRecipeValues[3].SlaveFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor;
		
			gRecipeValues[4].Velocity:=gAxes.Ctrl.MpTransporterAxisPar.Velocity;
			gRecipeValues[4].MasterFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].MasterFactor;
			gRecipeValues[4].SlaveFactor:=gCamSequencer.Ctrl.MpAxisCamSequencerPar_1.Configuration.State[3].SlaveFactor;
			
			Recipe.State:=STATE_WAIT_RECIPE;
		
		STATE_EDIT_RECIPE:
			Recipe.RecipeEdit.Height3:=215-(Recipe.RecipeEdit.Height1 + Recipe.RecipeEdit.Height2 );
			Recipe.RecipeEdit.Distance3:=Recipe.RecipeEdit.Height3/2.75; (* Wspó³czynnik wziêty ze stosunku przebytej drogi do odleglosci na ktora zjezdza nalewak *)
			Recipe.RecipeEdit.Factor:=(290-Recipe.RecipeEdit.Distance3)/(Recipe.RecipeEdit.Volume1+Recipe.RecipeEdit.Volume2);
			Recipe.RecipeEdit.Distance1:=Recipe.RecipeEdit.Factor*Recipe.RecipeEdit.Volume1;
			Recipe.RecipeEdit.Distance2:=Recipe.RecipeEdit.Factor*Recipe.RecipeEdit.Volume2;
		
			gRecipeValues[2].Velocity:=Recipe.RecipeEdit.BottlePerMinute;
			gRecipeValues[2].MasterFactor:=REAL_TO_DINT(Recipe.RecipeEdit.Distance1)*100;
			gRecipeValues[2].SlaveFactor:=REAL_TO_DINT(-Recipe.RecipeEdit.Height1)*100;
			gRecipeValues[2].Height:=Recipe.RecipeEdit.Height1;
			gRecipeValues[2].Volume:=Recipe.RecipeEdit.Volume1;

			gRecipeValues[3].Velocity:=Recipe.RecipeEdit.BottlePerMinute;
			gRecipeValues[3].MasterFactor:=REAL_TO_DINT(Recipe.RecipeEdit.Distance2)*100;
			gRecipeValues[3].SlaveFactor:=REAL_TO_DINT(-Recipe.RecipeEdit.Height2)*100;
			gRecipeValues[3].Height:=Recipe.RecipeEdit.Height2;
			gRecipeValues[3].Volume:=Recipe.RecipeEdit.Volume2;
	
			gRecipeValues[4].Velocity:=Recipe.RecipeEdit.BottlePerMinute;
			gRecipeValues[4].MasterFactor:=REAL_TO_DINT(Recipe.RecipeEdit.Distance3)*100;
			gRecipeValues[4].SlaveFactor:=REAL_TO_DINT(-Recipe.RecipeEdit.Height3)*100;
		
			Recipe.RecipeUIConnect.Recipe.Save:=TRUE;
			Recipe.RecipeUIConnect.Recipe.Refresh:=FALSE;
			IF Recipe.RecipeUIConnect.MessageBox.LayerStatus=0 THEN
				Recipe.RecipeUIConnect.Recipe.Save:=FALSE;
				Recipe.State:=STATE_WAIT_RECIPE;
			END_IF;
			
			
			(* Do zrobienia zapamietanie indexu zaznaczonego poniewaz po zapisie wybrany index wraca na 0 *)
			(* Tez popup *) (* albo dorobiæ zeby wychodzu³o i tyle i popup ze nalezy wczytac  *)
//			Recipe.RecipeXml.FileName:=ADR(Recipe.RecipeUIConnect.Recipe.List.Names[Recipe.RecipeUIConnect.Recipe.List.SelectedIndex]);
//			Recipe.RecipeXml.Save:=TRUE;
//			IF Recipe.RecipeXml.CommandDone THEN
//				Recipe.RecipeXml.Save:=FALSE;
//				Recipe.State:=STATE_WAIT_RECIPE;
//			END_IF;
	END_CASE;
	
	Recipe.RecipeXml();
	Recipe.RecipeRegPar();
	Recipe.RecipeUI();
	Recipe.FileManagerUI();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

