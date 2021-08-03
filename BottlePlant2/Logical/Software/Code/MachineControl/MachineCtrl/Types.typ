
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
		STATE_RECIPE_MACHINE :=8,
		STATE_SERVICE_MACHINE := 9,
		STATE_ESTOP_MACHINE:=10,
		STATE_ALARM_MACHINE := 11,
		STATE_ERROR_MACHINE :=12,
		STATE_HOME_TRANSPORTER_MACHINE := 13,
		STATE_HOME_CART_MACHINE := 14,
		STATE_HOME_POURER_MACHINE := 15,
		STATE_UPDATE_SPEED_MACHINE :=16
	);	
	
	MachineStatusType : 
		(
		INITIAL:= 0,
		HOMMING:=1,
		ERROR:=2,
		AUTOWORKING:=3,
		MANUALWORKING:=4,
		STOP:=5,
		WAITING:=6
		
	);	
	
	StatesType : 	STRUCT 
		MachineState : MachineStateType;
	END_STRUCT;

	CmdType : 	STRUCT 
		MachineCmd : MachineCmdType;
	END_STRUCT;
	
	MachineCmdType : STRUCT 
		Start : BOOL;
		Stop : BOOL;
		EStop : BOOL;
		HomeTransporter : BOOL;
		HomeCart : BOOL;
		HomePourer : BOOL;
		AutoCtrl : BOOL;
		ManualCtrl : BOOL;
		Recipe : BOOL;
		Service : BOOL;
		Alarm : BOOL;
		UpdateSpeed : BOOL;
	END_STRUCT;

	GUIType : STRUCT
		uiShowLayer : ARRAY[0..5] OF INT;  
		uiShowPage : INT;
		uiCurrentPage : INT;
		uiCounterBottle : INT;
	END_STRUCT;
	
	MachineCtrlType : 	STRUCT 
		Status : STRING;
		States : StatesType;
		Cmd : CmdType;
		GUI : GUIType;
	END_STRUCT;
	
END_TYPE
