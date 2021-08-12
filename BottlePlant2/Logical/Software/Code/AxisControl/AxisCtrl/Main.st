
PROGRAM _INIT
	(* Insert code here *)
	gAxes.State.Auto:=STATE_INIT_AXES;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	gAxes.Ctrl.MpTransporterAxis.MpLink:=ADR(gTranAxisCfg);
	gAxes.Ctrl.MpTransporterAxis.Parameters:=ADR(gAxes.Ctrl.MpTransporterAxisPar);
	gAxes.Ctrl.MpTransporterAxis.Axis:=ADR(gTranAxis);
	
	gAxes.Ctrl.MpCartAxis.MpLink:=ADR(gCartAxisCfg);
	gAxes.Ctrl.MpCartAxis.Parameters:=ADR(gAxes.Ctrl.MpCartAxisPar);
	gAxes.Ctrl.MpCartAxis.Axis:=ADR(gCartAxis);
	
	gAxes.Ctrl.MpPourerAxis.MpLink:=ADR(gPourAxisCfg);
	gAxes.Ctrl.MpPourerAxis.Parameters:=ADR(gAxes.Ctrl.MpPourerAxisPar);
	gAxes.Ctrl.MpPourerAxis.Axis:=ADR(gPourAxis);
	
	(* Warunki sprawdzaj¹ce na której osi wystêpuje error *)
	IF gAxes.Ctrl.MpTransporterAxis.Error THEN
		//alarm osi transporter
		gAxes.State.Auto:=STATE_ERROR_AXES;
	END_IF
	IF gAxes.Ctrl.MpCartAxis.Error THEN
		//alarm osi wozka
		gAxes.State.Auto:=STATE_ERROR_AXES;
	END_IF
	IF gAxes.Ctrl.MpPourerAxis.Error THEN
		//alarm nalewaka
		gAxes.State.Auto:=STATE_ERROR_AXES;
	END_IF
	
	(* G³ówna maszyna stanów osi *)
	CASE gAxes.State.Auto OF
		(* Stan inicjalizacyjny -> uruchomienie bloków, podstawowe parametry, przejscie dalej *)
		STATE_INIT_AXES:
			//MpAlarmSet(gAlarmBasic,0,'k');
			gAxes.Ctrl.MpTransporterAxis.Enable:=TRUE;
			gAxes.Ctrl.MpCartAxis.Enable:=TRUE;
			gAxes.Ctrl.MpPourerAxis.Enable:=TRUE;
			
			gAxes.Ctrl.MpTransporterAxisPar.Acceleration:=500;
			gAxes.Ctrl.MpCartAxisPar.Acceleration:=500;
			gAxes.Ctrl.MpPourerAxisPar.Acceleration:=500;
			
			gAxes.Ctrl.MpTransporterAxisPar.Deceleration:=500;
			gAxes.Ctrl.MpCartAxisPar.Deceleration:=500;
			gAxes.Ctrl.MpPourerAxisPar.Deceleration:=500;
			
			gAxes.Ctrl.MpTransporterAxisPar.Velocity:=100;
			gAxes.Ctrl.MpCartAxisPar.Velocity:=100;
			gAxes.Ctrl.MpPourerAxisPar.Velocity:=100;
			
			(* Jesli bloki aktywne przejdz do w³¹czenia zasilania *)
			IF gAxes.Ctrl.MpTransporterAxis.Active AND gAxes.Ctrl.MpCartAxis.Active AND gAxes.Ctrl.MpPourerAxis.Active THEN
				gAxes.State.Auto:=STATE_POWER_ON_AXES;
			END_IF;
		STATE_WAIT_FOR_CMD_AXES:
			IF EDGEPOS(gAxes.Cmd.Auto.Power) THEN
				gAxes.Cmd.Auto.Power:=FALSE;
				gAxes.State.Auto:=STATE_POWER_ON_AXES;
			ELSIF EDGEPOS(gAxes.Cmd.Auto.Home) THEN
				gAxes.Cmd.Auto.Home:=FALSE;
				gAxes.State.Auto:=STATE_HOME_AXES;
			ELSIF EDGEPOS(gAxes.Cmd.Auto.Update) THEN
				gAxes.Cmd.Auto.Update:=FALSE;
				gAxes.State.Auto:=STATE_UPDATE_AXES;
			ELSIF EDGEPOS(gAxes.Cmd.Auto.Stop) THEN
				gAxes.Cmd.Auto.Stop:=FALSE;
				gAxes.State.Auto:=STATE_STOP_AXES;
			ELSIF EDGEPOS(gAxes.Cmd.Auto.ErrorReset) THEN
				gAxes.Cmd.Auto.ErrorReset:=FALSE;
			ELSIF EDGEPOS(gAxes.Cmd.Auto.MoveVelocity) THEN
				gAxes.Cmd.Auto.MoveVelocity:=FALSE;
				gAxes.State.Auto:=STATE_MOVE_VELOCITY_AXES;	
			END_IF;				
		STATE_POWER_ON_AXES:
			gAxes.Ctrl.MpTransporterAxis.Power:=TRUE;
			gAxes.Ctrl.MpCartAxis.Power:=TRUE;
			gAxes.Ctrl.MpPourerAxis.Power:=TRUE;
		
			IF gAxes.Ctrl.MpTransporterAxis.PowerOn AND gAxes.Ctrl.MpCartAxis.PowerOn AND gAxes.Ctrl.MpPourerAxis.PowerOn THEN
				gAxes.State.Auto:=STATE_WAIT_FOR_CMD_AXES;
			END_IF;

		STATE_HOME_AXES:
			(* Automatyczne bazowanie wszystkich osi po kolei  *)
			gAxes.Ctrl.MpTransporterAxis.Home:=TRUE;
			gAxes.Ctrl.MpCartAxis.Home:=gAxes.Ctrl.MpTransporterAxis.IsHomed;
			gAxes.Ctrl.MpPourerAxis.Home:=gAxes.Ctrl.MpCartAxis.IsHomed;
			
			(* Wykorzystanie zegarkow do sprawdzenia czy zadana oœ zosta³a zbazowana w odpowiednim czasie *)
			gAxes.Timers.HomeTimer[0].IN:=NOT(gAxes.Ctrl.MpTransporterAxis.IsHomed);
			gAxes.Timers.HomeTimer[0].PT:=REAL_TO_TIME(gAxes.TimersPar.HomeDelayTime*1000);
			gAxes.Timers.HomeTimer[0]();
			
			gAxes.Timers.HomeTimer[1].IN:=gAxes.Ctrl.MpTransporterAxis.IsHomed AND NOT(gAxes.Ctrl.MpCartAxis.IsHomed);
			gAxes.Timers.HomeTimer[1].PT:=REAL_TO_TIME(gAxes.TimersPar.HomeDelayTime*1000);
			gAxes.Timers.HomeTimer[1]();
			
			gAxes.Timers.HomeTimer[2].IN:=gAxes.Ctrl.MpCartAxis.IsHomed AND NOT(gAxes.Ctrl.MpPourerAxis.IsHomed);
			gAxes.Timers.HomeTimer[2].PT:=REAL_TO_TIME(gAxes.TimersPar.HomeDelayTime*1000);
			gAxes.Timers.HomeTimer[2]();
			
			IF gAxes.Timers.HomeTimer[0].Q THEN
				gAxes.Timers.HomeTimer[0].IN:=FALSE;
				gAxes.Timers.HomeTimer[0]();
				//zbyt dlugie bazowanie osi transportra alarm
				gAxes.State.Auto:=STATE_ERROR_AXES;
			END_IF;
			
			IF gAxes.Timers.HomeTimer[1].Q THEN
				gAxes.Timers.HomeTimer[1].IN:=FALSE;
				gAxes.Timers.HomeTimer[1]();
				//zbyt dlugie bazowanie osi wozka alarm
				gAxes.State.Auto:=STATE_ERROR_AXES;
			END_IF;
			
			IF gAxes.Timers.HomeTimer[2].Q THEN
				gAxes.Timers.HomeTimer[2].IN:=FALSE;
				gAxes.Timers.HomeTimer[2]();
				//zbyt dlugie bazowanie osi nalewaka alarm
				gAxes.State.Auto:=STATE_ERROR_AXES;
			END_IF;
			
			(* Sprawdzenie czy wszystkie osie zosta³y zbazowane *)
			IF gAxes.Ctrl.MpTransporterAxis.IsHomed AND gAxes.Ctrl.MpCartAxis.IsHomed AND gAxes.Ctrl.MpPourerAxis.IsHomed THEN
				gAxes.Ctrl.MpTransporterAxis.Home:=FALSE;
				gAxes.Ctrl.MpCartAxis.Home:=FALSE;
				gAxes.Ctrl.MpPourerAxis.Home:=FALSE;
				gAxes.State.Auto:=STATE_WAIT_FOR_CMD_AXES;  //przejscie do stanu gotowosci i oczekiwanie na komendy
				gAxes.Timers.HomeTimer[0].IN:=FALSE;
				gAxes.Timers.HomeTimer[0]();
				gAxes.Timers.HomeTimer[1].IN:=FALSE;
				gAxes.Timers.HomeTimer[1]();
				gAxes.Timers.HomeTimer[2].IN:=FALSE;
				gAxes.Timers.HomeTimer[2]();
			END_IF;
		STATE_STOP_AXES:
			(* Sprawdzenie czy jes wlaczony silnik jesi tak to stop -> wywo³anie .stop na wy³¹czonym zasilaniu generuje b³¹d *)
			//warning stop
			IF gAxes.Ctrl.MpTransporterAxis.PowerOn THEN
				gAxes.Ctrl.MpTransporterAxis.Stop:=TRUE;
			END_IF;
			
			IF gAxes.Ctrl.MpCartAxis.PowerOn THEN
				gAxes.Ctrl.MpCartAxis.Stop:=TRUE;
			END_IF;
			
			IF gAxes.Ctrl.MpPourerAxis.PowerOn THEN
				gAxes.Ctrl.MpPourerAxis.Stop:=TRUE;
			END_IF;
			
			IF gAxes.Ctrl.MpTransporterAxis.Stopped AND gAxes.Ctrl.MpCartAxis.Stopped AND gAxes.Ctrl.MpPourerAxis.Stopped THEN
				gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=FALSE;
				gAxes.Ctrl.MpCartAxis.MoveVelocity:=FALSE;
				gAxes.Ctrl.MpPourerAxis.MoveVelocity:=FALSE;
				gAxes.Ctrl.MpTransporterAxis.Stop:=FALSE;
				gAxes.Ctrl.MpCartAxis.Stop:=FALSE;
				gAxes.Ctrl.MpPourerAxis.Stop:=FALSE;
				gAxes.State.Auto:=STATE_WAIT_FOR_CMD_AXES;
			END_IF;
		STATE_UPDATE_AXES:
			gAxes.Ctrl.MpTransporterAxis.Update:=TRUE;
			gAxes.Ctrl.MpCartAxis.Update:=TRUE;
			gAxes.Ctrl.MpPourerAxis.Update:=TRUE;
			
			IF gAxes.Ctrl.MpTransporterAxis.UpdateDone AND gAxes.Ctrl.MpCartAxis.UpdateDone AND gAxes.Ctrl.MpPourerAxis.UpdateDone THEN
				gAxes.State.Auto:=STATE_WAIT_FOR_CMD_AXES;
				gAxes.Ctrl.MpTransporterAxis.Update:=FALSE;
				gAxes.Ctrl.MpCartAxis.Update:=FALSE;
				gAxes.Ctrl.MpPourerAxis.Update:=FALSE;
			END_IF;
		STATE_MOVE_VELOCITY_AXES:
			gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=TRUE;
			gAxes.State.Auto:=STATE_WAIT_FOR_CMD_AXES;
		STATE_ERROR_AXES:
			(* Zatrzymanie wszystkich silnikow *)
			gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=FALSE;
			gAxes.Ctrl.MpCartAxis.MoveVelocity:=FALSE;
			gAxes.Ctrl.MpPourerAxis.MoveVelocity:=FALSE;
			gAxes.Ctrl.MpTransporterAxis.Power:=FALSE;
			gAxes.Ctrl.MpCartAxis.Power:=FALSE;
			gAxes.Ctrl.MpPourerAxis.Power:=FALSE;
			
			(* Czekamy na cmd reseterror *)
			IF EDGEPOS(gAxes.Cmd.Auto.ErrorReset) THEN
				gAxes.Cmd.Auto.ErrorReset:=FALSE;
				gAxes.Ctrl.MpTransporterAxis.ErrorReset:=TRUE;
				gAxes.Ctrl.MpCartAxis.ErrorReset:=TRUE;
				gAxes.Ctrl.MpPourerAxis.ErrorReset:=TRUE;
				//power na false a pozniej true do sprawdzenia
			END_IF;
			
			(* Jeœli wszystkie b³êdy zosta³y usuniête mo¿emy przejœæ do stanu w kótrym czekamy na cmd *)
			IF NOT(gAxes.Ctrl.MpTransporterAxis.Error) AND NOT(gAxes.Ctrl.MpCartAxis.Error) AND NOT(gAxes.Ctrl.MpPourerAxis.Error) THEN
				gAxes.Ctrl.MpTransporterAxis.ErrorReset:=FALSE;
				gAxes.Ctrl.MpCartAxis.ErrorReset:=FALSE;
				gAxes.Ctrl.MpPourerAxis.ErrorReset:=FALSE;
				
				gAxes.Cmd.Auto.Power:=TRUE;
				gAxes.State.Auto:=STATE_WAIT_FOR_CMD_AXES;
			END_IF
	END_CASE;
	
	(* Maszyna stanów, u³atwiaj¹ca zarz¹dzanie osiami w trybie manualnym *)
	CASE gAxes.State.Manual OF
		STATE_WAIT_FOR_CMD_MANUAL:
			IF EDGEPOS(gAxes.Cmd.Manual.TransporterHomming) THEN
				gAxes.Cmd.Manual.TransporterHomming:=FALSE;
				gAxes.State.Manual:=STATE_TRANSPORTER_HOMMING;
			ELSIF EDGEPOS(gAxes.Cmd.Manual.CartHomming)  THEN
				gAxes.Cmd.Manual.CartHomming:=FALSE;
				gAxes.State.Manual:=STATE_CART_HOMMING;
			ELSIF EDGEPOS(gAxes.Cmd.Manual.PourerHomming) THEN
				gAxes.Cmd.Manual.PourerHomming:=FALSE;
				gAxes.State.Manual:=STATE_POURER_HOMMING;
			END_IF;
		STATE_TRANSPORTER_HOMMING:
			gAxes.Ctrl.MpTransporterAxis.Home:=TRUE;
			gAxes.Timers.HomeTimer[0].IN:=NOT(gAxes.Ctrl.MpTransporterAxis.IsHomed);
			gAxes.Timers.HomeTimer[0].PT:=REAL_TO_TIME(gAxes.TimersPar.HomeDelayTime*1000);
			gAxes.Timers.HomeTimer[0]();
			
			IF gAxes.Timers.HomeTimer[0].Q THEN
				gAxes.Timers.HomeTimer[0].IN:=FALSE;
				gAxes.Timers.HomeTimer[0]();
				//zbyt dlugie bazowanie osi transportra alarm
				gAxes.State.Auto:=STATE_ERROR_AXES;
			END_IF;
			
			IF gAxes.Ctrl.MpTransporterAxis.IsHomed THEN
				gAxes.Ctrl.MpTransporterAxis.Home:=FALSE;
				gAxes.State.Manual:=STATE_WAIT_FOR_CMD_MANUAL;
				gAxes.Timers.HomeTimer[0].IN:=FALSE;
				gAxes.Timers.HomeTimer[0]();
			END_IF;
		STATE_CART_HOMMING:
			gAxes.Ctrl.MpCartAxis.Home:=TRUE;
			gAxes.Timers.HomeTimer[0].IN:=NOT(gAxes.Ctrl.MpCartAxis.IsHomed);
			gAxes.Timers.HomeTimer[0].PT:=REAL_TO_TIME(gAxes.TimersPar.HomeDelayTime*1000);
			gAxes.Timers.HomeTimer[0]();
			
			IF gAxes.Timers.HomeTimer[0].Q THEN
				gAxes.Timers.HomeTimer[0].IN:=FALSE;
				gAxes.Timers.HomeTimer[0]();
				//zbyt dlugie bazowanie osi MpCartAxis alarm
				gAxes.State.Auto:=STATE_ERROR_AXES;
			END_IF;
			
			IF EDGEPOS(gAxes.Ctrl.MpCartAxis.IsHomed) THEN
				gAxes.Ctrl.MpCartAxis.Home:=FALSE;
				gAxes.State.Manual:=STATE_WAIT_FOR_CMD_MANUAL;
				gAxes.Timers.HomeTimer[0].IN:=FALSE;
				gAxes.Timers.HomeTimer[0]();
			END_IF;
		STATE_POURER_HOMMING:
			gAxes.Ctrl.MpPourerAxis.Home:=TRUE;
			gAxes.Timers.HomeTimer[0].IN:=NOT(gAxes.Ctrl.MpPourerAxis.IsHomed);
			gAxes.Timers.HomeTimer[0].PT:=REAL_TO_TIME(gAxes.TimersPar.HomeDelayTime*1000);
			gAxes.Timers.HomeTimer[0]();
			
			IF gAxes.Timers.HomeTimer[0].Q THEN
				gAxes.Timers.HomeTimer[0].IN:=FALSE;
				gAxes.Timers.HomeTimer[0]();
				//zbyt dlugie bazowanie osi MpCartAxis alarm
				gAxes.State.Auto:=STATE_ERROR_AXES;
			END_IF;
			
			IF EDGEPOS(gAxes.Ctrl.MpPourerAxis.IsHomed) THEN
				gAxes.Ctrl.MpPourerAxis.Home:=FALSE;
				gAxes.State.Manual:=STATE_WAIT_FOR_CMD_MANUAL;
				gAxes.Timers.HomeTimer[0].IN:=FALSE;
				gAxes.Timers.HomeTimer[0]();
			END_IF;
	END_CASE;
		
	
	(* Aktualizacja pozycji zmiennych wykorzystywanych w scene viewer *)
	MachineAxesPosition.Tasma:=gAxes.Ctrl.MpTransporterAxis.Position;
	MachineAxesPosition.Wozek:=gAxes.Ctrl.MpCartAxis.Position;
	MachineAxesPosition.Nalewak:=gAxes.Ctrl.MpPourerAxis.Position;;
	AdrAxesPositions:=ADR(MachineAxesPosition);
	

	gAxes.Ctrl.MpTransporterAxis();
	gAxes.Ctrl.MpCartAxis();
	gAxes.Ctrl.MpPourerAxis();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	gAxes.Ctrl.MpTransporterAxis.Power:=FALSE;
	gAxes.Ctrl.MpTransporterAxis.Enable:=FALSE;
	gAxes.Ctrl.MpTransporterAxis();
	
	gAxes.Ctrl.MpCartAxis.Power:=FALSE;
	gAxes.Ctrl.MpCartAxis.Enable:=FALSE;
	gAxes.Ctrl.MpCartAxis();
	
	gAxes.Ctrl.MpPourerAxis.Power:=FALSE;
	gAxes.Ctrl.MpPourerAxis.Enable:=FALSE;
	gAxes.Ctrl.MpPourerAxis();
	 
END_PROGRAM

