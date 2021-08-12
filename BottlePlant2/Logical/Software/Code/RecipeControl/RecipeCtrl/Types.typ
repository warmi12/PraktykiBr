
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
		RecipeEdit : RecipeEditType;
		RecipeDefaultValues : ARRAY[2..4] OF RecipeDefaultValuesType;
	END_STRUCT;
	
	RecipeDefaultValuesType : STRUCT
		Velocity : REAL;
		Height : REAL;
		Volume : REAL;
		MasterFactor : DINT;
		SlaveFactor : DINT;
	END_STRUCT;
	
	RecipeDataType : STRUCT
		DeviceName : STRING[20] := 'RecipeFile';
		FileName : STRING[20]:='MyRecipe';
	END_STRUCT;
	
	RecipeCmdType : STRUCT
		Load : BOOL;
		Save : BOOL;
		Edit : BOOL;
		SaveEdit : BOOL;
	END_STRUCT;
	
	RecipeEditType : STRUCT
		Height1 : REAL;
		Height2 : REAL;
		Height3 : REAL;
		Volume1 : REAL;
		Volume2 : REAL;
		BottlePerMinute : REAL;
		Factor : REAL;
		Distance1 : REAL;
		Distance2 : REAL;
		Distance3 : REAL;
		Name : STRING;
	END_STRUCT;
	
	RecipeState :
		(
		STATE_LOAD_RECIPE := 2,
		STATE_SAVE_RECIPE := 1,
		STATE_EDIT_RECIPE := 5,
		STATE_INIT_RECIPE :=4,
		STATE_WAIT_RECIPE :=0
	);
	
	
END_TYPE
