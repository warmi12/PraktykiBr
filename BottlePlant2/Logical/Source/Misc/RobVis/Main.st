PROGRAM _INIT
	ModelConfig.Butelki.OffsetPierwszej := 7;
	ModelConfig.Butelki.Rozstaw := 100;
	ModelConfig.Butelki.Szerokosc := 80;
	
	ModelConfig.Wozek.OffsetWozka := 0;
END_PROGRAM

PROGRAM _CYCLIC
	
	IF AdrAxesPositions <> 0 THEN
		pAxesPositions ACCESS AdrAxesPositions;
	ELSE
		RETURN;
	END_IF
	TasmaPos1:=LREAL_TO_REAL(pAxesPositions.Tasma);
	TasmaPos1:=brmfmod(TasmaPos1,2500);
	
		
	
	// --------------------------------------------
	// Prepare correct positions for model
	// --------------------------------------------
	RobVisData.Tasma := ModelConfig.Butelki.OffsetPierwszej + TasmaPos1 + TasmaAxisPosition + 400;
	RobVisData.Wozek := ModelConfig.Wozek.OffsetWozka + LREAL_TO_REAL(pAxesPositions.Wozek) + WozekAxisPosition + 470;
	RobVisData.Nalewak := (LREAL_TO_REAL(pAxesPositions.Nalewak) + NalewakAxisPosition);
	RobVisData.SensorColor;
	
	// --------------------------------------------
	// Generator sygnalu czujnika butelki
	// --------------------------------------------
	FOR i := 0 TO 50 DO
		IF (RobVisData.Tasma > i*ModelConfig.Butelki.Rozstaw) AND (RobVisData.Tasma < (i*ModelConfig.Butelki.Rozstaw + ModelConfig.Butelki.Szerokosc)) THEN
			diButelka := TRUE;
			RobVisData.SensorColor := 5;
			EXIT;
		ELSE
			diButelka := FALSE;
			RobVisData.SensorColor := 11;
		END_IF
	END_FOR
	
	// --------------------------------------------
	// Licznik butelek
	// --------------------------------------------
	IF (diButelkaOld <> diButelka) AND diButelka THEN
		cntButelki := cntButelki + 1;
	END_IF
	diButelkaOld := diButelka;
		
	
	// --------------------------------------------
	// Tests
	// --------------------------------------------
	IF cmdTestModelMovements THEN
		TasmaAxisPosition := TasmaAxisPosition + 1;
		WozekAxisPosition := WozekAxisPosition + 1;
		NalewakAxisPosition := NalewakAxisPosition + 1;
		
		IF TasmaAxisPosition > 5000 THEN
			TasmaAxisPosition := 0;
		END_IF	
		
		IF WozekAxisPosition > 1200 THEN
			WozekAxisPosition := 0;
		END_IF	
		
		IF NalewakAxisPosition > 230 THEN
			NalewakAxisPosition := 0;
		END_IF
	END_IF
	
	
	// --------------------------------------------
	// Info: w tasku z napedami jest kod z przepisaniem pozycji napedow:
		
		// --------------------------------------------
		// Axes positions
		// --------------------------------------------
		// AdrAxesPositions := ADR(pAxesPositions);
		// AxesPositions.Tasma := MpAxisBasicList[0].Position;
		// AxesPositions.Wozek := MpAxisBasicList[1].Position;
		// AxesPositions.Nalewak := MpAxisBasicList[2].Position;

	// --------------------------------------------
	// --------------------------------------------
	
	
END_PROGRAM



