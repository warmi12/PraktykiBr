
PROGRAM _INIT
	(* Insert code here *)
	gAxes.SequencerCtrl.MpAxisCamSequencer_0.Enable:=TRUE;
	gAxes.SequencerCtrl.MpAxisCamSequencer_1.Enable:=TRUE;

	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Deceleration:=1000;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.Master:=ADR(gTranAxis);
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.StartState:=0;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].Type:=ncSIGNAL1;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].Attribute:=ncAT_ONCE;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[0].Event[0].NextState:=1;
	
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].CompMode:=ncONLYCOMP_DIRECT;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].CamProfileIndex:=16#ffff;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].MasterCompDistance:=0;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].SlaveCompDistance:=0;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].MasterFactor:=400*100;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].SlaveFactor:=400*100;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].Type:=ncST_END;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].Attribute:=ncAT_ONCE;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[1].Event[0].NextState:=2;
	
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].CompMode:=ncONLYCOMP_DIRECT;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].CamProfileIndex:=16#fffe;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].MasterCompDistance:=90;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].SlaveCompDistance:=-400;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].MasterFactor:=1;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].SlaveFactor:=0;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].Type:=ncST_END;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].Attribute:=ncAT_ONCE;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_0.Configuration.State[2].Event[0].NextState:=0;
	
	(* drugi seq *)
	
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Deceleration:=1000;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.Master:=ADR(gCartAxis);
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.StartState:=0;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[0].Event[0].Type:=ncSIGNAL1;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[0].Event[0].Attribute:=ncAT_ONCE;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[0].Event[0].NextState:=1;
	
	(* Sytuacja nalewak inkrementalny *)
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].CompMode:=ncONLYCOMP_DIRECT;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].CamProfileIndex:=16#fffe;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterCompDistance:=100.0;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveCompDistance:=275.0;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterFactor:=1;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveFactor:=0;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Type:=ncST_END;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Attribute:=ncAT_ONCE;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].NextState:=2;
	

	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].CompMode:=ncONLYCOMP_DIRECT;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].CamProfileIndex:=16#fffe;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterCompDistance:=290.0;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveCompDistance:=-275.0;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor:=1;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor:=0;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Type:=ncST_END;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Attribute:=ncAT_ONCE;
	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].NextState:=0;

	
	(* Sytuacja nalewak na sztywno *) (* Kszta³ butelk itd rozkminic to co ma byc w rece oraz czujnik itd jak przekazywac jak zmieniac te opcje itd *)
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].CompMode:=ncONLYCOMP_DIRECT;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].CamProfileIndex:=16#ffff;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterCompDistance:=100.0;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveCompDistance:=275.0;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].MasterFactor:=200*100;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].SlaveFactor:=0;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Type:=ncST_END;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].Attribute:=ncAT_ONCE;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[1].Event[0].NextState:=2;
//	
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].CompMode:=ncONLYCOMP_DIRECT;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].CamProfileIndex:=16#fffe;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterCompDistance:=100.0;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveCompDistance:=-275.0;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].MasterFactor:=1;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].SlaveFactor:=0;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Type:=ncST_END;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].Attribute:=ncAT_ONCE;
//	gAxes.SequencerCtrl.MpAxisCamSequencerPar_1.Configuration.State[2].Event[0].NextState:=0;
	(* To DO -> timer w homming, brak wylaczania zasilani *)
	gAxes.State.Auto:=STATE_INIT_AXES;
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
	
	gAxes.SequencerCtrl.MpAxisCamSequencer_0.MpLink:=ADR(gCartAxisCfg);
	gAxes.SequencerCtrl.MpAxisCamSequencer_0.MpLinkMaster:=ADR(gTranAxisCfg);	
	gAxes.SequencerCtrl.MpAxisCamSequencer_0.Parameters:=ADR(gAxes.SequencerCtrl.MpAxisCamSequencerPar_0);
	
	
	gAxes.SequencerCtrl.MpAxisCamSequencer_1.MpLink:=ADR(gPourAxisCfg);
	gAxes.SequencerCtrl.MpAxisCamSequencer_1.MpLinkMaster:=ADR(gCartAxisCfg);	
	gAxes.SequencerCtrl.MpAxisCamSequencer_1.Parameters:=ADR(gAxes.SequencerCtrl.MpAxisCamSequencerPar_1);
	//Machine.SequencerCtrl.MpAxisCamSequencer_1.Signal1:=Machine.SequencerCtrl.MpAxisCamSequencer_0.InCompensation;
	


	
	(* MAszyna stanów zarz¹dzajaca silnikami *)
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

	CASE gAxes.State.Auto OF
		STATE_INIT_AXES:
			gAxes.Ctrl.MpTransporterAxis.Enable:=TRUE;
			gAxes.Ctrl.MpCartAxis.Enable:=TRUE;
			gAxes.Ctrl.MpPourerAxis.Enable:=TRUE;
			
			gAxes.Ctrl.MpTransporterAxisPar.Velocity:=100;
			gAxes.Ctrl.MpTransporterAxisPar.Acceleration:=200;
			gAxes.Ctrl.MpTransporterAxisPar.Deceleration:=200;
			
			gAxes.Ctrl.MpCartAxisPar.Velocity:=100;
			gAxes.Ctrl.MpCartAxisPar.Acceleration:=200;
			gAxes.Ctrl.MpCartAxisPar.Deceleration:=200;
			
			gAxes.Ctrl.MpPourerAxisPar.Velocity:=800;
			gAxes.Ctrl.MpPourerAxisPar.Acceleration:=800;
			gAxes.Ctrl.MpPourerAxisPar.Deceleration:=800;
			
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
//				ELSIF gAxes.Cmd.Auto.MoveAbsolute THEN
//				ELSIF gAxes.Cmd.Auto.MoveAdditive THEN	
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
				gAxes.State.Auto:=STATE_ERROR_AXES;
			END_IF;
			IF gAxes.Timers.PowerTimer[1].Q THEN
				//zbyt dlugie zalaczanie osi wozka alarm
				gAxes.Timers.PowerTimer[1].IN:=FALSE;
				gAxes.Timers.PowerTimer[1]();
				gAxes.State.Auto:=STATE_ERROR_AXES;
			END_IF;
			IF gAxes.Timers.PowerTimer[2].Q THEN
				//zbyt dlugie zalaczanie osi nalewaka alarm
				gAxes.Timers.PowerTimer[2].IN:=FALSE;
				gAxes.Timers.PowerTimer[2]();
				gAxes.State.Auto:=STATE_ERROR_AXES;
			END_IF;

			IF gAxes.Ctrl.MpTransporterAxis.PowerOn AND gAxes.Ctrl.MpCartAxis.PowerOn AND gAxes.Ctrl.MpPourerAxis.PowerOn THEN
				gAxes.State.Auto:=STATE_WAIT_FOR_CMD_AXES;
				gAxes.Timers.PowerTimer[0].IN:=FALSE;
				gAxes.Timers.PowerTimer[0]();
				gAxes.Timers.PowerTimer[1].IN:=FALSE;
				gAxes.Timers.PowerTimer[1]();
				gAxes.Timers.PowerTimer[2].IN:=FALSE;
				gAxes.Timers.PowerTimer[2]();
			END_IF;

		STATE_HOME_AXES:
			gAxes.Ctrl.MpTransporterAxis.Home:=TRUE;
			gAxes.Ctrl.MpCartAxis.Home:=gAxes.Ctrl.MpTransporterAxis.IsHomed;
			gAxes.Ctrl.MpPourerAxis.Home:=gAxes.Ctrl.MpCartAxis.IsHomed;
			
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
			
			IF gAxes.Ctrl.MpTransporterAxis.IsHomed AND gAxes.Ctrl.MpCartAxis.IsHomed AND gAxes.Ctrl.MpPourerAxis.IsHomed THEN
				gAxes.Ctrl.MpTransporterAxis.Home:=FALSE;
				gAxes.Ctrl.MpCartAxis.Home:=FALSE;
				gAxes.Ctrl.MpPourerAxis.Home:=FALSE;
				gAxes.State.Auto:=STATE_WAIT_FOR_CMD_AXES;
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
				//gAxes.SequencerCtrl.MpAxisCamSequencer_0.StartSequence:=FALSE;
				//gAxes.SequencerCtrl.MpAxisCamSequencer_1.StartSequence:=FALSE;
				
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
			(* Chyba ¿e tu tdac ze ready  *)
			gAxes.SequencerCtrl.MpAxisCamSequencer_0.StartSequence:=TRUE;
			gAxes.SequencerCtrl.MpAxisCamSequencer_1.StartSequence:=TRUE;
			gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=TRUE;
			gAxes.State.Auto:=STATE_WAIT_FOR_CMD_AXES;
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
			IF EDGEPOS(gAxes.Cmd.Auto.ErrorReset) AND (NOT(gAxes.Ctrl.MpTransporterAxis.PowerOn) AND NOT(gAxes.Ctrl.MpCartAxis.PowerOn) AND NOT(gAxes.Ctrl.MpPourerAxis.PowerOn)) THEN
				gAxes.Cmd.Auto.ErrorReset:=FALSE;
				
				gAxes.Ctrl.MpTransporterAxis.Stop:=FALSE;
				gAxes.Ctrl.MpCartAxis.Stop:=FALSE;
				gAxes.Ctrl.MpPourerAxis.Stop:=FALSE;
				
				gAxes.Ctrl.MpTransporterAxis.ErrorReset:=TRUE;
				gAxes.Ctrl.MpCartAxis.ErrorReset:=TRUE;
				gAxes.Ctrl.MpPourerAxis.ErrorReset:=TRUE;		
				//gAxes.State.Auto:=WAIT_FOR_CMD;
			END_IF;
		
			IF NOT(gAxes.Ctrl.MpTransporterAxis.Error) AND NOT(gAxes.Ctrl.MpCartAxis.Error) AND NOT(gAxes.Ctrl.MpPourerAxis.Error) THEN
				gAxes.Ctrl.MpTransporterAxis.ErrorReset:=FALSE;
				gAxes.Ctrl.MpCartAxis.ErrorReset:=FALSE;
				gAxes.Ctrl.MpPourerAxis.ErrorReset:=FALSE;
				gAxes.State.Auto:=STATE_WAIT_FOR_CMD_AXES;
				//gAxes.Ctrl.MpTransporterAxis.MoveVelocity:=FALSE;
			END_IF
	END_CASE;
	 
	CASE gAxes.State.Manual OF
		STATE_WAIT_FOR_CMD_MANUAL:
			gAxes.Ctrl.MpTransporterAxis.JogPositive:=gAxes.Cmd.Manual.TransporterJogPositive;
			gAxes.Ctrl.MpTransporterAxis.JogNegative:=gAxes.Cmd.Manual.TransporterJogNegative;
			
			gAxes.Ctrl.MpCartAxis.JogPositive:=gAxes.Cmd.Manual.CartJogPositive;
			gAxes.Ctrl.MpCartAxis.JogNegative:=gAxes.Cmd.Manual.CartJogNegative;
			
			gAxes.Ctrl.MpPourerAxis.JogPositive:=gAxes.Cmd.Manual.PourerJogPositive;
			gAxes.Ctrl.MpPourerAxis.JogNegative:=gAxes.Cmd.Manual.PourerJogNegative;
		
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
			
			IF gAxes.Ctrl.MpCartAxis.IsHomed THEN
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
			
			IF gAxes.Ctrl.MpPourerAxis.IsHomed THEN
				gAxes.Ctrl.MpPourerAxis.Home:=FALSE;
				gAxes.State.Manual:=STATE_WAIT_FOR_CMD_MANUAL;
				gAxes.Timers.HomeTimer[0].IN:=FALSE;
				gAxes.Timers.HomeTimer[0]();
			END_IF;
	END_CASE;
		
	
	IF brmfmod(UDINT_TO_REAL(cntButelki),5.0)=0 AND EDGENEG(diButelka)THEN
		gAxes.SequencerCtrl.MpAxisCamSequencer_0.Signal1:=TRUE;
	ELSE
		gAxes.SequencerCtrl.MpAxisCamSequencer_0.Signal1:=FALSE;
	END_IF;
	
	IF brmfmod(UDINT_TO_REAL(cntButelki),5.0)=0 AND EDGENEG(diButelka) THEN
		gAxes.SequencerCtrl.MpAxisCamSequencer_1.Signal1:=TRUE;
	ELSE
		gAxes.SequencerCtrl.MpAxisCamSequencer_1.Signal1:=FALSE;
	END_IF;
	

	
	MachineAxesPosition.Tasma:=gAxes.Ctrl.MpTransporterAxis.Position;
	MachineAxesPosition.Wozek:=gAxes.Ctrl.MpCartAxis.Position;
	MachineAxesPosition.Nalewak:=gAxes.Ctrl.MpPourerAxis.Position;;
	diButelka;
	AdrAxesPositions:=ADR(MachineAxesPosition);
	
	gAxes.SequencerCtrl.MpAxisCamSequencer_0();
	gAxes.SequencerCtrl.MpAxisCamSequencer_1();
	
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

