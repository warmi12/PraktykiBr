	
PROGRAM _INIT
	(* Insert code here *)
	UserCtrl.Login.Enable:=TRUE;
	UserCtrl.LoginUI.Enable:=TRUE;
	UserCtrl.UserManagerUI.Enable:=TRUE;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	UserCtrl.Login.MpLink:=ADR(gUserLogin);
	UserCtrl.LoginUI.MpLink:=ADR(gUserLogin);
	UserCtrl.UserManagerUI.MpLink:=ADR(gUserLogin);
	
	UserCtrl.LoginUI.UIConnect:=ADR(UserCtrl.UIConnect);
	UserCtrl.UserManagerUI.UIConnect:=ADR(UserCtrl.UserManagerUIConnect);
	UserCtrl.UserManagerUI.UISetup:=UserCtrl.UserManagerUISetup;
	
	gCurrentUser:=UserCtrl.Login.CurrentLevel; // przekazanie lvl do g³ownego programu
	UserCtrl.Login.Logout:=gLogOutUser; //przekazanie z machineCtrl zmiennej która ustawia wylogowanie na TRUE
	UserCtrl.UserData.UserNameStr:=WSTRING_TO_STRING(UserCtrl.Login.CurrentUser);
	UserCtrl.Login();
	UserCtrl.LoginUI();	 
	UserCtrl.UserManagerUI();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

