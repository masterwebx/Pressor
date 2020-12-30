package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FileListEvent;
   import flash.events.MouseEvent;
   import flash.net.FileFilter;
   import flash.net.FileReference;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import com.hurlant.util.Base64;
   import flash.utils.CompressionAlgorithm;
   import flash.filesystem.*;
   import flash.desktop.*;
   import flash.display.DockIcon;
   import flash.display.NotificationType;
   import flash.desktop.NativeApplication;
   import flash.system.System;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;   
   import SaveData;
   
	
   [SWF(width="400", height="500", frameRate="60")]
   public class Main extends MovieClip
   {      
      
      private var WexisanIdiot:Boolean; 

      private var sukapon:Boolean;

      private var startingTime:int;

      private var endingTime:int;

      public static var autocompress:Boolean = false; 

      public static var Acomp:String = "Compress files!";
      
      public static var color1:String = "13844264";

      public static var color4:String = "0x1ea8e1";

      public static var Adecomp:String = "Uncompress files!";

      public static var AdecompF:String = "Uncompress folder!";
      
      public static var color3:String = "0xa0955f";

      public static var AcompF:String = "Compress folder!";

      public static var textcolor:String = "0xffffff";

      public static var fontY:String = "Verdana";

      public static var color2:String = "4015954";

      public static var topsecret:String = "???";

      public static var docsDir:File = File.documentsDirectory;

      public static var title:String = "Pressor 2.0 by Wex";
      
      public function Main()
      {
         super();
         SaveData.importer();
         stage.nativeWindow.title = title;
         var square:Sprite = new Sprite();
         square.graphics.beginFill(color1);
         square.graphics.drawRect(0,0,9400,125);
         square.graphics.endFill();      
         square.y = 250;
         addChild(square);
         var square2:Sprite = new Sprite();
         square2.graphics.beginFill(color2);
         square2.graphics.drawRect(0,0,9400,125);
         square2.graphics.endFill();         
         square2.y = 0;
         addChild(square2);
         var square3:Sprite = new Sprite();
         square3.graphics.beginFill(color3);
         square3.graphics.drawRect(0,0,9400,125);
         square3.graphics.endFill();         
         square3.y = 125;
         addChild(square3);
         var square4:Sprite = new Sprite();
         square4.graphics.beginFill(color4);
         square4.graphics.drawRect(0,0,9400,125);
         square4.graphics.endFill();
         square2.x = square.x = square3.x = square4.x = -3000;
         square4.y = 375;
         addChild(square4);
         var format:TextFormat = new TextFormat();
         var decomp:TextField = new TextField();
         var decompF:TextField = new TextField();
         var comp:TextField = new TextField();         
         var compF:TextField = new TextField();
         format.color = textcolor;
         format.size = 16;
         format.bold = true;
         format.font = fontY;
         var xchange:* = format;
         comp.defaultTextFormat = decomp.defaultTextFormat =  compF.defaultTextFormat =  decompF.defaultTextFormat = xchange;
         decompF.x = compF.x = decomp.x = comp.x = 5; 
         decompF.width = compF.width = decomp.width = comp.width = 620;
         decompF.height = compF.height = decomp.height = comp.height = 115;  
         decompF.multiline = compF.multiline = decomp.multiline = comp.multiline = true;
         decompF.selectable = compF.selectable = decomp.selectable = comp.selectable = false;
         decomp.y = 10;
         decompF.y = 135;
         comp.y = 260;         
         compF.y = 385;        
         decomp.text = Adecomp;
         comp.text = Acomp;
         decompF.text = AdecompF;
         compF.text = AcompF;
         addChild(decomp);
         addChild(comp);
         addChild(decompF);
         addChild(compF);
         decomp.addEventListener("click",this.doIt);
         comp.addEventListener("click",this.doIt);
         decompF.addEventListener("click",this.doIt);
         compF.addEventListener("click",this.doIt);
         if(autocompress == true)
         {
            stage.addEventListener(Event.ENTER_FRAME,this.secrets);
			trace("QHATR");
         }
      }   
     
      
      private function doIt(param1:MouseEvent) : void
      {         
         stage.nativeWindow.title = title;
         trace(param1.currentTarget.name);
         if(param1.currentTarget.name == "instance5" || param1.currentTarget.name == "instance6")
         {
            this.WexisanIdiot = true;
            var txtFilter:FileFilter = new FileFilter("Select up to 100 files", "*.ssf;*.ssfrec"); 
         }
         else
         {
            this.WexisanIdiot = false;
            var txtFilter:FileFilter = new FileFilter("Select up to 100 files", "*.swf"); 
         }
         trace("It's " + this.WexisanIdiot + ", he's an idiot?");    
         try
         {
            if(param1.currentTarget.name == "instance6" || param1.currentTarget.name == "instance8")
            {
               trace("woo wee!");
               sukapon = true;
               docsDir.browseForDirectory("Select a folder");
               docsDir.addEventListener(Event.SELECT, filesSelected);
            }
            else
            {
               trace("wee woo!");
               sukapon = false;               
               docsDir.browseForOpenMultiple("Select files", [txtFilter]);
               System.gc();
               System.gc(); 
               docsDir.addEventListener(FileListEvent.SELECT_MULTIPLE, filesSelected);
               
            }
         }
         catch (error:Error)
         {
            trace("Failed:", error.message);
         }
      }
      
      function filesSelected(event:*):void 
      {
        startingTime = getTimer();
        var thelength:int;
        var files:Vector.<Object> = new Vector.<Object>();
        var fs:FileStream = new FileStream();
        var FileData:ByteArray = new ByteArray;
        var c:ByteArray = new ByteArray();        
        var x:int = 0;
        var hi:int = 0;
        var i:uint = 0;
        var l:int = 0;
        var n:int = 0;           
        if(sukapon == true)
        {
           docsDir = event.target as File;
           SaveData.export(); 
           files = Vector.<Object>(docsDir.getDirectoryListing());
           thelength = files.length;
           for (hi = 0; hi < thelength; hi++) 
           {
               if (files[hi].nativePath.indexOf(".sw") !== -1 && this.WexisanIdiot == true)
               {
                  trace("bye bye " + files[hi].nativePath);
                  files.removeAt(hi);
                  hi--                                 
               }
               else if (files[hi].nativePath.indexOf(".ss") !== -1 && this.WexisanIdiot == false)
               {
                  trace("bai bai " + files[hi].nativePath);
                  files.removeAt(hi); 
                  hi--                   
               }
               else
               {
                  trace("ya");                         
               }
               n++
               if(n == thelength)
               {
                  hi = thelength - 1
               }                                  
           }
           thelength = files.length;
           n = 0;
           trace("thelength " + thelength);       
        }
        else 
        {
           thelength = event.files.length;
           files = Vector.<Object>(event.files);
           docsDir = new File(files[0].nativePath.substr(0, files[i].nativePath.lastIndexOf("\\") + 1));
           SaveData.export(); 
        }                
        
        for (i = 0; i < thelength; i++) 
        {
           
            if(i == thelength - 1)
            {
               topsecret = files[i].modificationDate.getTime();
               trace("this is top secret " + topsecret);
               SaveData.export(); 
            }
            trace(files[i].nativePath);                        
            fs.open(files[i], FileMode.READ);
            fs.readBytes(FileData);
            fs.close();    
            try
            { 
               if(this.WexisanIdiot == true)                      
               {                  
                  c = new ByteArray();
                  files[i].nativePath = files[i].nativePath.replace(".ssf",".swf");  
                  FileData.uncompress(CompressionAlgorithm.ZLIB);                  
                  trace("uncompressin'");
                  l = FileData.readInt();
                  n = FileData.readInt();                             
                  for(x = 0; x < n; x++)
                  {
                     FileData.readInt();                                   
                  }
                  c.writeBytes(FileData,FileData.position,l);               
                  FileData = c;
                  l = null;
                  n = null;
                  x = null;                             
               }
               if(this.WexisanIdiot == false)
               {                                             
                  c = new ByteArray();                 
                  files[i].nativePath = files[i].nativePath.replace(".swf",".ssf");                          
                  trace("compressin'");                                      
                  c.writeInt(FileData.length);            
                  for (hi = 0; hi < 1; hi++) 
                  {
                      c.writeInt(0);
                  } 
                  c.writeBytes(FileData);               
                  FileData = c;                     
                  FileData.compress(CompressionAlgorithm.ZLIB);
                  hi = null;                                 
               }
               trace(files[i].nativePath);               
               fs.open(files[i], FileMode.WRITE);           	            
               fs.writeBytes(FileData);
               fs.close();                              	               
               trace(System.totalMemory / 1024);
               FileData.length = 0;
               c.length = 0;
               FileData.clear();
               c.clear();
               System.pauseForGCIfCollectionImminent(1);                           
               System.gc();
               System.gc();               
            }
            catch(err:Error)
            {
               trace(err.message)
            }   
         }
         trace("Done");
         endingTime = getTimer();
         stage.nativeWindow.title = "Pressor 2.0 - Task COM-";
         stage.nativeWindow.title = "Pressor 2.0 - Task    -PL-  ";
         stage.nativeWindow.title = "Pressor 2.0 - Task COMPLETE!";
         stage.nativeWindow.notifyUser(NotificationType.INFORMATIONAL);               
         if(NativeApplication.supportsDockIcon)
         {
            var dockIcon:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;
            dockIcon.bounce(NotificationType.INFORMATIONAL);
         }         
         setTimeout(function():void{stage.nativeWindow.title = "Pressor 2.0: Finished in " +  (endingTime - startingTime) / 1000 + " seconds!"},3000);
      }

      /*private function secrets(param1:Event) : void
      {         
         if(docsDir !== File.documentsDirectory || docsDir !== null || docsDir !== "")
         {
            docsDir.getDirectoryListing();
            docsDir.addEventListener(FileListEvent.DIRECTORY_LISTING, directoryListingHandler);
         }
      }

      function directoryListingHandler(event:FileListEvent):void
      {
         var list:Array = event.files;
         for (var i:uint = 0; i < list.length; i++) {
         if(f.modificationDate.getTime() > Main.topsecret)
         {
           trace("yeah boi")
         }
      }*/
     
   }
}
