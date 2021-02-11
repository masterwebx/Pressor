﻿package com.anttikupila.revolt {	import flash.media.*;	import flash.display.*;	import flash.net.*;	import flash.events.*;	import flash.utils.*;	import flash.filters.DropShadowFilter;	import com.anttikupila.soundSpectrum.SoundProcessor;	import com.anttikupila.revolt.presets.*;		public class Revolt extends Sprite {		private var sp:SoundProcessor;		private var gfx:BitmapData;		private var presetList:Array;		private var presetInt:Timer;		private var preset:Preset;		private var lastChange:Number;			function Revolt(w:uint, h:uint) {			//var s:Sound = new Sound();			//s.load(new URLRequest(mp3));			///s.play();			sp = new SoundProcessor();								gfx = new BitmapData(w, h, false, 0x000000)			var pic:Bitmap = new Bitmap(gfx);						addChild(pic);						presetList = new Array(new LineFourier(), new LineNoFourier(), new Explosion(), new LineSmooth(), new LineWorm(), new Tunnel());//			presetList = new Array(new LineWorm());						var initialDelay:Timer = new Timer(7100, 1);			initialDelay.addEventListener(TimerEvent.TIMER, setupTimer);			initialDelay.start();					// initialize			nextPreset(null);						addEventListener(Event.ENTER_FRAME, compute);			//buttonMode = true;			//addEventListener(MouseEvent.CLICK, nextPreset);		}				private function compute(ev:Event):void {			var soundArray:Array = sp.getSoundSpectrum(preset.fourier);			preset.applyGfx(gfx, soundArray);		}				private function setupTimer(ev:Event):void {			presetInt = new Timer(12950, 0);			presetInt.addEventListener(TimerEvent.TIMER, nextTimedPreset);			presetInt.start();			nextPreset(null);		}				private function nextPreset(ev:Event):void {			var index:uint = Math.floor(Math.random()*presetList.length);			var newPreset:Preset = presetList[index];			if (newPreset != preset) {				preset = newPreset;				preset.init();				trace("next effect is '" + preset.toString().toLowerCase() + "'");			} else {				nextPreset(null);			}			lastChange = getTimer();		}				private function nextTimedPreset(ev:Event):void {			if (getTimer() - lastChange > 5000) {				nextPreset(ev);			}		}	}}