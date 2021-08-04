TYPE
	gCamSequencerStateType : 
		(
		STATE_ERROR_SEQUENCER:=1,
		STATE_WAIT_FOR_CMD_SEQUENCER:=0
	);
	
	gCamSequencerCmdType : STRUCT
		ErrorReset : BOOL;  
	END_STRUCT;
	
	gCamSequencerCtrlType : STRUCT
		Ctrl : gCamSequencerBasicCtrlType;
		State : gCamSequencerStateType;
		Cmd : gCamSequencerCmdType;
	END_STRUCT;
	
	gCamSequencerBasicCtrlType : STRUCT
		MpAxisCamSequencer_0 : MpAxisCamSequencer;
		MpAxisCamSequencerPar_0 : MpAxisCamSequencerParType;
		MpAxisCamSequencer_1 : MpAxisCamSequencer;
		MpAxisCamSequencerPar_1 : MpAxisCamSequencerParType;
	END_STRUCT;
		  
END_TYPE
