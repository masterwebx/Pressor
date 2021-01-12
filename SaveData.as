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
            if(theGoods.oldtime == null)
            {               
              Log.log("SaveData not 2.1 compatible, refreshing")
            }
            Main.oldtime = theGoods.oldtime;  
            Log.log("The last compression time is " + Main.oldtime + " imagebool is " + theGoods.imagebool)
            Log.log("ponpon: " + theGoods.easteregg + "sukaponchecked: " + theGoods.sukaponchecked);
            Main.ponpon = theGoods.easteregg; 
            Main.sukaponchecked = theGoods.sukaponchecked;          
            Main.color1 = theGoods.color1;
            Main.color2 = theGoods.color2;
            Main.color3 = theGoods.color3;
            Main.color4 = theGoods.color4;
            Main.muteCheck = theGoods.mute;
            Main.slider = theGoods.sfxVolume;
            Main.mslider = theGoods.musicVolume;            
            Main.docsDir = new File(theGoods.lastDirectory);
            if(theGoods.imagebool == "undefined" || theGoods.imagebool == null)
            {
               Log.log("imagebool not found")
               Main.imagebool = true;
               SaveData.export();               
            }  
   			else
   			{            
              Main.imagebool = theGoods.imagebool;
            }             
            theGoods = null;
            Log.log("SaveData successfully imported");      
         }
         catch(e:*)
         {              
            Main.docsDir = File.documentsDirectory;
            Main.muteCheck = false;
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
            Log.log("theGoods: " + theGoods.oldtime) 
            theGoods.easteregg = Main.ponpon; 
            Log.log("ponpon: " + theGoods.easteregg); 
            theGoods.sukaponchecked = Main.sukaponchecked;              
            theGoods.lastDirectory = Main.docsDir.nativePath;
            theGoods.mute = Main.muteCheck;
            theGoods.sfxVolume = Main.slider;
            theGoods.musicVolume = Main.mslider;
            theGoods.color1 = Main.color1;
            theGoods.color2 = Main.color2;
            theGoods.color3 = Main.color3;
            theGoods.color4 = Main.color4;
            theGoods.imagebool = Main.imagebool;
            if(Main.oldtime > theGoods.oldtime)
            {
               theGoods.oldtime = Main.oldtime;
               Log.log("oldtime updated to: " + Main.oldtime)  
            }            
            Log.log("theGoods after: " + theGoods.oldtime)        
            ohoby = JSON.stringify(theGoods,null,4); 
            Log.log(ohoby);      
            stream.open(lifesaver,FileMode.WRITE);
            stream.writeUTFBytes(ohoby);
            stream.close();
            Log.log("Saved");
        }   
        catch(e:*)
         {              
            Main.oldtime = 1;
            Log.log("Export failed: " + e.message);
            stream.open(lifesaver,FileMode.WRITE);
            stream.writeUTFBytes(newSave);
            stream.close();                  
         }
      }

      public static function getOGData() : Object
      {
         return {
            	"lastDirectory":File.documentsDirectory.nativePath,
	            "title":"Pressor 2.0 by Wex",
               "musicVolume":"0.6",
               "sfxVolume":"0.4",              
            	"color1":"102",
            	"color2":"10027008",
            	"color3":"12104812",
            	"color4":"3368703",
               "mute":false,
               "imagebool":true, 
               "easteregg":false,
               "sukaponchecked":false,              
               "oldtime":"1"                          
         };
      }   
   }
}
