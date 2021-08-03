TYPE
	gCamSequencerStateType : 
		(
		STATE_INIT_SEQUENCER:=0,
		STATE_LOAD_SEQUENCER:=1,
		STATE_SAVE_SEQUENCER:=2
	);
	
	gCamSequencerCtrlType : STRUCT
		Ctrl : gCamSequencerBasicCtrlType;
		State : gCamSequencerStateType;
	END_STRUCT;
	
	gCamSequencerBasicCtrlType : STRUCT
		MpAxisCamSequencer_0 : MpAxisCamSequencer;
		MpAxisCamSequencerPar_0 : MpAxisCamSequencerParType;
		MpAxisCamSequencer_1 : MpAxisCamSequencer;
		MpAxisCamSequencerPar_1 : MpAxisCamSequencerParType;
	END_STRUCT;
		  
END_TYPE
