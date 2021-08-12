
TYPE
	UserCtrlType : STRUCT
		Login : MpUserLogin;
		LoginUI : MpUserLoginUI;
		UIConnect : MpUserLoginUIConnectType;
		UserData : UserDataType;
		
		UserManagerUI : MpUserManagerUI;
		UserManagerUISetup : MpUserMgrUISetupType;
		UserManagerUIConnect : MpUserMgrUIConnectType;
		
		
	END_STRUCT;
	
	UserDataType : STRUCT
		UserNameStr : STRING;
	END_STRUCT;
	
END_TYPE
