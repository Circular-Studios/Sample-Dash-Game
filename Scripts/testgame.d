module testgame;
import dash;
import dash.utility.bindings.soloud;

import testobject;

class TestGame : DGame
{
    UserInterface ui;
    Camera cam;
    Soloud soloud;
    Speech speech;

    override void onInitialize()
    {
        trace( "Initializing TestGame..." );

        stateFlags.autoRefresh = false;

        Input.addButtonDownEvent( "Quit", ( _ ) { currentState = EngineState.Quit; } );
        Input.addButtonDownEvent( "Refresh", ( _ ) { currentState = EngineState.Refresh; } );
        Input.addButtonDownEvent( "Reset", ( _ ) { currentState = EngineState.Reset; } );
        Input.addButtonDownEvent( "Select", ( _ ) { auto obj = Input.mouseObject; infof( "Clicked on %s", obj ? obj.name : "null" ); } );
        Input.addAxisEvent( "TestScroll", newVal => infof( "New Scroll: %s", newVal ) );
        Input.addButtonDownEvent( "Spawn", ( _ )
            {
                static uint x = 0;
                auto newObj = Prefabs[ "SupaFab" ].createInstance();
                newObj.transform.position.x = x++;
                activeScene.addChild( newObj );
            } );

        Input.addButtonDownEvent( "SendToEditor",
                                     _ =>
                                        editor.send( "test", "myData",
                                                            ( string response ) =>
                                                                infof( "Got response: %s", response ) ) );

        activeScene = new Scene;
        activeScene.loadObjects( "" );
        activeScene.camera = activeScene[ "TestCamera" ].camera;

        Input.addButtonDownEvent( "ClubHorn", ( _ ) { activeScene[ "Child3" ].emitter.playFollow( "airhorn" ); } );

        uint w, h;
        w = config.display.width;
        h = config.display.height;
        ui = new UserInterface(w, h, config.userInterface.filePath);

        //auto obj = GameObject.createWithBehavior!TestObject;

        //scheduleTimedTask( { logInfo( "Executing: ", Time.totalTime ); }, 250.msecs );

        import std.string: toStringz;
        speech = Speech.create();

        speech.setText("welcome".toStringz());
        auto handle = Audio.soloud.play(speech);

		// Animation tests
		Animation anim = activeScene[ "DudeBrah" ].getComponent!Animation;
		Input.addButtonDownEvent( "Pause", ( _ )
		{
			if(anim.IsPlaying())
				anim.pause();
			else
				anim.play();
		} );
		Input.addButtonDownEvent( "Stop", ( _ )
		{
			anim.stop();
		} );
		Input.addButtonDownEvent( "AnimOne", ( _ )
		{
			anim.changeAnimation( 0, 0 );
		} );
		Input.addButtonDownEvent( "AnimTwo", ( _ )
		{
			anim.changeAnimation( 1, 0 );
		} );
		Input.addButtonDownEvent( "AnimTwoOnce", ( _ )
		                         {
			anim.runAnimationOnce( 1 );
		} );
    }

    override void onUpdate()
    {
        ui.update();
    }

    override void onDraw()
    {
        ui.draw();
    }

    override void onShutdown()
    {
        trace( "Shutting down..." );
        foreach( obj; activeScene.objects )
            obj.shutdown();
        activeScene.clear();
        activeScene = null;

        ui.shutdown();
    }

    override void onSaveState()
    {
        trace( "Resetting..." );
    }

    override void onRefresh()
    {
        //logInfo( "Refreshing..." );
    }
}
