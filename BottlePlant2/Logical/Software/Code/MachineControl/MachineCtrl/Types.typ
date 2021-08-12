
TYPE
	MachineStateType : 
		(
		STATE_INIT_MACHINE := 0,
		STATE_WAIT_FOR_CMD_MACHINE := 1,
		STATE_START_MACHINE:=2,
		STATE_STOP_MACHINE:=3,
		STATE_MANUAL_MACHINE := 4,
		STATE_AUTO_MACHINE := 5,
		STATE_ESTOP_MACHINE:=6,
		STATE_ERROR_MACHINE :=7,
		STATE_HOME_TRANSPORTER_MACHINE :=8,
		STATE_HOME_CART_MACHINE := 9,
		STATE_HOME_POURER_MACHINE := 10,
		STATE_UPDATE_SPEED_MACHINE :=11,
		STATE_LOGOUT_MACHINE:=12,
		STATE_LOGIN_MACHINE:=13
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
		UpdateSpeed : BOOL;
		LogOut : BOOL;
		ErrorReset : BOOL;
	END_STRUCT;

	GUIType : STRUCT
		uiShowLayer : ARRAY[0..5] OF INT;  
		uiShowPage : INT;
		uiCurrentPage : INT;
		uiCounterBottle : INT;
		uiConfirm : BOOL;
		uiRefuse : BOOL;
		uiAlarmStatus : BOOL;
	END_STRUCT;
	
	MachineCtrlType : 	STRUCT 
		Timer : TON;
		Status : STRING;
		States : StatesType;
		Cmd : CmdType;
		GUI : GUIType;
	END_STRUCT;
	
END_TYPE
