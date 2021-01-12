package
{
   import flash.display.*;    
   import flash.media.*;
   import flash.geom.*;
   import flash.net.*;
   import fl.events.*;
   import fl.motion.*;   
   import flash.events.*;   
   import flash.net.*;  
   import flash.text.*;  
   import flash.utils.*;   
   import flash.filesystem.*;
   import flash.desktop.*;
   import flash.system.*;    
   import SaveData; 
   import Log;    
   import flash.filters.*;
	
  
   public class Main extends MovieClip
   {      
      
      private var WexisanIdiot:Boolean;          

      private var sukapon:Boolean;

      private var sfxdelay:Boolean;

      public static var autocompress:Boolean = false; //not ready yet

      public static var muteCheck:Boolean;

      private var startingTime:int;

      private var endingTime:int;  

      public static var x:int = 0;   

      public static var i:int = 0;

      public static var l:int = 0;

      public static var n:int = 0;   

      private var thelength:int;    

      public static var mslider:Number = 0.6;

      public static var slider:Number = 0.4;      
      
      public static var color1:String = "";

      public static var color2:String = "";    

      public static var color4:String = "";    
      
      public static var color3:String = "";  

      public static var PressorTitle:String;

      public static var screenString:String = File.applicationDirectory.resolvePath("wallpapers").nativePath; 

      public static var loadme:String;         

      public static var processArgs = new Vector.<String>;   

      public static var files:Vector.<Object> = new Vector.<Object>();

      public static var docsDir:File = File.documentsDirectory;

      public static var SSF2Dir:File = File.documentsDirectory;   

      public static var swffile:File = File.applicationDirectory.resolvePath("ffdec.exe"); 

      public static var screens:File = new File(screenString);

      public static var txtFilter:FileFilter;

      private var filter:ColorMatrixFilter; 

      public static var fs:FileStream = new FileStream();
      
      public static var nativeProcessStartupInfo = new NativeProcessStartupInfo();  
      
      public static var loader:Loader = new Loader();     

      private var FileData:ByteArray = new ByteArray;

      private var c:ByteArray = new ByteArray();         

      private var color:AdjustColor = new AdjustColor();       
         
      public static var MenuMusic:Sound = new (menu); 

      public static var onClick:Sound = new (ff7cursor); 

      public static var back:Sound = new (backSound); 

      public static var onClickSet:Sound = new (wark); 

      public static var clicked:Sound = new (confirm); 

      public static var SFXtrans:SoundTransform = new SoundTransform(0.3); 

      public static var Musictrans:SoundTransform = new SoundTransform(0.6); 

      public static var SFXchannel:SoundChannel;

      public static var Musicchannel:SoundChannel;

      public static var dockIcon:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;             

      public static var oldtime;    
      
      public function Main()
      {
         super();
         var c:Color = new Color();
         settingswindow.visible = false;
         aboutwindow.visible = false;         
         stage.nativeWindow.title = pressortext.text = "Pressor " + version.text;
         PressorTitle = "Pressor " + version.text + " | ";
         SaveData.importer();        
         Log.create(this);
         Log.handleExceptions(this, true); 
         if(muteCheck == true)
         {
            concert();
         }         
         color.saturation = color.hue = color.contrast = color.brightness = 0; 
         filter = new ColorMatrixFilter(color.CalculateFinalFlatArray());
         decomp.ucomp_button.filters = comp.ucomp_button.filters = compF.ucomp_button.filters = decompF.ucomp_button.filters = [filter];        
         if(color1 !== "")
         {            
            color.saturation = -100;
            c.setTint(color1, 0.69);
            decomp.ucomp_button.transform.colorTransform = c;
            c.setTint(color2, 0.69);
            comp.ucomp_button.transform.colorTransform = c;
            c.setTint(color3, 0.69);
            decompF.ucomp_button.transform.colorTransform = c;
            c.setTint(color4, 0.69); 
            compF.ucomp_button.transform.colorTransform = c;
         }
         bgimage.mouseEnabled = false;
         bgimage.mouseChildren = false;
         SFXtrans = new SoundTransform(slider);
         Musictrans = new SoundTransform(mslider);
         Log.log("slider is " + slider + " mslider is " + mslider);         
         Musicchannel = MenuMusic.play(0, int.MAX_VALUE, Musictrans);
         try
         {   
            var files:Array = screens.getDirectoryListing();
            for (i = 0; i < files.length; i++)
            {              
               if(files[i].extension == "png" || files[i].extension == "jpg")
               {
                  continue;          
               }
               else
               {
                  files.removeAt(i); 
                  i--
               }               
            }
            n = randomRange(0, files.length - 1);                    
            loadme = files[n].nativePath;
            Log.log("Found " + loadme);   
            loader.load(new URLRequest(loadme));                
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, on_loadComplete);                   
         }
         catch(e:Error)
         {   
            Log.log("Image failed to load: " + e.message)
            if(!screens.exists)
            {
               screens.createDirectory();
               Log.log("Created a directory for screens here: " + screens.nativePath)
            }            
         }		   
         decomp.addEventListener(MouseEvent.CLICK,this.doIt);
         comp.addEventListener(MouseEvent.CLICK,this.doIt);
         decompF.addEventListener(MouseEvent.CLICK,this.doIt);
         compF.addEventListener(MouseEvent.CLICK,this.doIt);
		   settingsicon.addEventListener(MouseEvent.CLICK,this.openSettings);         
		   settingsicon.addEventListener(MouseEvent.ROLL_OVER, hoverState);
         settingsicon.addEventListener(MouseEvent.ROLL_OUT, normalState);
         decomp.addEventListener(MouseEvent.ROLL_OVER, hoverState);
         decomp.addEventListener(MouseEvent.ROLL_OUT, normalState);
         decompF.addEventListener(MouseEvent.ROLL_OVER, hoverState);
         decompF.addEventListener(MouseEvent.ROLL_OUT, normalState);
         comp.addEventListener(MouseEvent.ROLL_OVER, hoverState);
         comp.addEventListener(MouseEvent.ROLL_OUT, normalState);
         compF.addEventListener(MouseEvent.ROLL_OVER, hoverState);
         compF.addEventListener(MouseEvent.ROLL_OUT, normalState);
         music.addEventListener(MouseEvent.ROLL_OVER, hoverState);
         music.addEventListener(MouseEvent.ROLL_OUT, normalState);
         music.addEventListener(MouseEvent.CLICK, concert);               
      }
      
	  function openSettings(param1:MouseEvent) : void
      {        
        settingswindow.visible = true;
        settingswindow.decomp.selectedColor = color1;
        settingswindow.comp.selectedColor = color2;
        settingswindow.decompF.selectedColor = color3;
        settingswindow.compF.selectedColor = color4;
        settingswindow.menuslider.value =  mslider * 10;
        settingswindow.msliden.text = mslider * 10;
        settingswindow.sfxslider.value = slider * 10;
        settingswindow.sliden.text = slider * 10;
        settingswindow.menuslider.minimum = settingswindow.sfxslider.minimum = 0;
        settingswindow.menuslider.maximum = settingswindow.sfxslider.maximum =  10;
        settingswindow.menuslider.snapInterval = settingswindow.sfxslider.snapInterval = 1;
        if(param1.currentTarget.name == "Sexitbutton") 
        {            
           SFXchannel = back.play(0, 1, SFXtrans);
           aboutwindow.sukapon.gotoAndStop(1);   
           aboutwindow.visible = false;
           aboutwindow.Sexitbutton.removeEventListener(MouseEvent.MOUSE_DOWN, openSettings);
           aboutwindow.Sexitbutton.removeEventListener(MouseEvent.ROLL_OVER, hoverState);
           aboutwindow.Sexitbutton.removeEventListener(MouseEvent.ROLL_OUT, normalState);
           aboutwindow.sukapon.removeEventListener(MouseEvent.CLICK,this.easteregg);
           aboutwindow.sukapon.removeEventListener(MouseEvent.ROLL_OVER, hoverState);
           aboutwindow.sukapon.removeEventListener(MouseEvent.ROLL_OUT, normalState);            
        }        
        settingswindow.decomp.addEventListener(ColorPickerEvent.CHANGE,changeColor);
        settingswindow.comp.addEventListener(ColorPickerEvent.CHANGE,changeColor);
        settingswindow.decompF.addEventListener(ColorPickerEvent.CHANGE,changeColor);
        settingswindow.compF.addEventListener(ColorPickerEvent.CHANGE,changeColor);        
        settingswindow.exitbutton.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        settingswindow.exitbutton.addEventListener(MouseEvent.ROLL_OVER, hoverState);
        settingswindow.exitbutton.addEventListener(MouseEvent.ROLL_OUT, normalState);
        settingswindow.aboutbutton.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        settingswindow.aboutbutton.addEventListener(MouseEvent.ROLL_OVER, hoverState);
        settingswindow.aboutbutton.addEventListener(MouseEvent.ROLL_OUT, normalState); 
        settingswindow.sfxslider.addEventListener(SliderEvent.CHANGE, bResize); 
        settingswindow.menuslider.addEventListener(SliderEvent.CHANGE, bResize);               
      }

     function onMouseDown(e:MouseEvent):void 
     {        
         if(e.currentTarget.name == "exitbutton") 
         {
            SFXchannel = back.play(0, 1, SFXtrans);    
            sfxdelay = true;            
         }
         settingswindow.visible = false;
         settingswindow.decomp.removeEventListener(ColorPickerEvent.CHANGE,changeColor);
         settingswindow.comp.removeEventListener(ColorPickerEvent.CHANGE,changeColor);
         settingswindow.decompF.removeEventListener(ColorPickerEvent.CHANGE,changeColor);
         settingswindow.compF.removeEventListener(ColorPickerEvent.CHANGE,changeColor);    
         settingswindow.exitbutton.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
         settingswindow.exitbutton.removeEventListener(MouseEvent.ROLL_OVER, hoverState);
         settingswindow.exitbutton.removeEventListener(MouseEvent.ROLL_OUT, normalState);
         settingswindow.aboutbutton.removeEventListener(MouseEvent.ROLL_OVER, hoverState);
         settingswindow.aboutbutton.removeEventListener(MouseEvent.ROLL_OUT, normalState);
         if(e.currentTarget.name == "aboutbutton") 
         {            
            SFXchannel = clicked.play(0, 1, SFXtrans);   
            aboutwindow.visible = true;
            aboutwindow.sukapon.suka_init.gotoAndPlay(1);
            aboutwindow.Sexitbutton.addEventListener(MouseEvent.MOUSE_DOWN, openSettings);
            aboutwindow.Sexitbutton.addEventListener(MouseEvent.ROLL_OVER, hoverState);
            aboutwindow.Sexitbutton.addEventListener(MouseEvent.ROLL_OUT, normalState);
            aboutwindow.sukapon.addEventListener(MouseEvent.CLICK,this.easteregg);
            aboutwindow.sukapon.addEventListener(MouseEvent.ROLL_OVER, hoverState);
            aboutwindow.sukapon.addEventListener(MouseEvent.ROLL_OUT, normalState);           
         } 
         
     }
	  
	  function bResize(event:SliderEvent) : void
     {         
         Log.log("Size of em are " + event.target.value);
         Log.log("The number came from " + event.target.name);
         if(event.target.name == "sfxslider")
         {
            slider = event.target.value / 10;
            SFXtrans = new SoundTransform(event.target.value / 10);
            SFXchannel.soundTransform = SFXtrans;
            settingswindow.sliden.text = event.target.value;            
            Log.log("slider is " + slider)
            
         }
         else if(event.target.name == "menuslider")
         {
            mslider = event.target.value / 10;
            Musictrans = new SoundTransform(event.target.value / 10); 
            Musicchannel.soundTransform = Musictrans;
            settingswindow.msliden.text = event.target.value;            
            Log.log("mslider is " + mslider)
         }
         SaveData.export();      
      }

      function hoverState(event:MouseEvent):void
      {         
         event.currentTarget.gotoAndStop(2);
         if(sfxdelay !== true && event.currentTarget.name !== "sukapon")
         {
            if(event.currentTarget.name == "settingsicon")
            {
               SFXchannel = onClickSet.play(0, 1, SFXtrans);
            }
            SFXchannel = onClick.play(0, 1, SFXtrans);    
         }
         else
         {
            sfxdelay = false;
         }       
         switch (event.currentTarget.name){
          case "decomp":            
            pressortext.text = "Choose one or more files to uncompress.";
            break;
          case "decompF":
            pressortext.text = "Choose a folder to uncompress.";
            break;
          case "comp":
            pressortext.text = "Choose one or more files to compress.";
            break;
          case "compF":
            pressortext.text = "Choose a folder to compress.";
            break;
 		    case "settingsicon":
           pressortext.text = "Adjust settings for Pressor.";
           break;
           case "music":
           pressortext.text = "Mute/unmute all the sounds.";
           break;  
          default:
            pressortext.text = "Pressor " + version.text;            
            break;
         };        
      }

      function easteregg(event:MouseEvent):void
      {
         Log.log("Not ready yet :)");
      }

      function concert(event:* = null):void
      {
         if(music.currentFrame == 1)
         {
            music.gotoAndStop(2);
            SoundMixer.soundTransform = new SoundTransform(0);
            music.removeEventListener(MouseEvent.ROLL_OVER, hoverState);
            music.removeEventListener(MouseEvent.ROLL_OUT, normalState);
            muteCheck = true;
            SaveData.export(); 
         }
         else
         {
            music.gotoAndStop(1);
            SoundMixer.soundTransform = new SoundTransform(1);
            music.addEventListener(MouseEvent.ROLL_OVER, hoverState);
            music.addEventListener(MouseEvent.ROLL_OUT, normalState); 
            muteCheck = false;
            SaveData.export();
         }
      }
      
      function normalState(event:MouseEvent):void
      {
         if(event.currentTarget.name !== "sukapon")
         {
            event.currentTarget.gotoAndStop(1); 
         }
         else
         {
            event.currentTarget.stop();
         }         
         pressortext.text = "Pressor " + version.text;
      }

      function changeColor(param1:ColorPickerEvent) : void
      {         
         color.saturation = -100;
         var c:Color = new Color();  
         c.setTint(param1.color, 0.69);
         filter = new ColorMatrixFilter(color.CalculateFinalFlatArray());
         switch (param1.currentTarget.name){
            case "decomp":            
            decomp.ucomp_button.filters = [filter];
            decomp.ucomp_button.transform.colorTransform = c;
            color1 = param1.color;     
            break;
            case "comp":            
            comp.ucomp_button.filters = [filter];     
            comp.ucomp_button.transform.colorTransform = c;
            color2 = param1.color;
            break;
            case "decompF":            
            decompF.ucomp_button.filters = [filter]; 
            decompF.ucomp_button.transform.colorTransform = c;  
            color3 = param1.color;  
            break;
            case "compF":            
            compF.ucomp_button.filters = [filter];    
            compF.ucomp_button.transform.colorTransform = c; 
            color4 = param1.color;
            break;
         } 
         SaveData.export();
      }    
      
      public function doIt(param1:MouseEvent) : void
      {
         SFXchannel = clicked.play(0, 1, SFXtrans);
         pressortext.text = "Pressor " + version.text;         
         if(param1.currentTarget.name == "decomp" || param1.currentTarget.name == "decompF")
         {
            this.WexisanIdiot = true;
            Log.log("Begin uncompression sequence");
            txtFilter = new FileFilter("Select up to 100 files", "*.ssf;*.ssfrec"); 
         }
         else
         {
            this.WexisanIdiot = false;
            Log.log("Begin compression sequence");
            txtFilter = new FileFilter("Select up to 100 files", "*.swf"); 
         }        
         try
         {            
            if(param1.currentTarget.name == "decompF" || param1.currentTarget.name == "compF")
            {
               Log.log("One of the folder buttons were pressed.");
               sukapon = true;
               docsDir.browseForDirectory("Select a folder");
               docsDir.addEventListener(Event.SELECT, filesSelected);
            }
            else
            {
               Log.log("One of the file buttons were pressed.");
               sukapon = false;               
               docsDir.browseForOpenMultiple("Select files", [txtFilter]);              
               docsDir.addEventListener(FileListEvent.SELECT_MULTIPLE, filesSelected);               
            }            
         }
         catch (error:Error)
         {
            Log.log("Failed:", error.message);
         } 
      }
      
      private function filesSelected(event:*):void 
      {
        Log.log("Wex boolean: " + this.WexisanIdiot)          
        startingTime = getTimer();       
        FileData = c = new ByteArray();        
        x = i = l = n = 0;           
        if(sukapon == true)
        {
           docsDir = event.target as File;         
           files = Vector.<Object>(docsDir.getDirectoryListing());
           thelength = files.length;        
           for (i = 0; i < thelength; i++) 
           {       
               if (files[i].nativePath.indexOf(".sw") !== -1 && (this.WexisanIdiot == true || files[i].modificationDate.getTime() <= oldtime)) 
               {
                  Log.log("Removing swf " + files[i].nativePath);
                  files.removeAt(i);                 
                  i--                       
               }               
               if (files[i].nativePath.indexOf(".ss") !== -1 && this.WexisanIdiot == false)
               {                  
                  Log.log("Removing ssf " + files[i].nativePath);                       
                  files.removeAt(i); 
                  i--                                    
               }       
               if(i !== -1)
               {       
                 if (files[i].modificationDate.getTime() > oldtime)
                 {
                    oldtime = files[i].modificationDate.getTime(); 
                    Log.log("oldtime " + oldtime);                                
                 }            
               }   
               n++
               if(n == thelength)
               {
                  i = thelength - 1
               }                                                          
           }                              
           thelength = files.length;
           n = 0;
           Log.log("thelength " + thelength);       
        }
        else 
        {
           thelength = event.files.length;
           files = Vector.<Object>(event.files);
           docsDir = new File(files[0].nativePath.substr(0, files[i].nativePath.lastIndexOf("\\") + 1));           
        }                
        SaveData.export(); 
        for (i = 0; i < thelength; i++) 
        {           
            //Log.log(files[i].modificationDate.getTime());                        
            fs.open(files[i], FileMode.READ);
            fs.readBytes(FileData);
            fs.close();
            c = new ByteArray();    
            try
            {                
               if(this.WexisanIdiot == true)                      
               {          
                  files[i].nativePath = files[i].nativePath.replace(".ssf",".swf");  
                  FileData.uncompress(CompressionAlgorithm.ZLIB);              
                  l = FileData.readInt();
                  n = FileData.readInt();                             
                  for(x = 0; x < n; x++)
                  {
                     FileData.readInt();                                   
                  }
                  c.writeBytes(FileData,FileData.position,l);               
                  FileData = c;                                               
               }
               if(this.WexisanIdiot == false)
               {                              
                  files[i].nativePath = files[i].nativePath.replace(".swf",".ssf");                                            
                  c.writeInt(FileData.length);            
                  for (x = 0; x < 1; x++) 
                  {
                     c.writeInt(0);
                  } 
                  c.writeBytes(FileData);               
                  FileData = c;                     
                  FileData.compress(CompressionAlgorithm.ZLIB);                                              
               }               
               Log.log(files[i].nativePath);               
               fs.open(files[i], FileMode.WRITE);           	            
               fs.writeBytes(FileData);
               fs.close();                              	               
               //Log.log(System.totalMemory / 1024);
               FileData.length = c.length = 0;              
               FileData.clear();
               c.clear();
               l = x = n = null;                         
               System.pauseForGCIfCollectionImminent(1);                           
               System.gc();
               System.gc();         
               stage.nativeWindow.title = PressorTitle + (i + 1) + "/" + thelength + " | " + (Math.round((i + 1) / thelength * 100)) + "% complete";                    
            }
            catch(err:Error)
            {
               Log.log("File was unable to be Pressor'd " + err.message)               
            }   
         }
         if(Capabilities.os.indexOf("Windows") >= 0)
         {
            if(WexisanIdiot == false)
            {
               SSF2Dir.nativePath = docsDir.nativePath.substr(0, docsDir.nativePath.lastIndexOf("\\") + 1) + "SSF2.exe";                    
               Log.log(SSF2Dir.nativePath)
               nativeProcessStartupInfo.executable = SSF2Dir; 
               process = new NativeProcess();              
               process.start(nativeProcessStartupInfo);
               stage.nativeWindow.minimize();           
            }
            if(WexisanIdiot == true && thelength < 6)
            {
               for (i = 0; i < thelength; i++) 
               {              
                  files[i].nativePath = files[i].nativePath.replace(".ssf",".swf");                  
                  nativeProcessStartupInfo.executable = swffile;                  
                  processArgs[0] = files[i].nativePath;   
                  nativeProcessStartupInfo.arguments = processArgs; 
                  process = new NativeProcess();                             
                  process.start(nativeProcessStartupInfo);
                  Log.log("Opening " + files[i].nativePath);
                  stage.nativeWindow.minimize();       
               }
            }
         }     
         Log.log("Done");	 
         endingTime = getTimer();        
         stage.nativeWindow.notifyUser(NotificationType.INFORMATIONAL);               
         if(NativeApplication.supportsDockIcon)
         {            
            dockIcon.bounce(NotificationType.INFORMATIONAL);
         }     
         pressortext.text = stage.nativeWindow.title + " | Finished in " +  (endingTime - startingTime) / 1000 + " seconds!";
      }  

      function on_loadComplete(e:Event):void
      {
         var image:DisplayObject = loader.content;       
         image.width = 720;
         image.height = 480;
         bgimage.addChild(loader);          
      }    

      function randomRange(minNum:Number, maxNum:Number):Number 
      {         
         return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);         
      }     
   }
}
