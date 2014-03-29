module testgame;
import core;
import graphics.graphics;
import components.camera, components.userinterface;
import utility;

shared class TestGame : DGame
{
	UserInterface ui;
	Camera cam;
	
	override void onInitialize()
	{
		logInfo( "Initializing TestGame..." );

		Input.addKeyDownEvent( Keyboard.Escape, ( uint kc ) { currentState = GameState.Quit; } );
		Input.addKeyDownEvent( Keyboard.F5, ( uint kc ) { currentState = GameState.Reset; } );

		activeScene = new shared Scene;
		activeScene.loadObjects( "" );

		auto camobj = activeScene[ "TestCamera" ];
		//camobj.transform.rotation.rotatex( -std.math.PI_4 );
		Graphics.setCamera( camobj.camera );

		uint w, h;
		w = Config.get!uint( "Display.Width" );
		h = Config.get!uint( "Display.Height" );
		ui = new shared UserInterface(w, h, Config.get!string( "UserInterface.FilePath" ) );

		logInfo( "Starting Time: ", Time.totalTime );
		scheduleTimedTask( { logInfo( "Executing: ", Time.totalTime ); }, 2.seconds );
	}

	override void onUpdate()
	{
		foreach( obj; activeScene )
			obj.update();

		ui.update();
	}
	
	override void onDraw()
	{
		foreach( obj; activeScene )
			obj.draw();

		ui.draw();

	}

	override void onShutdown()
	{
		logInfo( "Shutting down..." );
		foreach( obj; activeScene )
			obj.shutdown();
		activeScene.clear();

		ui.shutdown();
	}

	override void onSaveState()
	{
		logInfo( "Resetting..." );
	}
}
