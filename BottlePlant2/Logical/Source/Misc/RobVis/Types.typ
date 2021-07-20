
TYPE
	ModelConfigButelkiType : 	STRUCT 
		Rozstaw : REAL; (*Rozstaw - o ile butelki sa oddalone od siebie - od srodka do srodka butelki*)
		Szerokosc : REAL; (*Szerokosc butelki*)
		OffsetPierwszej : REAL; (*Pozycja kiedy pierwsza butelka jest rowno z poczatkiem stolu*)
	END_STRUCT;
	ModelConfigWozekType : 	STRUCT 
		OffsetWozka : REAL; (*Pozycja kiedy wozek jest umieszczony dokladnie nad butelkami w pozycji zerowej*)
	END_STRUCT;
	ModelConfigType : 	STRUCT 
		Butelki : ModelConfigButelkiType;
		Wozek : ModelConfigWozekType;
	END_STRUCT;
	RobVisPosType : 	STRUCT 
		Tasma : REAL;
		Wozek : REAL;
		Nalewak : REAL;
		SensorColor : USINT;
	END_STRUCT;
END_TYPE
