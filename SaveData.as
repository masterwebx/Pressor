package
{
    import flash.filesystem.*;
    import flash.utils.ByteArray;
    
   
   
	
   
   public class SaveData
   {
       private static var theGoods:Object;
    
      
      public function SaveData()
      {
         super();         
      }    
      
      public static function importer() : void
      {
         var baby:ByteArray = new ByteArray();
         var saveString:String = File.applicationDirectory.resolvePath("savedata.json").nativePath;
         var saveFile:File = new File(saveString);
         var stream:FileStream = new FileStream();    

         if(saveFile.exists)
         {
            try
            {           
                stream.open(saveFile,FileMode.READ);
                stream.readBytes(baby);
                stream.close();
                theGoods = JSON.parse(baby);
                Main.color1 = theGoods.color1;
                Main.color2 = theGoods.color2;
                Main.color3 = theGoods.color3;
                Main.color4 = theGoods.color4;
                Main.AcompF = theGoods.AcompF;
                Main.Acomp = theGoods.Acomp;
                Main.AdecompF = theGoods.AdecompF;
                Main.Adecomp = theGoods.Adecomp;
                Main.autocompress= theGoods.autocompress;
                Main.topsecret = theGoods.topsecret;
                Main.textcolor = theGoods.textcolor;
                Main.title = theGoods.title;
                Main.docsDir = new File(theGoods.lastDirectory);             
            }
            catch(e:*)
            {
               trace(e.message)
               theGoods = getOGData();
               Main.title = theGoods.title;
               Main.docsDir = theGoods.lastDirectory;               
            }
         }
         else
         {           
            var gummy:String = File.applicationDirectory.resolvePath("savedata.json").nativePath;
            var lifesaver:File = new File(gummy);
            var newSave:String = JSON.stringify(getOGData(),null,4);
            stream.open(lifesaver,FileMode.WRITE);
            stream.writeUTFBytes(newSave);
            stream.close();
			theGoods = getOGData();
            Main.title = theGoods.title;
            Main.docsDir = theGoods.lastDirectory;   
         }
         
      }

      public static function export() : void
      {
        theGoods = getOGData();
        var ohoby:String = String(Main.docsDir.nativePath) + "\\";
        theGoods.lastDirectory = ohoby;
        theGoods.topsecret = Main.topsecret;
        var stream:FileStream = new FileStream();
        var gummy:String = File.applicationDirectory.resolvePath("savedata.json").nativePath;
        var lifesaver:File = new File(gummy);
        var newSave:String = JSON.stringify(theGoods,null,4);
        stream.open(lifesaver,FileMode.WRITE);
        stream.writeUTFBytes(newSave);
        stream.close();
        trace("Saved");
      }

      public static function getOGData() : Object
      {
         return {
            	"lastDirectory":File.documentsDirectory,
	            "title":"Pressor 2.0 by Wex",
                "Adecomp":"Uncompress files!",
                "Acomp":"Compress files!",
                "AdecompF":"Uncompress folder!",
                "AcompF":"Compress folder!",
            	"color1":"13844264",
            	"color2":"4015954",
            	"color3":"0xa0955f",
            	"color4":"0x1ea8e1",
            	"textcolor":"0xffffff",
                "font":"Verdana",
                "topsecret":"???",
            	"autocompress":"false"            
         };
      }   
   }
}
