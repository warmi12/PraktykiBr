(* AutoAxis *)

TYPE
	(* G��wny typ zawieraj�cy inne typy *)
	gAxesCtrlType : 	STRUCT 
		Ctrl : gAxisBasicCtrlType;
		Cmd : gCmdType;
		State : gStateType;
		Timers : gTimersType;
		TimersPar : gTimersParType;
	END_STRUCT;
	(* Typ zawieraj�cy bloki mpAxisBasic *)
	gAxisBasicCtrlType : 	STRUCT 
		MpTransporterAxis : MpAxisBasic;
		MpTransporterAxisPar : MpAxisBasicParType;
		MpCartAxis : MpAxisBasic;
		MpCartAxisPar : MpAxisBasicParType;
		MpPourerAxis : MpAxisBasic;
		MpPourerAxisPar : MpAxisBasicParType;
	END_STRUCT;
	(* G��wny typ komend  *)
	gCmdType : 	STRUCT 
		Auto : gAutoCmdType;
		Manual : gManualCmdType;
	END_STRUCT;
	(* Typ zawieraj�cy komendy steruj�cy silnikami w trybie automatycznym *)
	gAutoCmdType : 	STRUCT 
		Power : BOOL;
		Home : BOOL;
		Update : BOOL;
		Stop : BOOL;
		ErrorReset : BOOL;
		MoveVelocity : BOOL;
	END_STRUCT;
	(* Typ zawieraj�cy komdendy do sterowania manualnego *)
	gManualCmdType : 	STRUCT 
		TransporterHomming : BOOL;
		CartHomming : BOOL;
		PourerHomming : BOOL;
	END_STRUCT;
	gTimersType : 	STRUCT 
		HomeTimer : ARRAY[0..2]OF TON;
	END_STRUCT;
	gTimersParType : 	STRUCT 
		HomeDelayTime : REAL := 5;
	END_STRUCT;
	(* G��wny typ zawieraj�cy stany do maszyn *)
	gStateType : 	STRUCT 
		Auto : gAutoAxisStateType;
		Manual : gManualAxisStateType;
	END_STRUCT;
	gAutoAxisStateType : 
		(
		STATE_INIT_AXES := 0,
		STATE_WAIT_FOR_CMD_AXES := 1,
		STATE_POWER_ON_AXES := 2,
		STATE_HOME_AXES := 3,
		STATE_UPDATE_AXES := 4,
		STATE_MOVE_VELOCITY_AXES := 5,
		STATE_STOP_AXES := 8,
		STATE_ERROR_AXES := 10
		);
	gManualAxisStateType : 
		(
		STATE_WAIT_FOR_CMD_MANUAL := 0,
		STATE_TRANSPORTER_HOMMING := 1,
		STATE_CART_HOMMING := 2,
		STATE_POURER_HOMMING := 3
		);
END_TYPE
