//import the whole thing
package
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	import flash.text.TextField;
	
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.UncaughtErrorEvent;
	
	/**
	 * Debug output panel.
	 * @author Митя "DeliMIter" Ямайкин
	 */	 
	 
	
	public class Log
	{
		static private var textArea:TextField;
		static private var stage:Stage;
		static private var dontbugme:Boolean = false;
		
		// As a first argument pass a DisplayObject that IS or WILL be attached to stage.
		static public function create(target:DisplayObject, value:Boolean = false):void
		{
			if (!textArea) startEngine(value);
			if (!stage) captureStage(target);
		}
		
		static private var showExceptions:Boolean;
		static private var rootExceptions:Boolean;
		
		static public function handleExceptions(root:DisplayObject, show:Boolean):void
		{
			showExceptions = show;
			rootExceptions = root;
			
			root.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onException, false, 0, true);
		}
		
		static private function onException(e:UncaughtErrorEvent):void
		{
			if (e.error is Error && dontbugme == false)             				
			Log.log((e.error as Error).getStackTrace());
			
			e.preventDefault();
			
			if (showExceptions && dontbugme == false && e.Error !== "" || null)
				if (!visible)
					visible = true;
		}
		
		// Create the Log output text area.
		static private function startEngine(value:Boolean):void
		{			
			if (!textArea)
			{
				textArea = new TextField;
				
				textArea.x = 10;
				textArea.y = 10;
				
				textArea.border = true;
				textArea.wordWrap = true;
				textArea.multiline = true;
				textArea.selectable = true;
				textArea.background = true;
				
				var aFormat:TextFormat;
				
				aFormat = textArea.getTextFormat();
				aFormat.font = "_typewriter";
				aFormat.size = 12;				
				aFormat.align = TextFormatAlign.LEFT;				
				textArea.htmlText = "Welcome to the Log! Original creator: Митя DeliMIter Ямайкин. <br>Press F3 to hide/unhide this, press F4 to disable the log for this game session.<br><br>";
							
				textArea.setTextFormat(aFormat);
				textArea.defaultTextFormat = aFormat;
			}
			
			textArea.visible = value;	
			
		}
		
		static private function captureStage(target:DisplayObject):void
		{
			if (target.stage) aquireStage(target);
			else target.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		static private function onStage(e:Event):void
		{
			var anObject:DisplayObject = e.target as DisplayObject;
			anObject.removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			if (!stage) aquireStage(anObject);
		}
		
		static private function aquireStage(target:DisplayObject):void
		{
			stage = target.stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			visible = visible;
		}
		
		static private const PASS:String = "/*@&^#";
		
		// Capture keyboard input to toggle Log visibility.
		static private function onKey(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.F3)
			{
				visible = !visible;
			}
			if (event.keyCode == Keyboard.F4)
			{
				dontbugme = !dontbugme;
			}			
		}
		
		static public function get visible():Boolean
		{
			return textArea.visible;
		}
		
		static public function set visible(value:Boolean):void
		{
			textArea.visible = value;
			
			if (!stage) return;
			
			if (value)
			{
				if (textArea.parent != stage)
				{
					onResize(null);
					
					stage.addChild(textArea);
					stage.addEventListener(Event.ADDED, onAdded);
					stage.addEventListener(Event.RESIZE, onResize);
				}
			}
			else
			{
				stage.removeEventListener(Event.RESIZE, onResize);
				stage.removeEventListener(Event.ADDED, onAdded);
				
				if (textArea.parent != null)
					textArea.parent.removeChild(textArea);
			}
		}
		
		// Keep Log on top of other things.
		static private function onAdded(e:Event):void
		{
			//log("[LOG] added", e.target, e.currentTarget);
			
			if (textArea.parent != stage)
			{
				stage.addChild(textArea);
			}
			else if (stage.getChildIndex(textArea) < stage.numChildren - 1)
			{
				stage.setChildIndex(textArea, stage.numChildren - 1);
			}
		}
		
		// Keep Log aligned to the stage borders.
		static private function onResize(e:Event):void
		{
			textArea.width = stage.stageWidth - 20;
			textArea.height = stage.stageHeight - 20;
		}
		
		// Call to add entries and to trace them as well.
		static public function log(...args:Array):void
		{
			var aMessage:String;
			
			var aDate:Date = new Date;
			var aStamp:String = aDate.getMilliseconds().toString();
			
			aStamp = "." + "000".substr(aStamp.length) + aStamp;
			aStamp = "[" + aDate.toTimeString().split(" ")[0] + aStamp + "]";
			
			args.unshift(aStamp);
			trace.apply(null, args);
			aMessage = args.join(" ") + "\n";
			
			if (!textArea) startEngine(false);
			
			textArea.appendText(aMessage);
			textArea.scrollV = textArea.maxScrollV;
		}
		
		static public function clear():void
		{
			textArea.text = "";
			textArea.scrollV = 0;
		}
	}
}