module testgame;
import core.dgame, core.gameobjectcollection;
import graphics.graphics;
import components.camera;
import utility.output, utility.input;

shared class TestGame : DGame
{
	GameObjectCollection goc;
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
	}
	
	override void onUpdate()
	{
		goc.apply( go => go.update() );
	}
	
	override void onDraw()
	{
		goc.apply( go => go.draw() );
	}

	override void onShutdown()
	{
		logInfo( "Shutting down..." );
		goc.apply( go => go.shutdown() );
		goc.clearObjects();
	}

	override void onSaveState()
	{
		logInfo( "Resetting..." );
	}
}
