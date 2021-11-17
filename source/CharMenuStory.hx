package;


import Song.SwagSong;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import flixel.util.FlxTimer;
import flixel.graphics.frames.FlxAtlasFrames;






class CharMenuStory extends MusicBeatState
{
	var menuItems:Array<String> = ['BOYFRIEND', 'BOYFRIENDSECOND'];
	var curSelected:Int = 0;
	var txtDescription:FlxText;
	var idleCharacter:FlxSprite;
	var menuBG:FlxSprite;
	var menuIcon:FlxSprite;
	public static var SONG:SwagSong;
	public static var isStoryMode:Bool = false;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;
	private var grpMenuShit:FlxTypedGroup<Alphabet>;
	private var grpMenuShiz:FlxTypedGroup<FlxSprite>;
	var alreadySelectedShit:Bool = false;
	// magnus sux
	//technically works but whatever.
	//var shittyNames:Array<String> = CoolUtil.coolTextFile('assets/data/boyfriendnames.txt');
	
	var shittyNames:Array<String> = [
		"Boyfriend ",
		"Alpaca",

		//"Secret Boyfriend",
		
	];

	var txtOptionTitle:FlxText;

	override function create()
	{
		menuBG = new FlxSprite().loadGraphic('assets/images/charSelect/BG1.png');
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		grpMenuShiz = new FlxTypedGroup<FlxSprite>();
		add(grpMenuShiz);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
		
			songText.screenCenter(X);
			songText.targetY = i;
			grpMenuShit.add(songText);
		}

		txtDescription = new FlxText(FlxG.width * 0.075, menuBG.y + 200, 0, "", 32);
		txtDescription.alignment = CENTER;
		txtDescription.setFormat("assets/fonts/vcr.ttf", 32);
		txtDescription.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1.5, 1);
		txtDescription.color = FlxColor.WHITE;
		add(txtDescription);

		idleCharacter = new FlxSprite(0, -20);
		idleCharacter.frames = FlxAtlasFrames.fromSparrow('assets/images/charSelect/selectbf.png', 'assets/images/charSelect/selectbf.xml');
		idleCharacter.animation.addByPrefix('boyfriendidle', 'OG idle dance', 24);
		idleCharacter.animation.addByPrefix('alpacaidle', 'Paca idle dance', 24);
		idleCharacter.animation.addByPrefix('boyfriendselect', 'OG HEY!!', 24);
		idleCharacter.animation.addByPrefix('alpacaselect', 'Paca HEY!!', 24);
		
		idleCharacter.animation.play('boyfriendidle');
		idleCharacter.scale.set(0.7, 0.7);
		idleCharacter.updateHitbox();
		idleCharacter.screenCenter(XY);
		idleCharacter.antialiasing = true;
		
		add(idleCharacter);

		//Why is it done like this? Animated icons soon lol
		menuIcon = new FlxSprite();
		menuIcon.frames = FlxAtlasFrames.fromSparrow('assets/images/charSelect/icons.png', 'assets/images/charSelect/icons.xml');
		menuIcon.x = FlxG.width * 0.1;
		menuIcon.y = FlxG.height * 0.1;
		menuIcon.antialiasing = true;
		menuIcon.animation.addByPrefix('ogboy', 'bf', 1);
		menuIcon.animation.addByPrefix('papaca', 'alpaca', 1);
		add(menuIcon);	

		//idleCharacterBetter = new Boyfriend(0, 0, 'bf');

		var charSelHeaderText:Alphabet = new Alphabet(0, 50, 'CHARACTER SELECT', true, false);
		charSelHeaderText.screenCenter(X);
		add(charSelHeaderText);

		var selectionArrows:FlxSprite = new FlxSprite().loadGraphic('assets/images/charSelect/arrowsz.png');
		selectionArrows.screenCenter();
		selectionArrows.antialiasing = true;
		add(selectionArrows);

		txtOptionTitle = new FlxText(FlxG.width * 0.7, 10, 0, "dfgdfgdg", 32);
		txtOptionTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtOptionTitle.alpha = 0.7;
		add(txtOptionTitle);

		changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

		super.create();
	}

	override function update(elapsed:Float)
	{
		txtOptionTitle.text = shittyNames[curSelected].toUpperCase();
		txtOptionTitle.x = FlxG.width - (txtOptionTitle.width + 10);
		if (txtOptionTitle.text == '')
		trace('NO FUCKING TEXT LMAO');
			
		

		var upP = controls.UI_LEFT_P;
		var downP = controls.UI_RIGHT_P;
		var accepted = controls.ACCEPT;

		if (!alreadySelectedShit)
		{
			if (upP)
				{
					changeSelection(-1);
				}
				if (downP)
				{
					changeSelection(1);
				}
		
				if (accepted)
				{
					alreadySelectedShit = true;
					var daSelected:String = menuItems[curSelected];
					
					//Selection and loading for them
					switch (daSelected)
					{
						case "BOYFRIEND":
							FlxG.sound.play(Paths.sound('confirmMenu'));
							idleCharacter.animation.play('boyfriendselect');
							// FlxG.sound.music.stop();
							PlayState.bfMode = 'bf';
						
							trace('fuck you geno1');
							
							
							new FlxTimer().start(1, function(tmr:FlxTimer)
							{
								MusicBeatState.switchState(new StoryMenuState());
							});
						case "BOYFRIENDSECOND":
							FlxG.sound.play(Paths.sound('confirmMenu'));
							idleCharacter.animation.play('alpacaselect');
                            idleCharacter.x -= 47;
							// FlxG.sound.music.stop();
							PlayState.bfMode = 'alpaca-funsize';
							
							trace('fuck you cval2');
							
							
							new FlxTimer().start(1, function(tmr:FlxTimer)
							{
								MusicBeatState.switchState(new StoryMenuState());								
							});
					
						
						default:
							// so it doesnt crash lol
							
					}
				}
		
				if (controls.BACK)
				{
					FlxG.switchState(new MainMenuState());
				}
		}

		super.update(elapsed);
	}

	function changeSelection(change:Int = 0):Void
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));

		curSelected += change;
	
		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;
	
		var bullShit:Int = 0;
	
		for (item in grpMenuShit.members)
		{
			item.x = bullShit - curSelected;
			bullShit++;

			item.alpha = 0;
			// item.setGraphicSize(Std.int(item.width * 0.8));
	
			if (item.x == 0)
			{
				// item.setGraphicSize(Std.int(item.width));
			}
		}

		charCheckLmao();
	}

	function charCheckLmao()
	{
		var daSelected:String = menuItems[curSelected];
		var charSelected:String = 'bf';
		//remove(idleCharacterBetter);
		

		switch (daSelected)
		{
			case "BOYFRIEND":
				idleCharacter.animation.play('boyfriendidle');
				idleCharacter.screenCenter(XY);
				menuBG.loadGraphic('assets/images/charSelect/BG1.png');
				menuIcon.animation.play('ogboy');
			
			case "BOYFRIENDSECOND":
				idleCharacter.animation.play('alpacaidle');
				idleCharacter.screenCenter(XY);
				menuBG.loadGraphic('assets/images/charSelect/BG2.png');
				menuIcon.animation.play('papaca');
			
		}
	
	}
	
}