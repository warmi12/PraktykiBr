
TYPE
	MachineStateType : 
		(
		STATE_INIT_MACHINE := 0,
		STATE_WAIT_FOR_CMD_MACHINE := 1,
		STATE_START_MACHINE:=2,
		STATE_STOP_MACHINE:=3,
		STATE_HOME_MACHINE := 4,
		STATE_MANUAL_MACHINE := 5,
		STATE_AUTO_MACHINE := 7,
		STATE_SERWIS_MACHINE := 8,
		STATE_ALARM_MACHINE := 9
	);	
	StatesType : 	STRUCT 
		MachineState : MachineStateType;
	END_STRUCT;

	CmdType : 	STRUCT 
		MachineCmd : MachineCmdType;
	END_STRUCT;
	
	MachineCmdType : 	STRUCT 
		Start : BOOL;
		Stop : BOOL;
		EStop : BOOL;
		Home : BOOL;
		AutoCtrl : BOOL;
		ManualCtrl : BOOL;
	END_STRUCT;

	GUIType : STRUCT
		uiShowLayer : ARRAY[0..5] OF INT;
	END_STRUCT;
	
	
	MachineCtrlType : 	STRUCT 
		States : StatesType;
		Cmd : CmdType;
		GUI : GUIType;
	END_STRUCT;
END_TYPE
