module testgame;
import core;
import graphics.graphics;
import components.camera, components.userinterface;
import utility.output, utility.input, utility.config;

shared class TestGame : DGame
{
	GameObjectCollection goc;
	UserInterface ui;
	Camera cam;
	
	override void onInitialize()
	{
		logInfo( "Initializing TestGame..." );

		Input.addKeyDownEvent( Keyboard.Escape, ( uint kc ) { currentState = GameState.Quit; } );
		Input.addKeyDownEvent( Keyboard.F5, ( uint kc ) { currentState = GameState.Reset; } );

		goc = new shared GameObjectCollection;
		goc.loadObjects( "" );

		auto camobj = goc[ "TestCamera" ];
		//camobj.transform.rotation.rotatex( -std.math.PI_4 );
		Graphics.setCamera( camobj.camera );

		uint w, h;
		w = Config.get!uint( "Display.Width" );
		h = Config.get!uint( "Display.Height" );
		ui = new shared UserInterface(w, h, Config.get!string( "UserInterface.FilePath" ) );
	}

	override void onUpdate()
	{
		goc.apply( go => go.update(), true );

		ui.update();
	}
	
	override void onDraw()
	{
		goc.apply( go => go.draw() );

		ui.draw();

	}

	override void onShutdown()
	{
		logInfo( "Shutting down..." );
		goc.apply( go => go.shutdown() );
		goc.clearObjects();

		ui.shutdown();
	}

	override void onSaveState()
	{
		logInfo( "Resetting..." );
	}
}
