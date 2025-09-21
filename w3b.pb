;
; ------------------------------------------------------------
;
;   PureBasic - WebView example file
;
;    (c) 2024 - Fantaisie Software
;
; ------------------------------------------------------------
;

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

OpenWindow(0, 100, 100, 800, 600, "Hello", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)

WebViewGadget(0, 0, 0, 800, 600)
SetGadgetText(0, "file:///home/gfoisy/Documents/GitHub/GF-T-Logia/index.html")
  
BindWebViewCallback(0, "increment", @IncrementCallback())
BindWebViewCallback(0, "compute", @ComputeCallback())

; Show the window once the webview has been fully loaded
HideWindow(0, #False)

Repeat 
  Event = WaitWindowEvent()
Until Event = #PB_Event_CloseWindow
; IDE Options = PureBasic 6.21 (Linux - x64)
; CursorPosition = 35
; FirstLine = 10
; Folding = -
; EnableXP
; DPIAware
; CPU = 2