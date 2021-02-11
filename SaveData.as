package
{
   import flash.filesystem.*;
   import flash.utils.ByteArray;	
   
   public class SaveData
   {
      private static var theGoods:Object;
      private static var gummy:String = File.applicationDirectory.resolvePath("savedata.json").nativePath;
      private static var lifesaver:File = new File(gummy);
      private static var baby:ByteArray = new ByteArray();
      private static var stream:FileStream = new FileStream();      
      private static var newSave:String = JSON.stringify(getOGData(),null,4);
    
      
      public function SaveData()
      {
         super();         
      }    
      
      public static function importer() : void
      {  
         try
         {           
            stream.open(lifesaver,FileMode.READ);
            stream.readBytes(baby);
            stream.close();
            theGoods = JSON.parse(baby);             
            Mania.oldtime = theGoods.oldtime;           
            Mania.ponpon = theGoods.easteregg; 
            Mania.sukaponchecked = theGoods.sukaponchecked;          
            Mania.muteCheck = theGoods.mute;
            Mania.slider = theGoods.sfxVolume;
            Mania.mslider = theGoods.musicVolume;            
            Mania.docsDir = new File(theGoods.lastDirectory);
            Mania.imagebool = theGoods.imagebool;
            Log.log("whye! " + Mania.imagebool);                        
            if(theGoods.theme !== null && theGoods.theme !== undefined && theGoods.theme !== "sukapon")
            {
               Mania.specialname = theGoods.theme;
               rainbow(theGoods.theme, false)
            }        
            Log.log("SaveData successfully imported");      
         }
         catch(e:*)
         {              
            Mania.specialname = "ff7 remake";
            Mania.docsDir = File.documentsDirectory;
            Mania.muteCheck = false;
            Log.log("Import failed: " + e.message);
            stream.open(lifesaver,FileMode.WRITE);        
            stream.writeUTFBytes(newSave);           
            stream.close();
            Log.log("New SaveData created");          
         }       
      }

      public static function export() : void
      {      
        try
        {           
            
            baby = new ByteArray;
    		   var ohoby:String;
            stream.open(lifesaver,FileMode.READ);
            stream.readBytes(baby);
            stream.close();            
            theGoods = JSON.parse(baby);           
            theGoods.theme = Mania.specialname;              
            theGoods.easteregg = Mania.ponpon;         
            theGoods.sukaponchecked = Mania.sukaponchecked;                   
            theGoods.lastDirectory = Mania.docsDir.nativePath;           
            theGoods.mute = Mania.muteCheck;            
            theGoods.sfxVolume = Mania.slider;           
            theGoods.musicVolume = Mania.mslider;            
            theGoods.imagebool = Mania.imagebool;           
            if(Mania.oldtime > theGoods.oldtime)
            {
               theGoods.oldtime = Mania.oldtime;               
            }     
            ohoby = JSON.stringify(theGoods,null,4);              
            stream.open(lifesaver,FileMode.WRITE);
            stream.writeUTFBytes(ohoby);
            stream.close();
            Log.log("Saved");
        }   
        catch(e:*)
         {              
            Mania.oldtime = 1;
            Log.log("Export failed: " + e.message);
            stream.open(lifesaver,FileMode.WRITE);
            stream.writeUTFBytes(newSave);
            stream.close();                  
         }
      }

      public static function rainbow(theme:String,updates:Boolean) : void
      {      
        try
        {           
            baby = new ByteArray;
            var themeString2:String = File.applicationDirectory.resolvePath("themes").nativePath + "\\" + theme + "\\colors.json";
            var themefile:File = new File(themeString2)
            stream.open(themefile,FileMode.READ);
            stream.readBytes(baby);
            theGoods = JSON.parse(baby);
            stream.close();
            switch(updates)
            {
               case true:
               theGoods.color1 = Mania.color1;
               theGoods.color2 = Mania.color2;
               theGoods.color3 = Mania.color3;
               theGoods.color4 = Mania.color4;
               theGoods.color5 = Mania.color5;
               ohoby = JSON.stringify(theGoods,null,4);              
               stream.open(themefile,FileMode.WRITE);
               stream.writeUTFBytes(ohoby);
               stream.close();
               Log.log("Saved new colors!");
               break;
               case false:
               Mania.color1 = theGoods.color1;
               Mania.color2 = theGoods.color2;
               Mania.color3 = theGoods.color3;
               Mania.color4 = theGoods.color4;
               Mania.color5 = theGoods.color5;
               Log.log("Updated colors!");
               break;
            }    
        }   
        catch(e:*)
         {              
            Log.log("Export failed rainbow: " + e.message);
            theGoods.color1 = Mania.color1 = "102";
            theGoods.color2 = Mania.color2 = "10027008";
            theGoods.color3 = Mania.color3 = "12104812";
            theGoods.color4 = Mania.color4 = "3368703";
            theGoods.color5 = Mania.color5 = "0x174294";
            ohoby = JSON.stringify(theGoods,null,4);              
            stream.open(themefile,FileMode.WRITE);
            stream.writeUTFBytes(ohoby);
            stream.close();                  
         }
      }


      public static function getOGData() : Object
      {
         return {
            	"lastDirectory":File.documentsDirectory.nativePath,
               "theme":"ff7 remake",	            
               "musicVolume":"0.3",
               "sfxVolume":"0.2",              
            	"color1":"102",
            	"color2":"10027008",
            	"color3":"12104812",
            	"color4":"3368703",
               "color4":"3368703",
               "color5":"0x174294",
               "mute":false,
               "imagebool":true, 
               "easteregg":false,
               "sukaponchecked":false
         }
      }
   }   }      
