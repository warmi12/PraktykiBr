
PROGRAM _INIT
	(* Insert code here *)
	UserCtrl.Login.Enable:=TRUE;
	UserCtrl.LoginUI.Enable:=TRUE;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	UserCtrl.Login.MpLink:=ADR(gUserLogin);
	UserCtrl.LoginUI.MpLink:=ADR(gUserLogin);
	UserCtrl.LoginUI.UIConnect:=ADR(UserCtrl.UIConnect);
	UserCtrl.Login.UserName:=ADR(UserCtrl.UserData.UserName);
	UserCtrl.Login.Password:=ADR(UserCtrl.UserData.UserPasswd);
	gCurrentUser:=UserCtrl.Login.CurrentLevel;
	UserCtrl.UserData.UserNameStr:=WSTRING_TO_STRING(UserCtrl.Login.CurrentUser);
	UserCtrl.Login();
	UserCtrl.LoginUI();	 
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

