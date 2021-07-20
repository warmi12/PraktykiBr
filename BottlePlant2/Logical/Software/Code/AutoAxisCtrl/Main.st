
PROGRAM _INIT
	(* Insert code here *)
	(* To DO -> timer w homming, brak wylaczania zasilani *)
	gAxes.State:=STATE_INIT_AXES;
	gControlType:=TRUE;
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
	
	gAxes.Ctrl.MpTransporterAxis();
	gAxes.Ctrl.MpCartAxis();
	gAxes.Ctrl.MpPourerAxis();
	
	//gStateAutoAxisCtrl:=ADR(gAxes.State);	
	//gCmdAutoAxisCtrl:=ADR(gAxes.Cmd);
	//CmdFromMachine ACCESS gCmdAutoAxisCtrl;
	//gAxes.Cmd:=CmdFromMachine;
	
	IF gControlType THEN
		IF gAxes.Ctrl.MpTransporterAxis.Error THEN
			//alarm osi transporter
			gAxes.State:=STATE_ERROR_AXES;
		END_IF
		IF gAxes.Ctrl.MpCartAxis.Error THEN
			//alarm osi wozka
			gAxes.State:=STATE_ERROR_AXES;
		END_IF
		IF gAxes.Ctrl.MpPourerAxis.Error THEN
			//alarm nalewaka
			gAxes.State:=STATE_ERROR_AXES;
		END_IF

		CASE gAxes.State OF
			STATE_INIT_AXES:
				gAxes.Ctrl.MpTransporterAxis.Enable:=TRUE;
				gAxes.Ctrl.MpCartAxis.Enable:=TRUE;
				gAxes.Ctrl.MpPourerAxis.Enable:=TRUE;
				
				IF gAxes.Ctrl.MpTransporterAxis.Active AND gAxes.Ctrl.MpCartAxis.Active AND gAxes.Ctrl.MpPourerAxis.Active THEN
					gAxes.State:=STATE_POWER_ON_AXES;
				END_IF;
			STATE_WAIT_FOR_CMD_AXES:
				IF EDGEPOS(gAxes.Cmd.Power) THEN
					gAxes.Cmd.Power:=FALSE;
					gAxes.State:=STATE_POWER_ON_AXES;
				ELSIF EDGEPOS(gAxes.Cmd.Home) THEN
					gAxes.Cmd.Home:=FALSE;
					gAxes.State:=STATE_HOME_AXES;
				ELSIF EDGEPOS(gAxes.Cmd.Update) THEN
					gAxes.Cmd.Update:=FALSE;
					gAxes.State:=STATE_UPDATE_AXES;
				ELSIF EDGEPOS(gAxes.Cmd.Stop) THEN
					gAxes.Cmd.Stop:=FALSE;
					gAxes.State:=STATE_STOP_AXES;
				ELSIF EDGEPOS(gAxes.Cmd.ErrorReset) THEN
					gAxes.Cmd.ErrorReset:=FALSE;

				ELSIF EDGEPOS(gAxes.Cmd.MoveVelocity) THEN
					gAxes.Cmd.MoveVelocity:=FALSE;
					gAxes.State:=STATE_MOVE_VELOCITY_AXES;	
//				ELSIF gAxes.Cmd.MoveAbsolute THEN
//				ELSIF gAxes.Cmd.MoveAdditive THEN	
				END_IF;				
			STATE_POWER_ON_AXES:
				gAxes.Ctrl.MpTransporterAxis.Power:=TRUE;
				gAxes.Ctrl.MpCartAxis.Power:=TRUE;
				gAxes.Ctrl.MpPourerAxis.Power:=TRUE;
				
				gAxes.Timers.PowerTimer[0].IN:=NOT(gAxes.Ctrl.MpTransporterAxis.PowerOn);
				gAxes.Timers.PowerTimer[0].PT:=REAL_TO_TIME(gAxes.TimersPar.PowerDelayTime*1000);
				gAxes.Timers.PowerTimer[0]();
				
				gAxes.Timers.PowerTimer[1].IN:=NOT(gAxes.Ctrl.MpCartAxis.PowerOn);
				gAxes.Timers.PowerTimer[1].PT:=REAL_TO_TIME(gAxes.TimersPar.PowerDelayTime*1000);
				gAxes.Timers.PowerTimer[1]();
				
				gAxes.Timers.PowerTimer[2].IN:=NOT(gAxes.Ctrl.MpPourerAxis.PowerOn);
				gAxes.Timers.PowerTimer[2].PT:=REAL_TO_TIME(gAxes.TimersPar.PowerDelayTime*1000);
				gAxes.Timers.PowerTimer[2]();
				
				IF gAxes.Timers.PowerTimer[0].Q THEN
					//zbyt dlugie zalaczanie osi transportra alarm
					gAxes.Timers.PowerTimer[0].IN:=FALSE;
					gAxes.Timers.PowerTimer[0]();
					gAxes.State:=STATE_ERROR_AXES;
				END_IF;
				IF gAxes.Timers.PowerTimer[1].Q THEN
					//zbyt dlugie zalaczanie osi wozka alarm
					gAxes.Timers.PowerTimer[1].IN:=FALSE;
					gAxes.Timers.PowerTimer[1]();
					gAxes.State:=STATE_ERROR_AXES;
				END_IF;
				IF gAxes.Timers.PowerTimer[2].Q THEN
					//zbyt dlugie zalaczanie osi nalewaka alarm
					gAxes.Timers.PowerTimer[2].IN:=FALSE;
					gAxes.Timers.PowerTimer[2]();
					gAxes.State:=STATE_ERROR_AXES;
				END_IF;

				IF gAxes.Ctrl.MpTransporterAxis.PowerOn AND gAxes.Ctrl.MpCartAxis.PowerOn AND gAxes.Ctrl.MpPourerAxis.PowerOn THEN
					gAxes.State:=STATE_WAIT_FOR_CMD_AXES;
					gAxes.Timers.PowerTimer[0].IN:=FALSE;
					gAxes.Timers.PowerTimer[0]();
					gAxes.Timers.PowerTimer[1].IN:=FALSE;
					gAxes.Timers.PowerTimer[1]();
					gAxes.Timers.PowerTimer[2].IN:=FALSE;
					gAxes.Timers.PowerTimer[2]();
				END_IF;

			STATE_HOME_AXES:
				gAxes.Ctrl.MpTransporterAxis.Home:=TRUE;
				gAxes.Ctrl.MpCartAxis.Home:=TRUE;
				gAxes.Ctrl.MpPourerAxis.Home:=TRUE;
				
				gAxes.Timers.HomeTimer[0].IN:=NOT(gAxes.Ctrl.MpTransporterAxis.IsHomed);
				gAxes.Timers.HomeTimer[0].PT:=REAL_TO_TIME(gAxes.TimersPar.HomeDelayTime*1000);
				gAxes.Timers.HomeTimer[0]();
				
				gAxes.Timers.HomeTimer[1].IN:=NOT(gAxes.Ctrl.MpCartAxis.IsHomed);
				gAxes.Timers.HomeTimer[1].PT:=REAL_TO_TIME(gAxes.TimersPar.HomeDelayTime*1000);
				gAxes.Timers.HomeTimer[1]();
				
				gAxes.Timers.HomeTimer[2].IN:=NOT(gAxes.Ctrl.MpPourerAxis.IsHomed);
				gAxes.Timers.HomeTimer[2].PT:=REAL_TO_TIME(gAxes.TimersPar.HomeDelayTime*1000);
				gAxes.Timers.HomeTimer[2]();
				
				IF gAxes.Timers.HomeTimer[0].Q THEN
					gAxes.Timers.HomeTimer[0].IN:=FALSE;
					gAxes.Timers.HomeTimer[0]();
					//zbyt dlugie bazowanie osi transportra alarm
					gAxes.State:=STATE_ERROR_AXES;
				END_IF;
				
				IF gAxes.Timers.HomeTimer[1].Q THEN
					gAxes.Timers.HomeTimer[1].IN:=FALSE;
					gAxes.Timers.HomeTimer[1]();
					//zbyt dlugie bazowanie osi wozka alarm
					gAxes.State:=STATE_ERROR_AXES;
				END_IF;
				
				IF gAxes.Timers.HomeTimer[2].Q THEN
					gAxes.Timers.HomeTimer[2].IN:=FALSE;
					gAxes.Timers.HomeTimer[2]();
					//zbyt dlugie bazowanie osi nalewaka alarm
					gAxes.State:=STATE_ERROR_AXES;
				END_IF;
				
				IF gAxes.Ctrl.MpTransporterAxis.IsHomed AND gAxes.Ctrl.MpCartAxis.IsHomed AND gAxes.Ctrl.MpPourerAxis.IsHomed THEN
					gAxes.Ctrl.MpTransporterAxis.Home:=FALSE;
					gAxes.Ctrl.MpCartAxis.Home:=FALSE;
					gAxes.Ctrl.MpPourerAxis.Home:=FALSE;
					gAxes.State:=STATE_WAIT_FOR_CMD_AXES;
					gAxes.Timers.HomeTimer[0].IN:=FALSE;
					gAxes.Timers.HomeTimer[0]();
					gAxes.Timers.HomeTimer[1].IN:=FALSE;
					gAxes.Timers.HomeTimer[1]();
					gAxes.Timers.HomeTimer[2].IN:=FALSE;
					gAxes.Timers.HomeTimer[2]();
				END_IF;
			STATE_STOP_AXES:
				//bez wylaczania zasialania
				(* Sprawdzenie czy jes wlaczonysilnik jesi tak to stop - jesli off to wywalierror *)
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
					
					gAxes.Ctrl.MpTransporterAxis.Stop:=FALSE;
					gAxes.Ctrl.MpCartAxis.Stop:=FALSE;
					gAxes.Ctrl.MpPourerAxis.Stop:=FALSE;
					
					gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=FALSE;

					gAxes.State:=STATE_WAIT_FOR_CMD_AXES;
					//gAxes.Cmd.Stop:=FALSE;
				END_IF;
			STATE_UPDATE_AXES:
				gAxes.Ctrl.MpTransporterAxis.Update:=TRUE;
				gAxes.Ctrl.MpCartAxis.Update:=TRUE;
				gAxes.Ctrl.MpPourerAxis.Update:=TRUE;
				
				IF gAxes.Ctrl.MpTransporterAxis.UpdateDone AND gAxes.Ctrl.MpCartAxis.UpdateDone AND gAxes.Ctrl.MpPourerAxis.UpdateDone THEN
					gAxes.State:=STATE_WAIT_FOR_CMD_AXES;
					gAxes.Ctrl.MpTransporterAxis.Update:=FALSE;
					gAxes.Ctrl.MpCartAxis.Update:=FALSE;
					gAxes.Ctrl.MpPourerAxis.Update:=FALSE;
				END_IF;
			STATE_MOVE_VELOCITY_AXES:
				(* Chyba ¿e tu tdac ze ready  *)
				gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=TRUE;
				gAxes.State:=STATE_WAIT_FOR_CMD_AXES;
			STATE_ERROR_AXES:
				(* Zatrzymanie wszystkich silnikow *)
				gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=FALSE;
				IF gAxes.Ctrl.MpTransporterAxis.PowerOn THEN
					gAxes.Ctrl.MpTransporterAxis.Stop:=TRUE;
				END_IF;
				
				IF gAxes.Ctrl.MpCartAxis.PowerOn THEN
					gAxes.Ctrl.MpCartAxis.Stop:=TRUE;
				END_IF;
				
				IF gAxes.Ctrl.MpPourerAxis.PowerOn THEN
					gAxes.Ctrl.MpPourerAxis.Stop:=TRUE;
				END_IF;
				
				(* Jesli sa zastopowane to power off  *)
				IF gAxes.Ctrl.MpTransporterAxis.Stopped THEN
					gAxes.Ctrl.MpTransporterAxis.Power:=FALSE;
				END_IF;
				
				IF gAxes.Ctrl.MpCartAxis.Stopped THEN
					gAxes.Ctrl.MpCartAxis.Power:=FALSE;
				END_IF;
				
				IF gAxes.Ctrl.MpPourerAxis.Stopped THEN
					gAxes.Ctrl.MpPourerAxis.Power:=FALSE;
				END_IF;
				
				(* Czekamy na przycisk reseterror *)
				IF EDGEPOS(gAxes.Cmd.ErrorReset) AND (NOT(gAxes.Ctrl.MpTransporterAxis.PowerOn) AND NOT(gAxes.Ctrl.MpCartAxis.PowerOn) AND NOT(gAxes.Ctrl.MpPourerAxis.PowerOn)) THEN
					gAxes.Cmd.ErrorReset:=FALSE;
					
					gAxes.Ctrl.MpTransporterAxis.Stop:=FALSE;
					gAxes.Ctrl.MpCartAxis.Stop:=FALSE;
					gAxes.Ctrl.MpPourerAxis.Stop:=FALSE;
					
					gAxes.Ctrl.MpTransporterAxis.ErrorReset:=TRUE;
					gAxes.Ctrl.MpCartAxis.ErrorReset:=TRUE;
					gAxes.Ctrl.MpPourerAxis.ErrorReset:=TRUE;		
					//gAxes.State:=WAIT_FOR_CMD;
				END_IF;
			
				IF NOT(gAxes.Ctrl.MpTransporterAxis.Error) AND NOT(gAxes.Ctrl.MpCartAxis.Error) AND NOT(gAxes.Ctrl.MpPourerAxis.Error) THEN
					gAxes.Ctrl.MpTransporterAxis.ErrorReset:=FALSE;
					gAxes.Ctrl.MpCartAxis.ErrorReset:=FALSE;
					gAxes.Ctrl.MpPourerAxis.ErrorReset:=FALSE;
					gAxes.State:=STATE_WAIT_FOR_CMD_AXES;
					//gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=FALSE;
				END_IF
			
		END_CASE;
	END_IF;
	
	 
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

