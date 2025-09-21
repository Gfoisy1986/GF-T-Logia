; UseSQLiteDatabase()
;   Filename$ = "myDatabase.sqlite3"
;   If OpenDatabase(90, Filename$, "", "")
;     Debug "Connected to myDatabase.sqlite3"
;   EndIf

XIncludeFile "dbconfig.pb"

  UsePNGImageDecoder()
Result8$ = GetCurrentDirectory()
 ii = LoadImage(6, Result8$ + "gflogo1.png") ; Charge l'image depuis un fichier
 ii = ResizeImage(6, 220, 60)
 ee = LoadImage(4, Result8$ + "Background.bmp") ; Charge l'image depuis un fichier
 ee = ResizeImage(4, 40, 40)
 
Procedure IncrementCallback(JsonParameters$)
  Static Count
  
  Debug #PB_Compiler_Procedure +": " + JsonParameters$
  
  Count + 1
  ProcedureReturn UTF8(~"{ \"count\": "+Str(Count)+ "}")
EndProcedure

Procedure ComputeCallback(JsonParameters$)
  
  Debug #PB_Compiler_Procedure +": " + JsonParameters$
  
  Dim Parameters(0)
  
  ; Extract the parameters from the JSON
  ParseJSON(0, JsonParameters$)
  ExtractJSONArray(JSONValue(0), Parameters())
  
  Debug "Parameter 1: " + Parameters(0)
  Debug "Parameter 2: " + Parameters(1)
    
  ProcedureReturn UTF8(Str(Parameters(0) + Parameters(1)))
EndProcedure
 
Procedure entlogecreate()
     OpenGadgetList(2)
   FrameGadget(40, 0, 180, 220, 170, "Creation Compte",  #PB_Frame_Container)
     TextGadget(369, 5, 5, 210, 20, "Couriel", #PB_Text_Center)
     StringGadget(370, 5, 30, 210, 20, "")
    TextGadget(367, 5, 55, 210, 20, "Mot De Passe", #PB_Text_Center)
    StringGadget(372, 5, 80, 210, 20, "")
    ButtonGadget(373, 5, 110, 210, 30, " Create -> ")
    CloseGadgetList()
   CloseGadgetList()
EndProcedure
 
;   Procedure userlogecreate()
;     OpenGadgetList(2)
;    TextGadget(369, 5, 150, 135, 20, "Ent. email")
;    StringGadget(370, 5, 170, 135, 30, "")
;    TextGadget(367, 5, 250, 135, 20, "Ent. Password")
;    StringGadget(372, 5, 270, 135, 30, "")
;    ButtonGadget(373, 5, 300, 135, 30, " Create -> ")
;    CloseGadgetList()
;  EndProcedure

 Procedure loginent()
   OpenGadgetList(2)
   FrameGadget(30, 0, 0, 220, 170, "Se Connecter",  #PB_Frame_Container)
   TextGadget(901, 5, 5, 210, 20, "Couriel", #PB_Text_Center)
   StringGadget(391, 5, 25, 210, 20, "")
   TextGadget(902, 5, 50, 210, 20, "Mot De Passe", #PB_Text_Center)
   StringGadget(392, 5, 70, 210, 20, "")
   ButtonGadget(393, 5, 100, 210, 30, " Connect -> ")
   CloseGadgetList()
   CloseGadgetList()
 EndProcedure
 

     
; Procedure logeuser()
;   
;  
;   
;   OpenGadgetList(2)
;   ButtonGadget(3, 0, 0, 180, 50, "GF-Logia", #PB_Button_Toggle)
;   ButtonGadget(10, 0, 120, 180, 50, "GF-Support", #PB_Button_Toggle)
;   ButtonGadget(14, 0, 220, 180, 50, "Donation", #PB_Button_Toggle)
;   CloseGadgetList()
;   
;   
; EndProcedure

Procedure logeent(name$, entname$, email$, addresse$, telephone$, fax$)
  
  OpenGadgetList(2)
  
  ButtonGadget(111, 10, 275, 200, 40, "Se Deconnecter")
  
  CloseGadgetList()
  
  
  OpenGadgetList(13)
  
  AddGadgetItem(13, -1, "Acceuil")
  
  TextGadget(#PB_Any, 5, 5, 560, 20, "Bienvenue ("+entname$+")", #PB_Text_Center)
  
  
  TextGadget(#PB_Any, 5, 80, 250, 20, "Noms Complet Proprietaire: ")
  TextGadget(#PB_Any, 260, 80, 310, 20, ""+name$+"")
  
  TextGadget(#PB_Any, 5, 110, 250, 20, "Addresse Complete: ")
  TextGadget(#PB_Any, 260, 110, 310, 60, ""+addresse$+"")
  
  TextGadget(#PB_Any, 5, 180, 250, 20, "# Telephone: ")
  TextGadget(#PB_Any, 260, 180, 310, 20, ""+telephone$+"")
  
  TextGadget(#PB_Any, 5, 210, 250, 20, "Couriel: ")
  TextGadget(#PB_Any, 260, 210, 310, 20, ""+email$+"")
  
  TextGadget(#PB_Any, 5, 240, 250, 20, "# Fax: ")
  TextGadget(#PB_Any, 260, 240, 310, 20, ""+fax$+"")
  
  
  HideGadget(30, #True)
  HideGadget(40, #True)
 
;   ButtonGadget(3, 0, 0, 180, 50, "GF-Logia", #PB_Button_Toggle)
;   ButtonGadget(10, 0, 120, 180, 50, "GF-Support", #PB_Button_Toggle)
;   ButtonGadget(14, 0, 220, 180, 50, "Donation", #PB_Button_Toggle)
  CloseGadgetList()
  
  
EndProcedure



 Procedure flotte()
   OpenGadgetList(13, 0)
       
      StringGadget(333, 5, 385, 410, 30, "'enter VIN'!")
      ButtonGadget(334, 420, 385, 135, 30, "Recherche")
      
       ListIconGadget(100, 5, 420, 550, 100, "VIN", 300)
EndProcedure
     
       
If OpenWindow(0, 100, 200, 800, 600, "GFoisy", #PB_Window_SystemMenu)

 ImageGadget(5, 0, 0, 220, 60, ii) ; Affichage
 
 ContainerGadget(2, 0, 70, 220, 520)
 loginent()
 entlogecreate()
 CloseGadgetList() 
 

 
  PanelGadget(13, 230,  20, 560, 560)
  
  CloseGadgetList()
        
   
  

  
  Repeat
    Event = WaitWindowEvent()

    If Event = #PB_Event_CloseWindow  ; If the user has pressed on the close button
      Quit = 1
    EndIf
    
    
     Select Event
     
       Case #PB_Event_Gadget
         Select EventGadget()
             
;              IncludeFile "InvCase.pb"
;              IncludeFile "EmpCase.pb"
;              IncludeFile "WoCase.pb"
             
   Case 3 : 
     If GetGadgetState(3) = 1
   
       SetGadgetState(10, 0)
       SetGadgetState(14, 0)
       ClearGadgetItems(13)
       
      OpenGadgetList(13)
      AddGadgetItem(13, -1, "La Flotte")
      flotte()
      
    
   
       OpenGadgetList(13)
       AddGadgetItem(13, -1, "Les Workorders")
       OpenGadgetList(13, 1)
       TextGadget(607, 5, 5, 250, 30, "IF Vin is found show WO# List")  ; IF Vin is found show it in listicongadget x 200 hauteur
       TextGadget(608, 5, 40, 400, 30, "IF Vin is not found put button to open Flotte Panel")  ; IF Vin is found show it in listicongadget x 200 hauteur
       TextGadget(609, 5, 75, 400, 30, "IF found put alias Inspec sheet if any! in a list")  ; IF Vin is found show it in listicongadget x 200 hauteur
       TextGadget(610, 5, 110, 400, 40, "IF Vin found show WO entete + inv list manual #part, Desc, price, Quant...")  ; IF Vin is found show it in listicongadget x 200 hauteur
       TextGadget(611, 5, 145, 400, 30, "Put a button close WO -> Facturation by vin status 2 from 1...")  ; IF Vin is found show it in listicongadget x 200 hauteur
       
       
       OpenGadgetList(13)
       AddGadgetItem(13, -1, "La Facturation")
       OpenGadgetList(13, 2)
       WebViewGadget(0, 0, 0, 800, 600)
       SetGadgetText(0, "file:///home/gfoisy/Documents/GitHub/GF-T-Logia/index.html")
       BindWebViewCallback(0, "increment", @IncrementCallback())
       BindWebViewCallback(0, "compute", @ComputeCallback())
       
       
       
       OpenGadgetList(13)
       AddGadgetItem(13, -1, "Les Notes")
       OpenGadgetList(13, 3)
       TextGadget(902, 0, 0, 100, 30, "heya")
       
       
      CloseGadgetList()
       
     EndIf    
       
 
     Case 10 : 
     If GetGadgetState(10) = 1
   
       SetGadgetState(3, 0)
       SetGadgetState(14, 0)
       ClearGadgetItems(13)
      OpenGadgetList(13)
       AddGadgetItem(13, -1, "Support Technique")
       TextGadget(158, 10, 10, 200, 30, "Nous contactez par couriel ! ")
       CloseGadgetList()
     EndIf 
     
     
       Case 14 : 
     If GetGadgetState(14) = 1
   
       SetGadgetState(10, 0)
       SetGadgetState(3, 0)
       ClearGadgetItems(13)
      OpenGadgetList(13)
       AddGadgetItem(13, -1, "Donation")
        TextGadget(190, 10, 10, 600, 30, "Pour Contribuer suivez ce lien!    https://guillaumefoisy.com/donation.html  ")
       CloseGadgetList()
     EndIf 
    
     
   Case 334 :
     
     dbopen()
     If DatabaseQuery(0, "SELECT * FROM public.flotte WHERE vin='"+ GetGadgetText(333) +"'")
       NextDatabaseRow(0)
       ClearGadgetItems(100)
        AddGadgetItem(100, -1, GetDatabaseString(0, 1))
     
        FinishDatabaseQuery(0)
        dbclose()
        OpenGadgetList(13, 0)
        HideGadget(334, #True)
        HideGadget(333, #True)
        ButtonGadget(380, 5, 5, 120, 30, "Reset")
        ButtonGadget(381, 5, 100, 120, 30, "Create WO#")
        TextGadget(555, 5, 340, 560, 30, "Current selected VIN :  " + GetGadgetItemText(100, 0, 0))
        CloseGadgetList()
  Else
    
    MessageRequester("VIN request", "request VIN is not found...")
    Debug "Vin not found"
    
    EndIf
     
     
  Case 380 :
    HideGadget(380, #True)
    HideGadget(381, #True)
    HideGadget(555, #True)
    flotte()
    
    
    
  Case 393 :
    
      *Buffer2 = AllocateMemory(200) ; Prépare un tampon de données                 
   If *Buffer2
     PokeS(*Buffer2, GetGadgetText(392), -1, #PB_UTF8)
     Taille2 = MemoryStringLength(*Buffer2, #PB_UTF8)
   If StartFingerprint(1, #PB_Cipher_SHA2)                ; démarre le calcul
       AddFingerprintBuffer(1, *Buffer2, Taille2/2)          ; calcule la partie 1
       AddFingerprintBuffer(1, *Buffer2+Taille2/2, Taille2/2) ; calcule la partie 2
       
       MD51$ = FinishFingerprint(1)                ; termine le calcul
       Debug "sha2 checksum = " + MD51$    
   EndIf
  
   
    dbopen()
    DatabaseQuery(0, "SELECT * FROM public.loginuser WHERE emails='"+GetGadgetText(391)+"'")
    NextDatabaseRow(0)
   
       If GetDatabaseString(0, 2) = MD51$
         Debug "password ok"
         Debug "Connected to Ent. loge"
         email$ = GetDatabaseString(0, 4)
         name$ =  GetDatabaseString(0, 1)
         entname$ = GetDatabaseString(0, 3)
         addresse$ = GetDatabaseString(0, 5)
         telephone$ = GetDatabaseString(0, 6)
         fax$ = GetDatabaseString(0, 7)
         logeent(name$, entname$, email$, addresse$, telephone$, fax$)
       Else
         Debug "Wrong Password"
       EndIf
   EndIf 
   
   FinishDatabaseQuery(0)
   dbclose()
  
       
    
    
Case 373 :
  
  
     *Buffer = AllocateMemory(200) ; Prépare un tampon de données                 
   If *Buffer
     PokeS(*Buffer, GetGadgetText(372), -1, #PB_UTF8)
     Taille = MemoryStringLength(*Buffer, #PB_UTF8)
     
     If StartFingerprint(0, #PB_Cipher_SHA2)                ; démarre le calcul
       AddFingerprintBuffer(0, *Buffer, Taille/2)          ; calcule la partie 1
       AddFingerprintBuffer(0, *Buffer+Taille/2, Taille/2) ; calcule la partie 2
       
       MD5$ = FinishFingerprint(0)                ; termine le calcul
       Debug "MD5 checksum = " + MD5$
;       
; ;       MD5$ = Fingerprint(*Buffer, Taille, #PB_Cipher_SHA2)       ; comparaison avec le calcul en une seule étape
; ;       Debug "MD5 checksum = " + MD5$      
     EndIf

  EndIf ; 367 p    369 c
  
    dbopen()
    query7.s =  "INSERT INTO loginuser (passs, emails) VALUES ('"+MD5$+"', '"+GetGadgetText(370)+"')"
    
     ; query7.s =  "INSERT INTO loginuser (users, passs, ents, emails) VALUES ("+GetGadgetText(371)+", re, "+GetGadgetText(370)+", test3@test.com)"
      If  DatabaseUpdate(0, query7)
     
    Debug "Data inserted successfully."
  Else
    Debug "Error inserting data: " + DatabaseError()
  EndIf
       FinishDatabaseQuery(0)
      dbclose()
   FreeMemory(*Buffer)
   
   
   
 Case 111 :  
   HideGadget(111, #True)
   ClearGadgetItems(13)
   loginent()
   entlogecreate()
   
   
   
   
   
         EndSelect
       
;        Case #PB_Event_Menu
;          Select EventMenu()
; ;            Case 1 : End
; ;            Case 2 : End
;            Case 4 : End ;
;          EndSelect
     
     EndSelect
    
    
    
    
  Until Quit = 1
  
EndIf

End   ; All the opened windows are closed automatically by PureBasic                                                
; IDE Options = PureBasic 6.21 (Linux - x64)
; CursorPosition = 212
; FirstLine = 189
; Folding = --
; Optimizer
; EnableXP
; EnableWayland
; DPIAware
; EnableOnError
; Executable = ../../purebasic-gflogia/app.run
; Compiler = PureBasic 6.21 - C Backend (Linux - x64)