package
{
   import flash.display.*;    
   import flash.media.*;
   import flash.geom.*;  
   import flash.net.*;
   import fl.events.*;
   import fl.display.*;
   import fl.events.ComponentEvent;
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
   import fl.accessibility.ComboBoxAccImpl;
   import fl.data.DataProvider; 
   import fl.events.ComponentEvent; 
   import fl.controls.ComboBox;   	
  
   public class Mania extends MovieClip
   {      
      var m_movie:MovieClip;      

      var zloaderContext:LoaderContext = new LoaderContext(); 

      var superloader:ProLoader = new ProLoader();    
      
      private var WexisanIdiot:Boolean;  

      private var sukapon:Boolean;

      public static var ponpon:Boolean;

      public static var sukaponchecked:Boolean;

      private var easteregg_act:Boolean;

      private var sfxdelay:Boolean;

      public static var autocompress:Boolean = false; //not ready yet

      public static var muteCheck:Boolean = false;

      public static var startup:Boolean = true;

      public static var firstload:Boolean = false;

      public static var imagebool:Boolean = true;

      private var startingTime:int;

      private var endingTime:int; 

      public static var e:int = 0 

      public static var x:int = 0;   

      public static var i:int = 0;

      public static var l:int = 0;

      public static var n:int = 0;  

      public static var load:int = 0;     

      private var thelength:int;

      private var fileticker:int;        

      public static var mslider:Number = 0.6;

      public static var slider:Number = 0.4;      
      
      public static var color1:String = "102";

      public static var color2:String = "10027008";    

      public static var color4:String = "3368703";    
      
      public static var color3:String = "12104812";        

      public static var screenString:String = File.applicationDirectory.resolvePath("wallpapers").nativePath;

      public static var musicString:String = File.applicationDirectory.resolvePath("music").nativePath; 

      public static var sfxString:String = File.applicationDirectory.resolvePath("sfx").nativePath;

      public static var loadme:String;  
      
      public static var specialname:String = "";        

      public static var processArgs = new Vector.<String>;   

      public static var files:Vector.<Object> = new Vector.<Object>();

      public static var musicfolder:File = new File;

      public static var stagefolder:File = new File;

      public static var miscfolder:File = new File;

      public static var modefolder:File = new File;

      public static var menufolder:File = new File;

      public static var characterfolder:File = new File;

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
      
      public static var loader:ProLoader = new ProLoader();  

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

      public static var JMF_onClick:Sound = new (jmf_hover);         

      public static var JMF_back:Sound = new (jmf_back);      

      public static var JMF_onClickSet:Sound = new (jmf_settings);      

      public static var JMF_clicked:Sound = new (jmf_click);

      public static var B_sukapon:Sound = new (sukapontheme);      

      public static var SFXtrans:SoundTransform = new SoundTransform(0.3); 

      public static var Musictrans:SoundTransform = new SoundTransform(0.6); 

      public static var SFXchannel:SoundChannel;

      public static var Musicchannel:SoundChannel;

      public static var dockIcon:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;             

      public static var oldtime;    
      
      public function Mania()
      {
        super();
        bgimage.ff7r.visible = false;
        bgimage.psb_spread.visible = false;  
        suka.visible = false;       
        settingswindow.visible = false;
        aboutwindow.visible = false;         
        stage.nativeWindow.title = pressortext.text = "Pressor " + foreground.version.text;  
        SaveData.importer();        
        Log.create(this);
        Log.handleExceptions(this, true); 
        SFXtrans = new SoundTransform(slider);
        Musictrans = new SoundTransform(mslider);
        Log.log("Mute is " + muteCheck)
        if(muteCheck == true)
        {
           concert();
        }
        if(sukaponchecked == true)
        {
           easteregg();
           sfxloader();            
        }
        else if(sukaponchecked == false)
        {                 
           imageloader();  
        }         
        ComboBoxAccImpl.enableAccessibility();                         
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

      private function updateCart(e:MouseEvent = null):void
      {         
        var em:String;      
		if(e == null)
		{
		    em = "cb2" 
        }	
		else
		{
			em = e.currentTarget.name;   
        }		  
		if(em == "cb1")
        {
          imagebool = !imagebool
          if(imagebool == false)
          {               
             bgimage.visible = false;
          }
          else
          {
             bgimage.visible = true;
          }
        }
        else if(em == "cb2")
        {            
            sukaponchecked = !sukaponchecked;            
            if(sukaponchecked == true)
            {
               MenuMusic = B_sukapon;
               Musicchannel.stop();
               Musicchannel = MenuMusic.play(0, int.MAX_VALUE, Musictrans);	
               easteregg();
            }
            if(sukaponchecked == false)
            {
              settingswindow.sukaegg.sukabox.selected = false;
			    Musicchannel.stop();
              var c:Color = new Color();
              settingswindow.wrapper.cb1.visible = true;
              settingswindow.decomp.visible = true;
              settingswindow.decompF.visible = true;
              settingswindow.comp.visible = true;
              settingswindow.compF.visible = true;
              bgimage.psb_spread.visible = false;
              settingswindow.decomp.selectedColor = color1;
              settingswindow.comp.selectedColor = color2;
              settingswindow.decompF.selectedColor = color3;
              settingswindow.compF.selectedColor = color4; 
              suka.visible = false;
              easteregg_act = false;
              load = 0;
              imageloader();                            
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
        stage.nativeWindow.title = pressortext.text = "Pressor " + foreground.version.text;
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
           suka.visible = true;
           sukaponchecked = true;
           settingswindow.wrapper.cb1.visible = false;
           settingswindow.decomp.visible = false;
           settingswindow.decompF.visible = false;
           settingswindow.comp.visible = false;
           settingswindow.compF.visible = false;
           settingswindow.sukaegg.sukabox.cb2.selected = true;
           easteregg_act = true;
           ponpon = true;
           onClick = JMF_onClick;
           back = JMF_back;
           onClickSet = JMF_onClickSet;
           clicked = JMF_clicked;              
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
           MenuMusic = B_sukapon;          
           Musicchannel = MenuMusic.play(0, int.MAX_VALUE, Musictrans);	
           specialname = "sukapon";
           SaveData.export();           
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
        setTimeout(addListeners, 50);
        loading.visible = false;         
      }

      function imageloader():void
      {             
        var exceptional:Boolean;
        bgimage.ff7r.visible = false;
        Log.log("Booting up image loader" + specialname);
        if(imagebool == false)
        {
           bgimage.visible = false;
        }   
           try
           {   
              if(specialname == "ff7 remake")
              {
                bgimage.ff7r.visible = true;
                throw Error("FF7 remake override");                 
              } 
              var files:Array = screens.getDirectoryListing();               
              for (i = 0; i < files.length; i++)
              {                  
                 if(specialname !== "" && files[i].name.replace(".png","").toLowerCase() == specialname)
                 {
                    exceptional = true;
                    break;
                 }
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
              if(specialname !== "" && exceptional == true)
              {
                 loadme = files[i].nativePath;
              } 
              else
              {         
                n = randomRange(0, files.length - 1);                    
                loadme = files[n].nativePath;
                specialname = files[n].name.replace(".png","").toLowerCase()
              }
              Log.log("specialname " + specialname)                        
              Log.log("Found " + specialname);   
              loader.load(new URLRequest(loadme));                     
              loader.contentLoaderInfo.addEventListener(Event.COMPLETE, on_imageComplete);                      
           }
           catch(e:Error)
           {   
              if(specialname == "ff7 remake")
              {                
                load = 1
                musicloader();                                             
              }   
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
        Log.log("Finished loading image!");         
      }

      function Cimageloader(event:Event) : void
      {         
        if(easteregg_act == true)
        {            
           sukaponchecked = true
           updateCart()
        }
        bgimage.psb_spread.visible = false;  
        if(bgimage.contains(loader) == false)
        {                     
           bgimage.addChild(loader);
        }        
		Musicchannel.stop();
        load = 0;         
        specialname = settingswindow.droptheme.selectedItem.label.toLowerCase();
        SaveData.export();             
        Log.log("Booting up custom image loader and " + specialname);           
        try
        {   
           var files:Array = screens.getDirectoryListing();
           for (i = 0; i < files.length; i++)
           {        
              Log.log(files[i].name.replace(".png","").toLowerCase())
              if(specialname !== "" && files[i].name.replace(".png","").toLowerCase() == specialname)
              {                  
                break;
              }               
              else
              {
                files.removeAt(i); 
                i--
              }               
           }            
           loadme = files[i].nativePath;        
           Log.log("Found " + files[i].name);   
           loader.load(new URLRequest(loadme));                     
           loader.contentLoaderInfo.addEventListener(Event.COMPLETE, on_imageComplete);            
        }
           catch(e:Error)
           {   
              if(specialname == "ff7 remake")
              {
                bgimage.ff7r.visible = true;
                if(bgimage.contains(loader) == true)
                {                     
                   bgimage.removeChild(loader);
                }                
              }             
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
        Log.log("Finished loading image!");
        SaveData.export();         
      }

      function musicloader():void
      {
        var exceptional:Boolean;
        Log.log("Booting up music loader");        
        try
        {   
           if(specialname == "sukapon")
           {
              sfxloader();
           }
           if(specialname == "ff7 remake")
           {
              throw Error("FF7 music override")
           }
           else if(specialname !== "default" || specialname == "sukapon")
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
        }
        catch(e:Error)
        {   
           Log.log("Music failed to load: " + e.message)
           MenuMusic = B_MenuMusic
           onClick = B_onClick;
           back = B_back;
           onClickSet = B_onClickSet;
           clicked = B_clicked;
           bgimage.ff7r.visible = false;
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
            var dropitdown:Array = new Array();
            var tempName:String;
            var files:Array = sfxs.getDirectoryListing();                          
            for (i = 0; i < files.length; i++)
            {           
               if(i == 0 && firstload == false)
               {
                  settingswindow.droptheme.addItem({label: "Random"});
                  settingswindow.droptheme.addItem({label: "FF7 Remake"});
               }
               if(files[i].isDirectory == true && firstload == false)
               {
                  settingswindow.droptheme.addItem({label: files[i].name});                      
               }
               if(files[i].name.toLowerCase() == specialname)
               {               
                  Log.log(i)
                  settingswindow.droptheme.selectedItem = settingswindow.droptheme.getItemAt(i + 2);
               }
            }            
            settingswindow.droptheme.addEventListener(Event.CHANGE, Cimageloader);
            firstload = true;
            if(specialname == "ff7 remake")
            {               
               bgimage.ff7r.visible = true;
               settingswindow.droptheme.selectedItem = settingswindow.droptheme.getItemAt(1);
               throw Error("FF7 remake override");
            }
            if(specialname == "sukapon" && easteregg_act == true)
            {
               onClick = JMF_onClick
               back = JMF_back
               onClickSet = JMF_onClickSet
               clicked = JMF_clicked
               settingswindow.droptheme.selectedItem = settingswindow.droptheme.getItemAt(1);
               throw Error("Easter egg override");
            }   
            i = 0;            
            for (i = 0; i < files.length; i++)
            {           
               if(files[i].name.toLowerCase() == specialname && specialname !== "")
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
                Log.log("hover " + files[i].nativePath); 
                onClick = new Sound();                  
                onClick.load(new URLRequest(files[i].nativePath));                
                onClick.addEventListener(Event.COMPLETE, on_SFXComplete);              
              }
              if(files[i].name.indexOf("back") !== -1 && files[i].name.indexOf(".mp3") !== -1)
              {
                Log.log("back " + files[i].nativePath); 
                back = new Sound();                  
                back.load(new URLRequest(files[i].nativePath));                
                back.addEventListener(Event.COMPLETE, on_SFXComplete);              
              } 
              if(files[i].name.indexOf("click") !== -1 && files[i].name.indexOf(".mp3") !== -1)
              {
                Log.log("click " + files[i].nativePath); 
                clicked = new Sound();                  
                clicked.load(new URLRequest(files[i].nativePath));                
                clicked.addEventListener(Event.COMPLETE, on_SFXComplete);              
              } 
              if(files[i].name.indexOf("settings") !== -1 && files[i].name.indexOf(".mp3") !== -1)
              {
                Log.log("settings " + files[i].nativePath); 
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

      function concert(e:Event = null):void
      {
         Log.log(muteCheck + " ugh " + startup)
         if(muteCheck == false || startup == true)
         {
            music.gotoAndStop(2);
            SoundMixer.soundTransform = new SoundTransform(0);            
            muteCheck = true;
            startup = false;
            music.removeEventListener(MouseEvent.ROLL_OVER, hoverState);
            music.removeEventListener(MouseEvent.ROLL_OUT, normalState);
            SaveData.export(); 
         }
         else if(muteCheck == true)
         {
            music.gotoAndStop(1);
            SoundMixer.soundTransform = new SoundTransform(1);           
            muteCheck = false;
            music.addEventListener(MouseEvent.ROLL_OVER, hoverState);
            music.addEventListener(MouseEvent.ROLL_OUT, normalState);
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
         stage.nativeWindow.title = pressortext.text = "Pressor " + foreground.version.text;
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
      
      function filesSelected(event:*):void 
      {     
        settingsicon.removeEventListener(MouseEvent.CLICK,this.openSettings);
        fileticker = -1;
        startingTime = getTimer();         
        Log.log("Wex boolean: " + this.WexisanIdiot)                    
        FileData = c = new ByteArray();        
        x = i = l = n = 0;           
        if(sukapon == true)
        {
           docsDir = event.target as File;         
           files = Vector.<Object>(docsDir.getDirectoryListing());
           thelength = files.length; 		               
        }
        else 
        {
           thelength = event.files.length;
           files = Vector.<Object>(event.files);
           docsDir = new File(files[0].nativePath.substr(0, files[i].nativePath.lastIndexOf("\\") + 1));           
        }                
        SaveData.export();                      
        i = 0;
        if(this.WexisanIdiot == true)                      
        {             
           checkforfolders();  
           uncompressSWF();
        }    
        if(this.WexisanIdiot == false)
        {                              
           compressSWF();                                                       
        } 
      }  

      function finale() : void
      {
        endingTime = getTimer();
        stage.nativeWindow.title =  "Finished in " +  (endingTime - startingTime) / 1000 + " seconds!";
        settingsicon.addEventListener(MouseEvent.CLICK,this.openSettings);
        stage.nativeWindow.notifyUser(NotificationType.INFORMATIONAL);               
        if(NativeApplication.supportsDockIcon)
        {            
           dockIcon.bounce(NotificationType.INFORMATIONAL);
        }
      }    
      function openSSF2() : void
      {       
        try
        {     
            SSF2Dir.nativePath = docsDir.nativePath.substring(docsDir.nativePath.lastIndexOf("data\\"),0) + "SSF2.exe";          
            Log.log(SSF2Dir.nativePath)
            nativeProcessStartupInfo.executable = SSF2Dir; 
            process = new NativeProcess();              
            process.start(nativeProcessStartupInfo);
            stage.nativeWindow.minimize(); 
            concert();
        }
        catch(err:Error)
        {
            Log.log(err.message)
            Log.log("SSF2.exe not found")
        }       
      }

      function openJPEXS() : void
      {
        try
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
        catch(err:Error)
        {
            Log.log("JPEXS files not found, please copy to application directory")
        }
      }  

      function compressSWF() : void
      {
           for(i = 0; i < thelength; i++)
           {
                  try
                  {   
					
                    Log.log(getExtension(files[i].nativePath))
					if(getExtension(files[i].nativePath) !== "swf")
                    {
                        throw Error ("Not a swf file");
                    }
					else
				    {
                    var input:String =  files[i].nativePath;  
                    fs.open(files[i], FileMode.READ);
                    fs.readBytes(FileData);
                    fs.close();
                    c = new ByteArray();                    
                    var removeme:String;
                    var saveme:String;
					Log.log("Current file path: " + input);
                    if(input.lastIndexOf("-") !== -1)
                    {    	
                       input = input.substring(0, input.lastIndexOf("-"));                                   
                       saveme = input.substring(input.lastIndexOf("\\") + 1);
                       removeme = input.substring(0, input.lastIndexOf("\\"));
                       removeme = removeme.substring(0, removeme.lastIndexOf("\\"));
                       files[i].nativePath =  removeme + "\\" + saveme + ".ssf";
                    }
                    else
                    {
                      files[i].nativePath = files[i].nativePath.replace(".swf",".ssf")
                    }                            
                    Log.log("Restored file path: " + files[i].nativePath);
                    c.writeInt(FileData.length);            
                    for (x = 0; x < 1; x++) 
                    {
                       c.writeInt(0);
                    } 
                    c.writeBytes(FileData);               
                    FileData = c;                     
                    FileData.compress(CompressionAlgorithm.ZLIB);
                    fs.open(files[i], FileMode.WRITE);           	            
                    fs.writeBytes(FileData);
                    fs.close();
                    FileData.length = c.length = 0;              
                    FileData.clear();
                    c.clear();
                    l = x = n = null;                         
                    System.pauseForGCIfCollectionImminent(1);                           
                    System.gc();
                    System.gc();  
				}
                }
                catch(err:Error)
                {
                  Log.log("Pressor couldn't compress this one " + err.message)
                  continue;
                 }
           }           
           if(Capabilities.os.indexOf("Windows") >= 0)
           {
               openSSF2();
           }
           finale()                     
      }    
      
      function uncompressSWF() : void
      {
        try
        {           
            Log.log(getExtension(files[i].nativePath));
            if(getExtension(files[i].nativePath == "ssf"))
            {
                Log.log("yeah lol")             
            }
            else
            {
                throw Error ("Not a ssf file");
            }
            if(i < thelength) 
            {         
               zloaderContext = new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain)); 
               zloaderContext.allowLoadBytesCodeExecution = true;   
               zloaderContext.allowCodeImport = true;  
               FileData = new  ByteArray;
               c = new ByteArray();                  
               fs.open(files[i], FileMode.READ);
               fs.readBytes(FileData);
               fs.close();                
               FileData.uncompress(CompressionAlgorithm.ZLIB);              
               l = FileData.readInt();
               n = FileData.readInt();                             
               for(x = 0; x < n; x++)
               {
                  FileData.readInt();                                   
               }
               c.writeBytes(FileData,FileData.position,l);               
               FileData = c;                    
               superloader.loadBytes(FileData, zloaderContext);
               superloader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadComplete);                       
            }
            else
            {
                Log.log("Done")               
                finale()                
                
                if(Capabilities.os.indexOf("Windows") >= 0 && thelength < 6)
                {
                    openJPEXS()
                }     
                return;
            }  
        }
        catch(err:Error)
        {
            Log.log(err.message + " File would not decompress moving to next one")
            if(i + 1 < length)
            {
                i++;
                uncompressSWF();
            }
            else
            {
              Log.log("Done")              
              finale()             
              if(Capabilities.os.indexOf("Windows") >= 0 && thelength < 6)
              {
                openJPEXS()
              }     
              return;  
            }           
            
        }     
      }

      function renamer() : void
      {
        fileticker++
        e = fileticker
        var newname:String = "";
        files[e].nativePath = files[e].nativePath.replace(".ssf","");
        try
        {  
            newname = "-" + superloader.content.getProp("id") + ".swf";
            files[e].nativePath = files[e].nativePath + newname;
            switch(true) 
            { 
                case superloader.content.getProp("id").indexOf("bgm_") !== -1: 
                    files[e].nativePath = musicfolder.nativePath + "\\" + files[e].name;
                    break;
                case superloader.content.getProp("id").indexOf("menu") !== -1: 
                    files[e].nativePath = menufolder.nativePath + "\\" + files[e].name;
                    break; 
                case superloader.content.getProp("id").indexOf("mode") !== -1: 
                     files[e].nativePath = modefolder.nativePath + "\\" + files[e].name; 
                    break;
                 case superloader.content.getProp("characters") !== null: 
                    files[e].nativePath = characterfolder.nativePath + "\\" + files[e].name;
                    break;     
                 case superloader.content.getProp("camera") !== null: 
                    files[e].nativePath = stagefolder.nativePath + "\\" + files[e].name;
                    break;                                                    
                 case superloader.content.getProp("camera") == null: 
                    files[e].nativePath = miscfolder.nativePath + "\\" + files[e].name;
                    break;                                
            }             
        }
        catch(err:Error)
        {
            newname = "_" + superloader.contentLoaderInfo.applicationDomain.getQualifiedDefinitionNames()[0] + ".swf";
            files[e].nativePath = files[e].nativePath + newname;
            files[e].nativePath = miscfolder.nativePath + "\\" + files[e].name;
        }  
        Log.log(files[e].nativePath)   
        fs.open(files[e], FileMode.WRITE);           	            
        fs.writeBytes(FileData);
        fs.close();    
        FileData.length = c.length = 0;              
        FileData.clear();
        c.clear();
        l = x = n = null;
        this.unload();         
      }

       private function loadComplete(e:Event) : void
       {        
            var nPercent:int = Math.round(i / files.length * 100);           
            trace("Successfully loaded " + files[i].name);            
            pressortext.text = nPercent.toString() + "%";
            if(Math.round(e.bytesLoaded / e.bytesTotal * 100) == 100)
            {
              renamer()      
              nPercent = 0;            
            }             
       }
       
       public function unload() : void
       {         
        //trace("[Unloaded SWF] " + files[i].name);               
        superloader.unloadAndStop(true);
        superloader = new ProLoader();
        zloaderContext = null; 
        i++;        
        uncompressSWF()       
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
         try
         {
            Musicchannel.stop();
         }
         catch(err:Error)
         {
            Log.log("There was no music to stop " + err.message)
         }
         Musicchannel = MenuMusic.play(0, int.MAX_VALUE, Musictrans);
         Log.log("Best listened to with headphones on.")
         if(load !== 2)
         {
           sfxloader();
           load++
         }                    
      }   

      function on_SFXComplete(e:Event):void
      {         
         Log.log("SFX loaded.");
         if(easteregg_act !== true)
         { 
            buttoncolors();
         }                 
      }

      function checkforfolders() : void
      {
          musicfolder.nativePath = docsDir.nativePath + "\\" + "music";
          stagefolder.nativePath = docsDir.nativePath + "\\" + "stage";
          characterfolder.nativePath = docsDir.nativePath + "\\" + "character";
          menufolder.nativePath = docsDir.nativePath + "\\" + "menu";
          modefolder.nativePath = docsDir.nativePath + "\\" + "mode";
          miscfolder.nativePath = docsDir.nativePath + "\\" + "misc";
          if(!stagefolder.exists)
          {
             stagefolder.createDirectory();
             Log.log("Created a directory for stages here: " + stagefolder.nativePath)
          }
          if(!musicfolder.exists)
          {
             musicfolder.createDirectory();
             Log.log("Created a directory for music here: " + musicfolder.nativePath)
          }
          if(!characterfolder.exists)
          {
             characterfolder.createDirectory();
             Log.log("Created a directory for characters here: " + characterfolder.nativePath)
          }
          if(!menufolder.exists)
          {
             menufolder.createDirectory();
             Log.log("Created a directory for menus here: " + menufolder.nativePath)
          }
          if(!modefolder.exists)
          {
             modefolder.createDirectory();
             Log.log("Created a directory for modes here: " + modefolder.nativePath)
          }
          if(!miscfolder.exists)
           {
              miscfolder.createDirectory();
              Log.log("Created a directory for miscellaneous here: " + miscfolder.nativePath)
           }
      }
      
      function randomRange(minNum:Number, maxNum:Number):Number 
      {         
        return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);         
      } 

      function getExtension($url:String):String
      {
      	var extension:String = $url.substring($url.lastIndexOf(".")+1, $url.length);
      	return extension;
      }
   }
}
