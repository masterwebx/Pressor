package
{
   import flash.display.*;
   import com.anttikupila.revolt.Revolt;    
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
      var revolt = new Revolt(720,480);
       
	  public static var poppertitle:String = " ";

      public static var popperinfo:String = " "

      public static var poppersmall:String = " "
      
      var ssf2music:Boolean = false;

      var musicLoop:int = 0;

      var thelength2:int = 1;

      var mi:Number = 0;

      var fr:FileReference;
      
      var m_movie:MovieClip;      

      var mee:MovieClip = new(barr);  

      var zloaderContext:LoaderContext = new LoaderContext(); 

      var superloader:ProLoader = new ProLoader();

      var superloaderEX:ProLoader = new ProLoader();

      var musicPlaying:Boolean = false; 

      var musicPlaying2:Boolean = false;   

      var forceSound:Boolean = false;
      
      private var WexisanIdiot:Boolean;  

      private var sukapon:Boolean;

      public static var ponpon:Boolean;

      public static var sukaponchecked:Boolean;

      public static var alreadyplaying:Boolean;

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

      public static var color5:String = "0x174294";        

      public static var themeString:String = File.applicationDirectory.resolvePath("themes").nativePath;     

      public static var loadme:String; 

      public static var loadme2:String; 
      
      public static var specialname:String = "";

      public static var specialname2:String = "";        

      public static var processArgs = new Vector.<String>;   

      public static var files:Vector.<Object> = new Vector.<Object>();

      public static var files2:Vector.<Object> = new Vector.<Object>();

      public static var musicfolder:File = new File;

      public static var stagefolder:File = new File;

      public static var miscfolder:File = new File;

      public static var modefolder:File = new File;

      public static var menufolder:File = new File;

      public static var characterfolder:File = new File;

      public static var docsDir:File = File.documentsDirectory;

      public static var SSF2Dir:File = File.documentsDirectory;   

      public static var swffile:File = File.applicationDirectory.resolvePath("ffdec.exe"); 

      public static var themes:File = new File(themeString);      

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
        popper.visible = false;
        bgimage.psb_spread.visible = false;  
        suka.visible = false;       
        settingswindow.visible = false;
        settingswindow.visual.selectable = false;   
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
         popper.addEventListener(MouseEvent.CLICK,this.fade);
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
               musicPlaying = true;	
               easteregg();
            }
            if(sukaponchecked == false)
            {
              settingswindow.sukaegg.sukabox.selected = false;
			     Musicchannel.stop();
              musicPlaying = false;
              var c:Color = new Color();
              settingswindow.wrapper.cb1.visible = true;
              settingswindow.decomp.visible = true;
              settingswindow.decompF.visible = true;
              settingswindow.comp.visible = true;
              settingswindow.compF.visible = true;
              settingswindow.logos.visible = true;
              bgimage.psb_spread.visible = false;
              settingswindow.decomp.selectedColor = color1;
              settingswindow.comp.selectedColor = color2;
              settingswindow.decompF.selectedColor = color3;
              settingswindow.compF.selectedColor = color4; 
              settingswindow.logos.selectedColor = color5; 
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
        popper.visible = false;             
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
           settingswindow.logos.visible = false;
        }
        else
        {
           settingswindow.decomp.selectedColor = color1;
           settingswindow.comp.selectedColor = color2;
           settingswindow.decompF.selectedColor = color3;
           settingswindow.compF.selectedColor = color4;
           settingswindow.logos.selectedColor = color5;
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
        settingswindow.musicy.addEventListener(MouseEvent.CLICK,chooseMusic);
        settingswindow.decomp.addEventListener(ColorPickerEvent.CHANGE,changeColor);
        settingswindow.comp.addEventListener(ColorPickerEvent.CHANGE,changeColor);
        settingswindow.decompF.addEventListener(ColorPickerEvent.CHANGE,changeColor);
        settingswindow.compF.addEventListener(ColorPickerEvent.CHANGE,changeColor); 
        settingswindow.logos.addEventListener(ColorPickerEvent.CHANGE,changeColor);        
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
        settingswindow.musicy.removeEventListener(MouseEvent.CLICK,chooseMusic);
        settingswindow.decomp.removeEventListener(ColorPickerEvent.CHANGE,changeColor);
        settingswindow.comp.removeEventListener(ColorPickerEvent.CHANGE,changeColor);
        settingswindow.decompF.removeEventListener(ColorPickerEvent.CHANGE,changeColor);
        settingswindow.compF.removeEventListener(ColorPickerEvent.CHANGE,changeColor); 
        settingswindow.logos.removeEventListener(ColorPickerEvent.CHANGE,changeColor);   
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
           //aboutwindow.sukapon.suka_init.gotoAndPlay(1);
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
           settingswindow.logos.visible = false;
           settingswindow.sukaegg.sukabox.cb2.selected = true;
           easteregg_act = true;
           ponpon = true;
           onClick = JMF_onClick;
           back = JMF_back;
           onClickSet = JMF_onClickSet;
           clicked = JMF_clicked;              
           if(musicPlaying == true)
           {
               Musicchannel.stop();	
               musicPlaying = false;                 
           }
		   if(bgimage.contains(loader))
		   {
			  bgimage.removeChild(loader);   
		   }
           bgimage.psb_spread.visible = true;            
           color.saturation = color.contrast = color.brightness = 0; 
           color.hue = 74;           
           filter = new ColorMatrixFilter(color.CalculateFinalFlatArray());
           foreground.icon.filters = [filter];    
           buttoncolors(true);           
           MenuMusic = B_sukapon;          
           Musicchannel = MenuMusic.play(0, int.MAX_VALUE, Musictrans);
           musicPlaying = true;	
           specialname = "sukapon";
           SaveData.export();           
         }
      }

      function buttoncolors(suki:Boolean = false):void
      {
        if(specialname !== "sukapon")
        {
         Log.log(specialname)
         SaveData.rainbow(specialname,false);
        }
        var c:Color = new Color();
        var Acolor:String = settingswindow.decomp.selectedColor = color1;
        var Bcolor:String = settingswindow.comp.selectedColor = color2;
        var Ccolor:String = settingswindow.decompF.selectedColor = color3;
        var Dcolor:String = settingswindow.compF.selectedColor = color4;
        var Ecolor:String = settingswindow.logos.selectedColor = color5;
        if(suki == true)
        {
           Acolor = Bcolor = Ccolor = Dcolor = "1";
           Ecolor = "0x174294";      
        }
        color.saturation = color.hue = color.contrast = color.brightness = 0; 
        filter = new ColorMatrixFilter(color.CalculateFinalFlatArray());
        decomp.ucomp_button.filters = comp.ucomp_button.filters = compF.ucomp_button.filters = decompF.ucomp_button.filters = [filter];        
           c.setTint(Acolor, 0.69);
           decomp.ucomp_button.transform.colorTransform = c;
           c.setTint(Bcolor, 0.69);
           comp.ucomp_button.transform.colorTransform = c;
           c.setTint(Ccolor, 0.69);
           decompF.ucomp_button.transform.colorTransform = c;
           c.setTint(Dcolor, 0.69); 
           compF.ucomp_button.transform.colorTransform = c;
           c.setTint(Ecolor, 0.69); 
           foreground.icon.boi.transform.colorTransform = c;
        bgimage.mouseEnabled = false;
        bgimage.mouseChildren = false; 
        setTimeout(addListeners, 10);
        loading.visible = false;         
      }

      function imageloader(event:Event = null):void
      {    
        var exceptional:Boolean;
        var nameywamey:String;
        if(imagebool == true)
        {               
           bgimage.visible = true;
        }
        if(event !== null)
        {
           specialname = settingswindow.droptheme.selectedItem.label.toLowerCase();
        }
        bgimage.ff7r.visible = false;
        ssf2music = false;
        if(easteregg_act == true)
        {            
         sukaponchecked = true;
         updateCart();
        }
        bgimage.psb_spread.visible = false;  
        if(bgimage.contains(loader) == false)
        {                     
         bgimage.addChild(loader);
        }	  
        Log.log("Booting up image loader " + specialname);
        if(imagebool == false)
        {
         bgimage.visible = false;
        }   
       try
       {  
         var files:Array = themes.getDirectoryListing();               
         for (i = 0; i < files.length; i++)
         {                  
            //Log.log(files[i].name.toLowerCase())
            if(files[i].name.toLowerCase() == specialname.toLowerCase())
            {
               //Log.log("mamma mia")
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
         if(specialname !== "" && exceptional == true)
         {
            loadme = files[i].nativePath + "\\" + files[i].name + ".png";
            specialname = files[i].name;
            n = i
         } 
         else
         {         
           n = randomRange(0, files.length - 1);                    
           loadme = files[n].nativePath + "\\" + files[n].name + ".png";
           specialname = files[n].name;
           i = n;
           //Log.log("voi")
         }
         //Log.log("specialname " + specialname)
         specialname2 = files[i].nativePath;    
         //Log.log("specialname2 " + specialname2)
         loader.load(new URLRequest(loadme));                     
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE, on_imageComplete);           
         files = new File(files[i].nativePath).getDirectoryListing();  
         for (i = 0; i < files.length; i++)
         {                      
            nameywamey = files[i].name.replace(".mp3","");
            nameywamey = nameywamey.replace(/[0-9]/g,"")   
            //Log.log(nameywamey + specialname + files[i].extension)
            if(nameywamey == specialname && files[i].extension == "mp3")
            {         
               //Log.log("yeehaw " + nameywamey)
               break;                          
            }                      
         }
         loadme = files[i].nativePath; 
         MenuMusic = new Sound();   
         nameywamey = files[i].name.replace(/[a-z,A-Z,.]/g,"");
         musicLoop = nameywamey.substring(0,nameywamey.length - 1)
         Log.log("musicLoop " + musicLoop)  
         MenuMusic.load(new URLRequest(loadme));
         MenuMusic.addEventListener(Event.COMPLETE, on_musicComplete);                          
        }
        catch(e:Error)
        {   
         if(!themes.exists)
         {
            themes.createDirectory();
            Log.log("Created a directory for themes here: " + themes.nativePath)
         }          
         else
         { 
            Log.log("Theme failed to load: " + e.message)
            specialname = "ff7 remake";
            sfxloader();
         }          
        }
        SaveData.export();
        Log.log("Finished loading image!");         
      }

      function musicoverride() : void
      {         
        Log.log("FF7 override")
        if(bgimage.contains(loader) == true)
        {                     
           bgimage.removeChild(loader);
        }
        MenuMusic = B_MenuMusic;
        onClick = B_onClick;
        back = B_back;
        onClickSet = B_onClickSet;
        clicked = B_clicked;
        bgimage.ff7r.visible = true;
        //Log.log("music playin is " + musicPlaying);   
        if(musicPlaying == true)
        {
           Musicchannel.stop(); 
           Log.log("bruh it stopped");             
        }
        Musicchannel = MenuMusic.play(0, int.MAX_VALUE, Musictrans);
        musicPlaying = true;
        buttoncolors();
        SaveData.export();          
      }

      function sfxloader(ff7:Boolean = false):void
      {
         var exceptional:Boolean;
		if(settingswindow.visual.contains(revolt))
        {
         settingswindow.visual.removeChild(revolt);   
        }
         Log.log("Booting up sfx loader " + specialname);        
         try
         {            
            var dropitdown:Array = new Array();
            var tempName:String;
            var files:Array = themes.getDirectoryListing();
            if(firstload == false)
            {
             settingswindow.droptheme.addItem({label: "random"})      
            }                         
            for (i = 0; i < files.length; i++)
            {        
               if(files[i].isDirectory == true && firstload == false)
               {                  
                  settingswindow.droptheme.addItem({label: files[i].name.toLowerCase()});                      
               }
            }  
            settingswindow.droptheme.selectedItem = settingswindow.droptheme.getItemAt(n+1);
            firstload = true;          
            settingswindow.droptheme.addEventListener(Event.CHANGE, imageloader);
            if(specialname == "ff7 remake")
            {
               //Log.log("c'mon now")
               bgimage.ff7r.visible = true;
               musicoverride();
               return;                 
            }       
            if(specialname2 == "sukapon" && easteregg_act == true)
            {
               onClick = JMF_onClick
               back = JMF_back
               onClickSet = JMF_onClickSet
               clicked = JMF_clicked
               settingswindow.droptheme.selectedItem = settingswindow.droptheme.getItemAt(1);
            
            }                        
            loadmeup = new File(specialname2);  
            Log.log("Found SFX " + loadmeup);            
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
            }                   
         }
         catch(e:Error)
         {         
            Log.log("SFX failed to load: " + e.message)            
            if(!themes.exists)
            {
               themes.createDirectory();
               Log.log("Created a directory for themes here: " + themes.nativePath)
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
         Log.log(muteCheck + " and " + startup)
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
         try
         {
           if(forceSound == false)
           {
              SFXchannel.stop()
           }
           else if(forceSound == true)
           {
              setTimeout(forceSound = false,2000)
           }
         }
         catch(err:Error){}
      }

      function fade(event:MouseEvent):void
      {
         if(popper.visible == true)
         {
            SFXchannel = clicked.play(0, 1, SFXtrans);    
            popper.gotoAndPlay("fade")
         }       
      }

      function changeColor(param1:ColorPickerEvent) : void
      {         
         Log.log("This color is a changing " + param1.currentTarget.name)
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
            case "logos":        
            foreground.icon.boi.Sfilters = [filter];    
            foreground.icon.boi.transform.colorTransform = c; 
            color5 = param1.color;
            break;
         } 
         SaveData.rainbow(specialname,true);
      }    
      
      public function doIt(param1:MouseEvent) : void
      {
         stage.nativeWindow.title = pressortext.text = "Pressor " + foreground.version.text;
         pressortext.text = "Pressor " + foreground.version.text;
         this.forceSound = true;    
         SFXchannel = clicked.play(0, 1, SFXtrans);     
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
            this.forceSound = false;
         } 
      }

      public function chooseMusic(param1:MouseEvent) : void
      {
         if(musicPlaying2 == true)
         {
            Musicchannel.stop();
         }
         mi = 0;
         alreadyplaying = false;
         stage.nativeWindow.title = pressortext.text = "Pressor " + foreground.version.text;
         SFXchannel = clicked.play(0, 1, SFXtrans);
         pressortext.text = "Pressor " + foreground.version.text;              
         Log.log("Choosing a music track.");  
         txtFilter = new FileFilter("SSF2 Music Data (*.swf,*.mp3)","*.swf;*.mp3");
         docsDir.browseForOpenMultiple("Select music (up to 50 max)", [txtFilter]);                     
         docsDir.addEventListener(FileListEvent.SELECT_MULTIPLE, this.picked);       
         var fool:File = new File();
         //fool.addEventListener("select",this.picked);
         //fool.browse(new Array(new FileFilter("SSF2 Music Data (*.swf,*.mp3)","*.swf;*.mp3")));            
      }     
      
      function picked(param1:* = null) : void
      {         
         Log.log("A song is starting up")
         //choose multiple songs or a folder to make a playlist
         //by default moves to next song
         //loop button (x press): loops song a preset amount of times
         if(alreadyplaying == false)
         {
         revolt = new Revolt(720,480);
         settingswindow.visual.addChild(revolt);         
         thelength2 = param1.files.length;
         files2 = Vector.<Object>(param1.files);
         docsDir = new File(files2[0].nativePath.substr(0, files2[mi].nativePath.lastIndexOf("\\") + 1));
         }         
         try
         {              
            var FileData:URLRequest = new URLRequest(files2[mi].nativePath);
            if(files2[mi].extension == "mp3")
            {
               var playNice:Sound = new Sound(FileData);
               MenuMusic = playNice;
               Musicchannel.stop();
               var nameywamey:String;        
               nameywamey = files2[mi].name.replace(/[a-z,A-Z,.]/g,"");
               musicLoop = nameywamey.substring(0,nameywamey.length - 1)
               Musicchannel = MenuMusic.play(0, 0, Musictrans);
               settingswindow.musicy.hoo.text = files2[mi].name.replace(".mp3","") + " ♪";
               Log.log(files2[mi].nativePath + " " + settingswindow.musicy.hoo.text)
               Musicchannel.addEventListener(Event.SOUND_COMPLETE,loopinTime)
            }
            else
            {
              zloaderContext = new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain)); 
              zloaderContext.allowLoadBytesCodeExecution = true;   
              zloaderContext.allowCodeImport = true;                               
              superloaderEX.load(FileData, zloaderContext);
              superloaderEX.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadComplete2);                       
            }
         }
        catch(err:Error)
        {
            
            Log.log(err.message + mi + " " + thelength2 + " Music file may be corrupted")    
        }              
         
      }

      private function loadComplete2(e:Event) : void
      {        
           //Log.log("hey");
           var nPercent:int = Math.round(e.bytesLoaded / e.bytesTotal * 100);                    
           //pressortext.text = nPercent.toString() + "%";
           if(Math.round(e.bytesLoaded / e.bytesTotal * 100) == 100)
           {
             setTimeout(renamer2, 10);  
             nPercent = 0;            
           }             
      }

      function renamer2() : void
      {       
        //Log.log("heya");
        ssf2music = true;
        var MC:MovieClip = superloaderEX.content;
        var sighs:String = "Main_" + superloaderEX.content.getProp("id");
        var id3 = superloaderEX.content.getProp("id3").songName + " ♪"; 
        //Log.log(id3.songName);
        settingswindow.musicy.hoo.text = id3;
        //addChild(superloaderEX.content);
        var definitions:Vector.<String> = MC.loaderInfo.applicationDomain.getQualifiedDefinitionNames();
        //Log.log(definitions);
        var SoundClass:Class = MC.loaderInfo.applicationDomain.getDefinition(sighs) as Class; 
        Log.log("hey why are we here?");      
        var playNice:Sound = new SoundClass(); 
        MenuMusic = playNice;
        Musicchannel.stop();        
        Musicchannel = MenuMusic.play(0, 0, Musictrans);
        Musicchannel.addEventListener(Event.SOUND_COMPLETE,loopinTime)                     
      }

      function loopinTime(e:Event) : void
      {   
        alreadyplaying = true;
        var loops:int = 0;
        Log.log("Lupin or looping?");
        Musicchannel.stop();
        musicPlaying = false;
        //Log.log("musicLoop " + musicLoop + " and ssf2music is " + ssf2music);
        if(thelength2 == 1)
        {
           loops = int.MAX_VALUE;
           Log.log("One track, loops indefinitely"); 
           Musicchannel.removeEventListener(Event.SOUND_COMPLETE,loopinTime)
           if(ssf2music == true)
           {
              musicLoop = superloaderEX.content.getProp("musicLoop")
           }     
        }
        else
        {
           musicLoop = 0
        }  
        Musicchannel = MenuMusic.play(musicLoop, loops, Musictrans);        
        if(mi == thelength2 - 1 && thelength2 !== 0)
        {
           Log.log("Reached the end of playlist, next one starts from beginning");
           mi = 0;
           picked()
        }
        else if(mi < thelength2 - 1)
        {
           Log.log("Going to the next track"); 
           mi++;
           picked()
        }
        musicPlaying2 = musicPlaying = true;                      
      }
      
      function filesSelected(event:*):void 
      {     
        this.forceSound = false;
        settingsicon.removeEventListener(MouseEvent.CLICK,this.openSettings);
        fileticker = -1;
        startingTime = getTimer();         
        Log.log("Wex boolean: " + this.WexisanIdiot)                    
        FileData = c = new ByteArray();        
        x = i = l = n = 0;     
        try
        {
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
           //Log.log(files.length + " " + i + " whhat's going on luigi")
           checkforfolders(); 
           uncompressSWF();
        }    
        if(this.WexisanIdiot == false)
        {
           //Log.log(files.length)
           pressortext.text = "Compressing please wait...";
           setTimeout(compressSWF, 150);                                                       
        } 
      }
      catch(err:Error)
      {
         settingsicon.addEventListener(MouseEvent.CLICK,this.openSettings);
         Log.log("Something went wrong after file was selected " + err)
         poppertitle = "ERROR";
         popperinfo = "The process couldn't be started. Please make a copy of your SSF2 folder outside of Program Files. " + err;
         pressortext.text = "Pressor " + foreground.version.text;      
         popper.gotoAndPlay(1);
         popper.visible = true; 
      }
      }  

      function finale() : void
      {
            
        endingTime = getTimer();    
        
        pressortext.text = "Pressor " + foreground.version.text;
        if(popper.visible == true)
        {
           Log.log("yeaaaa")
           setTimeout(blah,7000)
        }     
        else if (popper.visible == false)
        { 
        Log.log("naaa")
        blah()  
        }            
        stage.nativeWindow.title =  "Finished in " +  (endingTime - startingTime) / 1000 + " seconds!";
        settingsicon.addEventListener(MouseEvent.CLICK,this.openSettings);
        stage.nativeWindow.notifyUser(NotificationType.INFORMATIONAL);               
        if(NativeApplication.supportsDockIcon)
        {            
           dockIcon.bounce(NotificationType.INFORMATIONAL);
        }
      }    

      function blah() : void
      {
         popper.gotoAndPlay(1)
         if(WexisanIdiot == true)
         {
           poppertitle = "UNCOMPRESSION COMPLETE!";
         }
         else
         {
            poppertitle = "COMPRESSION COMPLETE!"
         }
         popperinfo = "Finished " + i + " of " + files.length +  " files in " +  (endingTime - startingTime) / 1000 + " seconds!";
         poppersmall = "Press F3 anytime to view the log. Click this popup to close it.";
         popper.visible = true  
         
       }


      function openSSF2() : void
      {       
        try
        {     
            SSF2Dir.nativePath = docsDir.nativePath.substring(docsDir.nativePath.lastIndexOf("data\\"),0) + "SSF2.exe";          
            Log.log("SSF2 path " + SSF2Dir.nativePath)
            nativeProcessStartupInfo.executable = SSF2Dir; 
            process = new NativeProcess();              
            process.start(nativeProcessStartupInfo);
            stage.nativeWindow.minimize(); 
            concert();
        }
        catch(err:Error)
        {
            poppertitle = "ERROR";
            popperinfo = "SSF2.exe not found. " + err;
            poppersmall = "Press F3 anytime to view the log. Click this popup to close it.";
            pressortext.text = "Pressor " + foreground.version.text;      
            popper.gotoAndPlay(1);
            popper.visible = true;
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
              Log.log("Opening JPEXS with " + files[i].nativePath);
              stage.nativeWindow.minimize();            
           } 
        }
        catch(err:Error)
        {
            
            poppertitle = "ERROR";
            popperinfo = "JPEXS files not found, please copy to application directory. " + err;
            poppersmall = "Press F3 anytime to view the log. Click this popup to close it.";
            pressortext.text = "Pressor " + foreground.version.text;      
            popper.gotoAndPlay(1);
            popper.visible = true;
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
                    poppertitle = "ERROR";
                    popperinfo = "Pressor couldn't compress this one. " + err;
                    poppersmall = "Press F3 anytime to view the log. Click this popup to close it.";
                    pressortext.text = "Pressor " + foreground.version.text;      
                    popper.gotoAndPlay(1);
                    popper.visible = true;
                    Log.log("Pressor couldn't compress this one " + err.message)
                    Log.log(files.length)
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
            Log.log("Uncompressing " + files[i].nativePath + " with extension " + getExtension(files[i].nativePath))
            if(getExtension(files[i].nativePath == "ssf"))
            {
                Log.log("it's a .ssf")             
            }
            else
            {
                throw Error ("Not a ssf file");
            }
            if(i !== files.length) 
            {         
               //Log.log("what is going on Zuko")               
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
            Log.log(files.length + " " + i)
            if(i + 1 < files.length)
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
            Log.log("an error popped" + err);
            newname = "-" + "DunderMuffin" + ".swf";
            files[e].nativePath = files[e].nativePath + newname;
            files[e].nativePath = miscfolder.nativePath + "\\" + files[e].name;
        }          
        fs.open(files[e], FileMode.WRITE);           	            
        fs.writeBytes(FileData);
        fs.close();    
        Log.log(files[e].nativePath + " DONE!")
        FileData.length = c.length = 0;              
        FileData.clear();
        c.clear();
        l = x = n = null;
        this.unload();         
      }

       private function loadComplete(e:Event) : void
       {        
            var nPercent:int = Math.round(i / (files.length - 1) * 100);           
            //Log.log("Successfully loaded " + files[i].name);            
            pressortext.text = nPercent.toString() + "%";
            if(Math.round(e.bytesLoaded / e.bytesTotal * 100) == 100)
            {
              setTimeout(renamer, 10);  
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
      } 

      function on_musicComplete(e:Event):void
      {
         if(musicPlaying == true)
         {
            Log.log("It's me");
            Musicchannel.stop();            
         }                          
         Musicchannel = MenuMusic.play(0, 0, Musictrans);
         musicPlaying = true;
         Musicchannel.addEventListener(Event.SOUND_COMPLETE,loopinTime);   
         Log.log("Best listened to with headphones on. " + musicLoop)
         
         sfxloader();
                            
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
