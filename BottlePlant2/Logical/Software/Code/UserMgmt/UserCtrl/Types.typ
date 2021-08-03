
TYPE
	UserCtrlType : STRUCT
		Login : MpUserLogin;
		LoginUI : MpUserLoginUI;
		UIConnect : MpUserLoginUIConnectType;
		UserData : UserDataType;
	END_STRUCT;
	
	UserDataType : STRUCT
		UserName : WSTRING[20];
		UserNameStr : STRING;
		UserPasswd : WSTRING[20];
	END_STRUCT;
	
END_TYPE
