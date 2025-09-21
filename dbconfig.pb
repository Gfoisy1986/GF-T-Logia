UsePostgreSQLDatabase()
  UseSHA2Fingerprint()

 
    
    
Procedure dbopen()
 If OpenDatabase(0, "host=127.0.0.1 port=5432 dbname=gflogia", "gfoisy", "!@Mom1986z") ; local database...
    Debug "Connecté à PostgreSQL local devel..."
  Else
    Debug "La connexion Postgresql local a echoué: "+DatabaseError()
  EndIf
EndProcedure

Procedure dbclose()
  CloseDatabase(0) 
  Debug "connection close"
EndProcedure
; IDE Options = PureBasic 6.21 - C Backend (Linux - arm64)
; CursorPosition = 10
; Folding = -
; EnableXP
; DPIAware