
spider.debug = {
  y : 0,
  window : null,
  editorGadget : null,
  disabled: false,
  fatalError: false,
  Init : function() {
    
    // A webview is attached, don't display the built-in debug window
    if (window.spiderDebug)
    {
      return;
    }
    
    this.window = spider_OpenWindow(-1, 0, 0, 350, 150, "SpiderBasic - Debug output", (1 << 4) | (1 << 5));

    this.editorGadget = spider_EditorGadget(-1, 5, 5, spider_WindowWidth(spider.debug.window) - 10, spider_WindowHeight(spider.debug.window) - 10, (1 << 0));
    spider_StickyWindow(this.window, 1);
    
    // Position the window in the top/right corner
    spider_ResizeWindow(this.window, spider_DesktopWidth() - spider_WindowWidth(this.window, 1)-10, 10, -0xFFFF , -0xFFFF)

    spider_BindEvent(4, // PB_Event_CloseWindow
                     function() {
                       spider_CloseWindow(spider.debug.window);
                       spider.debug.disabled = true;
                     },
                     this.window);

    spider_BindEvent(7, // PB_Event_SizeWindow
                     function() {
                       spider_ResizeGadget(spider.debug.editorGadget, 5, 5, spider_WindowWidth(spider.debug.window) - 10, spider_WindowHeight(spider.debug.window) - 10);
                     },
                     this.window);
  },
  
  RawPrint : function(text) {

    if (this.editorGadget && !this.disabled)
    {
      spider_SetGadgetText(this.editorGadget, spider_GetGadgetText(this.editorGadget)+text+"\n");
      
      var editorTextArea = spider_GadgetID(this.editorGadget).gadget.domNode;
      
      // Use jquery animate to scroll down automatically
      $(editorTextArea).animate({
          scrollTop:$(editorTextArea)[0].scrollHeight - $(editorTextArea).height()
      },0);
    }
  },

  Print : function(text) {
    
    if (spider.debug.fatalError) // Don't do anything if the program has already crash
      return;
    
    // log in browser console first, just in case the GUI text doesn't work
    console.log(text);
    
    // A webview is attached, forward the debug to the IDE debug output
    if (window.spiderDebug)
    {
      window.spiderDebug({"command": 5, "text": ""+text });
    }
    else
    {
      this.RawPrint(text);
    }
  },
  
  CheckSingleFlags : function(parameter, flags, allowedFlags)
  {
    var callerName = spider.debug.CheckSingleFlags.caller.name;
    var functionName = callerName.substring(7, callerName.length - 6); // remove 'spider_' and '_DEBUG' 

    if (allowedFlags.indexOf(flags) === -1)
      throw new Error(functionName+"(): : invalid value specified for parameter '"+parameter+"'.", { cause: "spider" });
  },
  
  CheckCombinationFlags : function(parameter, flags, allowedFlags)
  {
    var callerName = spider.debug.CheckCombinationFlags.caller.name;
    var functionName = callerName.substring(7, callerName.length - 6); // remove 'spider_' and '_DEBUG' 

    var allFlags = 0;
    for (var k = 0; k < allowedFlags.length; k++)
    {
      allFlags |= allowedFlags[k];
    }
  
    if ((allFlags & flags) !== flags) // Something is wrong is the specified value doesn't fit in the flags
      throw new Error(functionName+"(): : invalid value specified for parameter '"+parameter+"'.", { cause: "spider" });
  },

  Error : function(text, callerName)
  {
    if (spider.debug.fatalError) // Don't do anything if the program has already crash
      return;
    
    if (typeof callerName === "undefined")
    {
      callerName = spider.debug.Error.caller.name;
    }
    
    functionName = callerName.substring(7, callerName.length - 6); // remove 'spider_' and '_DEBUG' 

    throw new Error(functionName+"(): "+text, { cause: "spider" });
  },
  
  CheckId : function(callerName, ObjectName, id)
  {
    if (spider.debug.fatalError) // Don't do anything if the program has already crash
      return;

    var functionName = callerName.substring(7, callerName.length - 6); // remove 'spider_' and '_DEBUG' 
    
    if (id < -1)
      throw new Error(functionName+"(): #"+ObjectName+" object number can't be negative (value: "+id+").", { cause: "spider" });
    else if (id >= 10000)
      throw new Error(functionName+"(): #"+ObjectName+" object number is very high (over 10000), are you sure of that ?", { cause: "spider" });
  },
  
  CheckObject : function(callerName, ObjectName, isObject)
  {
    if (spider.debug.fatalError) // Don't do anything if the program has already crash
      return;

    var functionName = callerName.substring(7, callerName.length - 6); // remove 'spider_' and '_DEBUG' 
    
    if (isObject === 0)
      throw new Error(functionName+"(): The specified #"+ObjectName+" is not initialised.", { cause: "spider" });
  },
  
  DebuggerLineGetLine : function(a) 
  {
    return ((a) & ((1 << 20)-1));
  },
  
  DebuggerLineGetFile : function(a)
  {
    return (((a) >> 20) & ((1 << (32-20))-1));
  },
  
  DisplayError : function(text)
  {
    if (spider.debug.fatalError) // Don't do anything if the program has already crash
      return;
    
    // A webview is attached
    if (window.spiderDebug)
    {  
      window.spiderDebug( { "command": 8, "lineId": spiderLine, "text": text } );
    }
    else
    {
      var line = spider.debug.DebuggerLineGetLine(spiderLine)+1;
      var fileIndex = spider.debug.DebuggerLineGetFile(spiderLine);
      var filename = spider.debugFilename;
      
      if (fileIndex > 0) // It's an include file
      {
        filename = spider.debugIncludes[fileIndex-1];
      }
      
      spider.debug.Print(filename+":"+line+" "+text);
    }
  }
};


// temporary Shortcut
spider.Debug = function(text) {
  spider.debug.Print(text);
};

// temporary Shortcut
function debug(text) {
  spider.debug.Print(text);
}

// global error handler
window.addEventListener("error", (event) => {

  if (spider.debug.fatalError) // Don't do anything if the program has already crash
    return;
    
  var text;
  if (event.error.cause == "spider") // It's a SpiderBasic exception
  {
    text = event.error.message;
  }
  else
  {
    // Not a SpiderBasic exception, put the full details
    text = `${event.type}: ${event.message} (${event.filename}, line: ${event.lineno})`;
  }

  spider.debug.DisplayError(text);

  spider.debug.fatalError = true;
});

