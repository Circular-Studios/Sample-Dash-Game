module testgame;
import dash;
import dash.utility.soloud;

import testobject;

class TestGame : DGame
{
    UserInterface ui;
    Camera cam;
    Soloud soloud;
    Speech speech;

    override void onInitialize()
    {
        logDebug( "Initializing TestGame..." );

        stateFlags.autoRefresh = false;

        Input.addButtonDownEvent( "Quit", ( newState ) { currentState = EngineState.Quit; } );
        Input.addButtonDownEvent( "Refresh", ( kc ) { currentState = EngineState.Refresh; } );
        Input.addButtonDownEvent( "Reset", ( kc ) { currentState = EngineState.Reset; } );
        Input.addButtonDownEvent( "Select", ( kc ) { auto obj = Input.mouseObject; logInfo( "Clicked on ", obj ? obj.name : "null" ); } );
        Input.addAxisEvent( "TestScroll", newVal => logInfo( "New Scroll: ", newVal ) );
        Input.addButtonDownEvent( "Spawn", ( kc )
            {
                static uint x = 0;
                auto newObj = Prefabs[ "SupaFab" ].createInstance();
                newObj.transform.position.x = x++;
                activeScene.addChild( newObj );
            } );

        Input.addButtonDownEvent( "SendToEditor",
                                     kc =>
                                        editor.send!string( "test", "myData",
                                                            response =>
                                                                logInfo( "Got response: ", response ) ) );

        activeScene = new Scene;
        activeScene.loadObjects( "" );
        activeScene.camera = activeScene[ "TestCamera" ].camera;

        Input.addButtonDownEvent( "ClubHorn", ( kc ) { activeScene[ "Child3" ].emitter.playFollow( "airhorn" ); } );

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
        logInfo( "Shutting down..." );
        foreach( obj; activeScene.objects )
            obj.shutdown();
        activeScene.clear();
        activeScene = null;

        ui.shutdown();
    }

    override void onSaveState()
    {
        logInfo( "Resetting..." );
    }

    override void onRefresh()
    {
        //logInfo( "Refreshing..." );
    }
}
