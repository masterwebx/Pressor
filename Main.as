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

      public static var ponpon:Boolean;

      public static var sukaponchecked:Boolean;

      private var easteregg_act:Boolean;

      private var sfxdelay:Boolean;

      public static var autocompress:Boolean = false; //not ready yet

      public static var muteCheck:Boolean = false;

      public static var imagebool:Boolean = true;

      private var startingTime:int;

      private var endingTime:int;  

      public static var x:int = 0;   

      public static var i:int = 0;

      public static var l:int = 0;

      public static var n:int = 0;  

      public static var load:int = 0;

      private var whichloader:int = 0; 

      private var thelength:int;    

      public static var mslider:Number = 0.6;

      public static var slider:Number = 0.4;      
      
      public static var color1:String = "102";

      public static var color2:String = "10027008";    

      public static var color4:String = "3368703";    
      
      public static var color3:String = "12104812";  

      public static var PressorTitle:String;

      public static var screenString:String = File.applicationDirectory.resolvePath("wallpapers").nativePath;

      public static var musicString:String = File.applicationDirectory.resolvePath("music").nativePath; 

      public static var sfxString:String = File.applicationDirectory.resolvePath("sfx").nativePath;

      public static var loadme:String;  
      
      public static var specialname:String;        

      public static var processArgs = new Vector.<String>;   

      public static var files:Vector.<Object> = new Vector.<Object>();

      public static var docsDir:File = File.documentsDirectory;

      public static var SSF2Dir:File = File.documentsDirectory;   

      public static var swffile:File = File.applicationDirectory.resolvePath("ffdec.exe"); 

      public static var screens:File = new File(screenString);

      public static var musics:File = new File(musicString);

      public static var sfxs:File = new File(sfxString);

      public static var loadmeup:File = new File;

      public static var txtFilter:FileFilter;

      private var filter:ColorMatrixFilter; 

      public static var fs:FileStream = new FileStream();
      
      public static var nativeProcessStartupInfo = new NativeProcessStartupInfo();  
      
      public static var loader:Loader = new Loader();  

      private var FileData:ByteArray = new ByteArray;

      private var c:ByteArray = new ByteArray();         

      private var color:AdjustColor = new AdjustColor();       
         
      public static var MenuMusic:Sound;

      public static var B_MenuMusic:Sound = new (menu);     

      public static var onClick:Sound;         

      public static var back:Sound;      

      public static var onClickSet:Sound;      

      public static var clicked:Sound;  

      public static var B_onClick:Sound = new (ff7cursor);         

      public static var B_back:Sound = new (backSound);      

      public static var B_onClickSet:Sound = new (wark);      

      public static var B_clicked:Sound = new (confirm);      

      public static var SFXtrans:SoundTransform = new SoundTransform(0.3); 

      public static var Musictrans:SoundTransform = new SoundTransform(0.6); 

      public static var SFXchannel:SoundChannel;

      public static var Musicchannel:SoundChannel;

      public static var dockIcon:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;             

      public static var oldtime;    
      
      public function Main()
      {
         super();
         bgimage.ff7r.visible = false;
         bgimage.psb_spread.visible = false;  
         suka.visible = false;       
         settingswindow.visible = false;
         aboutwindow.visible = false;         
         stage.nativeWindow.title = pressortext.text = "Pressor " + foreground.version.text;
         PressorTitle = "Pressor " + foreground.version.text + " | ";
         SaveData.importer();        
         Log.create(this);
         Log.handleExceptions(this, true); 
         SFXtrans = new SoundTransform(slider);
         Musictrans = new SoundTransform(mslider);
         if(muteCheck == true)
         {
            concert();
         }
         if(sukaponchecked == true)
         {
            easteregg();
            sfxloader();
         }
         else
         {                 
            imageloader();  
         }
         setTimeout(addListeners, 250);                           
      }

      function addListeners() : void
      {
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

      private function updateCart(e:MouseEvent):void
      {
         if(e.currentTarget.name == "cb1")
         {
            imagebool = !imagebool
            if(imagebool == false && bgimage.contains(loader) == true)
            {
               bgimage.removeChild(loader)
            }
            else
            {
               imageloader()
            }
         }
         else if(e.currentTarget.name == "cb2")
         {            
            sukaponchecked = !sukaponchecked;            
            if(sukaponchecked == true)
            {
               easteregg();
            }
            if(sukaponchecked == false)
            {
              Musicchannel.stop();
              var c:Color = new Color();
              settingswindow.wrapper.cb1.visible = true;
              settingswindow.decomp.visible = true;
              settingswindow.decompF.visible = true;
              settingswindow.comp.visible = true;
              settingswindow.compF.visible = true;
              bgimage.psb_spread.visible = false; 
              suka.visible = false;
              easteregg_act = false;
              load = 0;
              imageloader(); 
              buttoncolors();             
              color.saturation = color.contrast = color.brightness = 0; 
              color.hue = -1;           
              filter = new ColorMatrixFilter(color.CalculateFinalFlatArray());              
              foreground.icon.filters = [filter];                     
            }            
         }
         SaveData.export();
      }
      
	  function openSettings(param1:MouseEvent) : void
      {        
        settingswindow.visible = true;
        if(ponpon == false)
        {
           settingswindow.sukaegg.visible = false;
        }
        else
        {
           settingswindow.sukaegg.visible = true;
        }
        if(imagebool == true)
        {
           settingswindow.wrapper.cb1.selected = true;
        }
        if(easteregg_act == true)
        {
           Log.log("that's tough, buddy");           
           settingswindow.wrapper.cb1.visible = false;
           settingswindow.decomp.visible = false;
           settingswindow.decompF.visible = false;
           settingswindow.comp.visible = false;
           settingswindow.compF.visible = false;
        }
        else
        {
           settingswindow.decomp.selectedColor = color1;
           settingswindow.comp.selectedColor = color2;
           settingswindow.decompF.selectedColor = color3;
           settingswindow.compF.selectedColor = color4;
        }
        settingswindow.wrapper.menuslider.value =  mslider * 10;
        settingswindow.msliden.text = mslider * 10;
        settingswindow.wrapper.sfxslider.value = slider * 10;
        settingswindow.sliden.text = slider * 10;
        settingswindow.wrapper.menuslider.minimum = settingswindow.wrapper.sfxslider.minimum = 0;
        settingswindow.wrapper.menuslider.maximum = settingswindow.wrapper.sfxslider.maximum =  10;
        settingswindow.wrapper.menuslider.snapInterval = settingswindow.wrapper.sfxslider.snapInterval = 1;
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
        settingswindow.wrapper.sfxslider.addEventListener(SliderEvent.CHANGE, bResize); 
        settingswindow.wrapper.menuslider.addEventListener(SliderEvent.CHANGE, bResize); 
        settingswindow.wrapper.sfxslider.addEventListener(SliderEvent.THUMB_RELEASE, bResize);
        settingswindow.wrapper.cb1.addEventListener(MouseEvent.CLICK,updateCart);
        settingswindow.sukaegg.sukabox.cb2.addEventListener(MouseEvent.CLICK,updateCart);                            
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
         settingswindow.wrapper.cb1.removeEventListener(MouseEvent.CLICK,updateCart); 
         settingswindow.sukaegg.sukabox.cb2.removeEventListener(MouseEvent.CLICK,updateCart); 
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
         if(event.target.name == "menuslider")
         {
            mslider = event.target.value / 10;
            Musictrans = new SoundTransform(event.target.value / 10); 
            Musicchannel.soundTransform = Musictrans;
            settingswindow.msliden.text = event.target.value;      
         } 
         if(event.target.name == "sfxslider")
         {
            slider = event.target.value / 10;
            SFXtrans = new SoundTransform(event.target.value / 10);
            SFXchannel.soundTransform = SFXtrans;
            settingswindow.sliden.text = event.target.value;     
            if(event.type == "thumbRelease")
            {
               SFXchannel = clicked.play(0, 1, SFXtrans);   
            }         
         }            
         SaveData.export();      
      }

      function hoverState(event:MouseEvent):void
      {         
         suka.visible = false;
         event.currentTarget.gotoAndStop(2);
         if(event.currentTarget.name == "settingsicon")
         {
            SFXchannel = onClickSet.play(0, 1, SFXtrans);
         }
         else if(sfxdelay !== true && event.currentTarget.name !== "sukapon" )
         {            
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
            if(easteregg_act == true)
            {
               suka.visible = true;
            }                                 
            break;
         };        
      }

      function easteregg(event:* = null) : void
      {
         if(easteregg_act !== true)
         {
           bgimage.ff7r.visible = false;
           var c:Color = new Color();
           Log.log("Thank you for finding me :)");
           sukaponchecked = true;
           settingswindow.wrapper.cb1.visible = false;
           settingswindow.decomp.visible = false;
           settingswindow.decompF.visible = false;
           settingswindow.comp.visible = false;
           settingswindow.compF.visible = false;
           settingswindow.sukaegg.sukabox.cb2.selected = true;
           easteregg_act = true;
           ponpon = true;    
           SaveData.export();
           try
           {
               Musicchannel.stop();	 
               bgimage.removeChild(loader);   
           }
           catch(e:Error)
           {
              Log.log("There is no image/sound to remove. " + e.message)
           }           
           bgimage.psb_spread.visible = true;            
           color.saturation = color.contrast = color.brightness = 0; 
           color.hue = 74;           
           filter = new ColorMatrixFilter(color.CalculateFinalFlatArray());
           foreground.icon.filters = [filter];    
           buttoncolors(true); 
           MenuMusic = new (sukapontheme);		     
           Musicchannel = MenuMusic.play(0, int.MAX_VALUE, Musictrans);
         }
      }

      function buttoncolors(suki:Boolean = false):void
      {
         var c:Color = new Color();
         var Acolor:String = color1;
         var Bcolor:String = color2;
         var Ccolor:String = color3;
         var Dcolor:String = color4;
         if(suki == true)
         {
            Acolor = Bcolor = Ccolor = Dcolor = "1";
         }
         color.saturation = color.hue = color.contrast = color.brightness = 0; 
         filter = new ColorMatrixFilter(color.CalculateFinalFlatArray());
         decomp.ucomp_button.filters = comp.ucomp_button.filters = compF.ucomp_button.filters = decompF.ucomp_button.filters = [filter];        
         if(Acolor && Bcolor && Ccolor && Dcolor > 0)
         {            
            color.saturation = -100;
            c.setTint(Acolor, 0.69);
            decomp.ucomp_button.transform.colorTransform = c;
            c.setTint(Bcolor, 0.69);
            comp.ucomp_button.transform.colorTransform = c;
            c.setTint(Ccolor, 0.69);
            decompF.ucomp_button.transform.colorTransform = c;
            c.setTint(Dcolor, 0.69); 
            compF.ucomp_button.transform.colorTransform = c;
         }
         bgimage.mouseEnabled = false;
         bgimage.mouseChildren = false;         
      }

      function imageloader():void
      {
         bgimage.ff7r.visible = false;
         Log.log("Booting up image loader");
         if(imagebool == true)
         {
            try
            {   
               var files:Array = screens.getDirectoryListing();
               for (i = 0; i < files.length; i++)
               {        
                  if(files[i].extension == "png")
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
               Log.log("Found " + files[n].name);   
               loader.load(new URLRequest(loadme));                     
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE, on_imageComplete);
               specialname = files[n].name.replace(".png","").toLowerCase()
               Log.log("specialname " + specialname)                
            }
            catch(e:Error)
            {   
               bgimage.ff7r.visible = true;
               Log.log("Image failed to load: " + e.message)
               if(!screens.exists)
               {
                  screens.createDirectory();
                  Log.log("Created a directory for screens here: " + screens.nativePath)
               }
               if(load !== 2)
               { 
                  musicloader();
                  load++
               }          
            }		   
         }
         Log.log("Finished loading image!");         
      }

      function musicloader():void
      {
         var exceptional:Boolean;
         Log.log("Booting up music loader");        
         try
         {   
            var files:Array = musics.getDirectoryListing();
            for (i = 0; i < files.length; i++)
            {                      
               if(files[i].name.replace(".mp3","").toLowerCase() == specialname && specialname !== "")
               {                 
                  exceptional = true; 
                  break;                          
               }
               if(files[i].extension == "mp3")
               {
                  continue;          
               }
               else
               {
                  files.removeAt(i); 
                  i--
               }               
            }
            if(exceptional == true)
            {
               loadme = files[i].nativePath;
               n = i
            }
            else if(exceptional == false)
            {
               n = randomRange(0, files.length - 1);                    
               loadme = files[n].nativePath;
            }
            Log.log("Found music " + loadme); 
            specialname = files[n].name.replace(".mp3","").toLowerCase()
            Log.log("specialname " + specialname)    
            MenuMusic = new Sound();                       
            MenuMusic.addEventListener(Event.COMPLETE, on_musicComplete);
            MenuMusic.load(new URLRequest(loadme));
                            
         }
         catch(e:Error)
         {   
            Log.log("Music failed to load: " + e.message)
            MenuMusic = B_MenuMusic
            Musicchannel = MenuMusic.play(0, int.MAX_VALUE, Musictrans);
            if(!musics.exists)
            {
               musics.createDirectory();
               Log.log("Created a directory for musics here: " + musics.nativePath)
            }
            if(load !== 2)
            {
               sfxloader();
               load++
            }               
         } 
         Log.log("Finished loading music!");         
      }

      function sfxloader(music:String = null):void
      {
         var exceptional:Boolean;
         Log.log("Booting up sfx loader");        
         try
         {   
            var files:Array = sfxs.getDirectoryListing();
            Log.log(sfxs.getDirectoryListing());
            for (i = 0; i < files.length; i++)
            {              
               if(files[i].name.replace(".mp3","").toLowerCase() == specialname && specialname !== "")
               {
                  exceptional = true;  
                  break;
                         
               }
               if(files[i].isDirectory == true)
               {
                  continue;          
               }
               else
               {
                  files.removeAt(i); 
                  i--
               }               
            }
            if(exceptional == true)
            {
               Log.log("heya");
               loadmeup = files[i];
               n = i
            }
            else if(exceptional == false)
            {
               n = randomRange(0, files.length - 1);                    
               loadmeup = files[n];
            }
            Log.log("Found SFX " + files[n].name);            
            files = loadmeup.getDirectoryListing();                      
            for (i = 0; i < files.length; i++)
            { 
              if(files[i].name.indexOf("hover") !== -1 && files[i].name.indexOf(".mp3") !== -1)
              {
                  Log.log("hover" + files[i].nativePath); 
                  onClick = new Sound();                  
                  onClick.load(new URLRequest(files[i].nativePath));                
                  onClick.addEventListener(Event.COMPLETE, on_SFXComplete);              
              }
              if(files[i].name.indexOf("back") !== -1 && files[i].name.indexOf(".mp3") !== -1)
              {
                  Log.log("back" + files[i].nativePath); 
                  back = new Sound();                  
                  back.load(new URLRequest(files[i].nativePath));                
                  back.addEventListener(Event.COMPLETE, on_SFXComplete);              
              } 
              if(files[i].name.indexOf("click") !== -1 && files[i].name.indexOf(".mp3") !== -1)
              {
                  Log.log("click" + files[i].nativePath); 
                  clicked = new Sound();                  
                  clicked.load(new URLRequest(files[i].nativePath));                
                  clicked.addEventListener(Event.COMPLETE, on_SFXComplete);              
              } 
              if(files[i].name.indexOf("settings") !== -1 && files[i].name.indexOf(".mp3") !== -1)
              {
                  Log.log("settings" + files[i].nativePath); 
                  onClickSet = new Sound();                  
                  onClickSet.load(new URLRequest(files[i].nativePath));                
                  onClickSet.addEventListener(Event.COMPLETE, on_SFXComplete);              
              }     
              if(i == 3)
              {
                 break;
              } 
            }                   
         }
         catch(e:Error)
         {   
            onClick = B_onClick;
            back = B_back;
            onClickSet = B_onClickSet;
            clicked = B_clicked;    
            Log.log("SFX failed to load: " + e.message)
            if(!sfxs.exists)
            {
               sfxs.createDirectory();
               Log.log("Created a directory for SFX here: " + sfxs.nativePath)
            }
            if(easteregg_act !== true)
            { 
               buttoncolors();
            }               
         }
         Log.log("Finished loading SFX!");         
      }  

      function concert(event:* = null):void
      {
         if(muteCheck == false)
         {
            music.gotoAndStop(2);
            SoundMixer.soundTransform = new SoundTransform(0);            
            muteCheck = true;
            SaveData.export(); 
         }
         else
         {
            music.gotoAndStop(1);
            SoundMixer.soundTransform = new SoundTransform(1);           
            muteCheck = false;
            SaveData.export();
         }
      }
      
      function normalState(event:MouseEvent):void
      {
         if(easteregg_act == true)
         {
            suka.visible = true;
         }
         if(event.currentTarget.name !== "sukapon")
         {
            event.currentTarget.gotoAndStop(1); 
         }
         else
         {
            event.currentTarget.stop();
         }         
         pressortext.text = "Pressor " + foreground.version.text;
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
         pressortext.text = "Pressor " + foreground.version.text;         
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

      function on_imageComplete(e:Event):void
      {       
         var image:DisplayObject = loader.content;       
         image.width = 720;
         image.height = 480;
         bgimage.addChild(loader);
         Log.log("It's Bond, James Imaged Bond.")
         if(load !== 2)
         {
           musicloader(); 
           load++
         }            
      } 

      function on_musicComplete(e:Event):void
      {
         Musicchannel = MenuMusic.play(0, int.MAX_VALUE, Musictrans);
         Log.log("gaming")
         if(load !== 2)
         {
           sfxloader();
           load++
         }                    
      }   

      function on_SFXComplete(e:Event):void
      {         
         Log.log("sfx bois");
         if(easteregg_act !== true)
         { 
            buttoncolors();
         }                 
      }

      function randomRange(minNum:Number, maxNum:Number):Number 
      {         
         return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);         
      }     
   }
}
