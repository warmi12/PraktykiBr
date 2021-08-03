
TYPE
	RecipeCtrlType : STRUCT
		RecipeXml : MpRecipeXml;
		RecipeRegPar : MpRecipeRegPar;
		RecipeUI : MpRecipeUI;
		RecipeUISetup : MpRecipeUISetupType;
		RecipeUIConnect : MpRecipeUIConnectType;
		RecipeData : RecipeDataType;
		FileManagerUI : MpFileManagerUI;
		FileManagerSetup : MpFileManagerUISetupType;
		FileManagerUIConnect : MpFileManagerUIConnectType;
		State : RecipeState;
		Cmd : RecipeCmdType;
	END_STRUCT;
	
	RecipeDataType : STRUCT
		DeviceName : STRING[20] := 'USER';
		FileName : STRING[20]:='MyRecipe';
	END_STRUCT;
	
	RecipeCmdType : STRUCT
		Load : BOOL;
		Save : BOOL;
	END_STRUCT;
	
	RecipeState :
		(
		STATE_LOAD_RECIPE := 2,
		STATE_SAVE_RECIPE := 1,
		STATE_WAIT_RECIPE :=0
	);
	
	
END_TYPE
