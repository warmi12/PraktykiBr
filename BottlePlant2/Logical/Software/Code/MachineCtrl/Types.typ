
TYPE
	MachineStateType : 
		(
		STATE_INIT_MACHINE := 0,
		STATE_MAIN_MACHINE := 1,
		STATE_MANUAL_MACHINE := 2,
		STATE_SERWIS_MACHINE := 3,
		STATE_ALARM_MACHINE := 4
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
		AutoControlType : BOOL;
		ManualControlType : BOOL;
	END_STRUCT;

	GUIType : STRUCT
		uiShowLayer : ARRAY[0..5] OF INT;
	END_STRUCT;
	
	AxisCamSequencerType : STRUCT
		MpAxisCamSequencer_0 : MpAxisCamSequencer;
		MpAxisCamSequencerPar_0 : MpAxisCamSequencerParType;
		
		MpAxisCamSequencer_1 : MpAxisCamSequencer;
		MpAxisCamSequencerPar_1 : MpAxisCamSequencerParType;
	END_STRUCT;
	
	MachineCtrlType : 	STRUCT 
		States : StatesType;
		Cmd : CmdType;
		GUI : GUIType;
		SequencerCtrl : AxisCamSequencerType;
	END_STRUCT;
END_TYPE
