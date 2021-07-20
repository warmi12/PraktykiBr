(* AutoAxis *)
TYPE
	gAxesCtrlType : 	STRUCT 
		Ctrl : gAxisBasicCtrlType;
		Cmd : gCmdType;
		State : gAutoAxisStateType;
		Timers : gTimersType;
		TimersPar : gTimersParType;
	END_STRUCT;
	gAxisBasicCtrlType : 	STRUCT 
		MpTransporterAxis : MpAxisBasic;
		MpTransporterAxisPar : MpAxisBasicParType;
		MpCartAxis : MpAxisBasic;
		MpCartAxisPar : MpAxisBasicParType;
		MpPourerAxis : MpAxisBasic;
		MpPourerAxisPar : MpAxisBasicParType;
	END_STRUCT;
	gCmdType : 	STRUCT 
		Power : BOOL;
		Home : BOOL;
		Update : BOOL;
		Stop : BOOL;
		ErrorReset : BOOL;
		MoveVelocity : BOOL;
		MoveAdditive : BOOL;
		MoveAbsolute : BOOL;
	END_STRUCT;
	
	gTimersType : STRUCT
		PowerTimer : ARRAY[0..2] OF TON;
		HomeTimer : ARRAY[0..2] OF TON;
	END_STRUCT;
	
	gTimersParType : STRUCT
		PowerDelayTime : REAL :=5;
		HomeDelayTime : REAL :=5;
	END_STRUCT;
	
	gAutoAxisStateType : 
		(
		STATE_INIT_AXES := 0,
		STATE_WAIT_FOR_CMD_AXES := 1,
		STATE_POWER_ON_AXES := 2,
		STATE_HOME_AXES := 3,
		STATE_UPDATE_AXES := 4,
		STATE_MOVE_VELOCITY_AXES := 5,
		STATE_MOVE_ABSOLUTE_AXES := 6,
		STATE_MOVE_ADDITIVE_AXES := 7,
		STATE_STOP_AXES := 8,
		STATE_ERROR_AXES := 10
	);
END_TYPE
