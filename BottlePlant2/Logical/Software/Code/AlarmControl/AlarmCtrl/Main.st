
PROGRAM _INIT
	(* Insert code here *)
	Alarm.AlarmBasic.Enable:=TRUE;
	Alarm.AlarmBasicUI.Enable:=TRUE;
	Alarm.UserAlarmBasicUI.Enable:=TRUE;
	Alarm.RecipeAlarmBasicUI.Enable:=TRUE;
	Alarm.MyAlarmBasicUI.Enable:=TRUE;
	Alarm.AlarmRegUser.Enable:=TRUE;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	Alarm.AlarmBasic.MpLink:=ADR(gAlarmBasic);
	Alarm.AlarmBasicUI.MpLink:=ADR(gTranAxisCfg);
	Alarm.UserAlarmBasicUI.MpLink:=ADR(gUserLogin);
	Alarm.RecipeAlarmBasicUI.MpLink:=ADR(gRecipeXml);
	
	Alarm.AlarmBasicUI.Mode:=mpALARM_BASIC_UI_MODE_ALL;
	Alarm.AlarmBasicUI.UISetup.AcknowledgeImage:=ADR(Alarm.AxisAlarm.AcknowledgeImage[0]);
	Alarm.AlarmBasicUI.UISetup.AlarmImage:=ADR(Alarm.AxisAlarm.AlarmImage[0]);
	Alarm.AlarmBasicUI.UISetup.ImageSize:=SIZEOF(Alarm.AxisAlarm.AlarmImage)/SIZEOF(Alarm.AxisAlarm.AlarmImage[0]);
	Alarm.AlarmBasicUI.UISetup.AddInfo:=ADR(Alarm.AxisAlarm.AddInfo[0]);
	Alarm.AlarmBasicUI.UISetup.AddInfoStringSize:=SIZEOF(Alarm.AxisAlarm.AddInfo[0]);
	
	Alarm.UserAlarmBasicUI.Mode:=mpALARM_BASIC_UI_MODE_ALL;
	Alarm.UserAlarmBasicUI.UISetup.AcknowledgeImage:=ADR(Alarm.UserAlarm.AcknowledgeImage[0]);
	Alarm.UserAlarmBasicUI.UISetup.AlarmImage:=ADR(Alarm.UserAlarm.AlarmImage[0]);
	Alarm.UserAlarmBasicUI.UISetup.ImageSize:=SIZEOF(Alarm.UserAlarm.AlarmImage)/SIZEOF(Alarm.UserAlarm.AlarmImage[0]);
	Alarm.UserAlarmBasicUI.UISetup.AddInfo:=ADR(Alarm.UserAlarm.AddInfo[0]);
	Alarm.UserAlarmBasicUI.UISetup.AddInfoStringSize:=SIZEOF(Alarm.UserAlarm.AddInfo[0]);
	
	Alarm.RecipeAlarmBasicUI.Mode:=mpALARM_BASIC_UI_MODE_ALL;
	Alarm.RecipeAlarmBasicUI.UISetup.AcknowledgeImage:=ADR(Alarm.RecipeAlarm.AcknowledgeImage[0]);
	Alarm.RecipeAlarmBasicUI.UISetup.AlarmImage:=ADR(Alarm.RecipeAlarm.AlarmImage[0]);
	Alarm.RecipeAlarmBasicUI.UISetup.ImageSize:=SIZEOF(Alarm.RecipeAlarm.AlarmImage)/SIZEOF(Alarm.RecipeAlarm.AlarmImage[0]);
	Alarm.RecipeAlarmBasicUI.UISetup.AddInfo:=ADR(Alarm.RecipeAlarm.AddInfo[0]);
	Alarm.RecipeAlarmBasicUI.UISetup.AddInfoStringSize:=SIZEOF(Alarm.RecipeAlarm.AddInfo[0]);
	
	Alarm.MyAlarmBasicUI.MpLink:=ADR(gAlarmBasic);
	Alarm.MyAlarmBasicUI.Mode:=mpALARM_BASIC_UI_MODE_USER;
	Alarm.MyAlarmBasicUI.UISetup.AcknowledgeImage:=ADR(Alarm.MyAlarm.AcknowledgeImage[0]);
	Alarm.MyAlarmBasicUI.UISetup.AlarmImage:=ADR(Alarm.MyAlarm.AlarmImage[0]);
	Alarm.MyAlarmBasicUI.UISetup.ImageSize:=SIZEOF(Alarm.MyAlarm.AlarmImage)/SIZEOF(Alarm.MyAlarm.AlarmImage[0]);
	Alarm.MyAlarmBasicUI.UISetup.AddInfo:=ADR(Alarm.MyAlarm.AddInfo[0]);
	Alarm.MyAlarmBasicUI.UISetup.AddInfoStringSize:=SIZEOF(Alarm.MyAlarm.AddInfo[0]);
	
	
	Alarm.AlarmRegUser.MpLink:=ADR(gAlarmBasic);
	Alarm.AlarmRegUser.NumberOfAlarms:=2;
	//Alarm.AlarmRegUser.mode
	
	//Alarm.
	
	
	Alarm.AlarmBasic();
	Alarm.AlarmBasicUI();
	Alarm.UserAlarmBasicUI();
	Alarm.RecipeAlarmBasicUI();	
	Alarm.AlarmRegUser();
	Alarm.MyAlarmBasicUI();
END_PROGRAM
	
PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

