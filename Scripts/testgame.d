module testgame;
import core;
import graphics.graphics;
import components.camera, components.userinterface;
import utility;

shared class TestGame : DGame
{
	Scene scene;
	UserInterface ui;
	Camera cam;
	
	override void onInitialize()
	{
		logInfo( "Initializing TestGame..." );

		Input.addKeyDownEvent( Keyboard.Escape, ( uint kc ) { currentState = GameState.Quit; } );
		Input.addKeyDownEvent( Keyboard.F5, ( uint kc ) { currentState = GameState.Reset; } );

		scene = new shared Scene;
		scene.loadObjects( "" );

		auto camobj = scene[ "TestCamera" ];
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
		foreach( obj; scene )
			obj.update();

		ui.update();
	}
	
	override void onDraw()
	{
		foreach( obj; scene )
			obj.update();

		ui.draw();

	}

	override void onShutdown()
	{
		logInfo( "Shutting down..." );
		foreach( obj; scene )
			obj.shutdown();
		scene.clear();

		ui.shutdown();
	}

	override void onSaveState()
	{
		logInfo( "Resetting..." );
	}
}
