
TYPE
	RecipeCtrlType : STRUCT
		Ctrl : MpRecipeXml;
		CtrlPar : MpRecipeRegPar;
		RecipeValues : ARRAY[1..2] OF RecipeValuesType;
		CntOfRecipes : DINT;
		TempString : STRING;
		NameOfRecipe : STRING :='Recipe0';
		ChoosenRecipe : STRING;
		Cmd : RecipeCmdType;
		State : RecipeStateType;
		FDelete : FileDelete;
	END_STRUCT;
	
	RecipeValuesType : STRUCT
		Velocity : REAL;
		CamProfileIndex : UINT;
		MasterCompDistance : REAL;
		SlaveComDistance : REAL;
		MasterFactor : DINT;
		SlaveFactor : DINT;
	END_STRUCT;
	
	RecipeCmdType : STRUCT
		Load : BOOL;
		Save : BOOL;
		ChangeRecipe : BOOL;
		AddRecipe : BOOL;
		RemoveRecipe : BOOL;
	END_STRUCT;
	
	RecipeStateType :
		(
		STATE_INIT_RECIPE := 0,
		STATE_LOAD_RECIPE := 1,
		STATE_SAVE_RECIPE :=2,
		STATE_WAIT_FOR_CMD_RECIPE:=3,
		STATE_CHANGE_RECIPE :=4,
		STATE_ADD_RECIPE:=5,
		STATE_REMOVE_RECIPE:=6
	);
	
END_TYPE
