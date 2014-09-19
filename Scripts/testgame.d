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

        Keyboard.addButtonDownEvent( Keyboard.Buttons.Escape, ( kc ) { currentState = EngineState.Quit; } );
        Keyboard.addButtonDownEvent( Keyboard.Buttons.F5, ( kc ) { currentState = EngineState.Refresh; } );
        Keyboard.addButtonDownEvent( Keyboard.Buttons.F6, ( kc ) { currentState = EngineState.Reset; } );
        Mouse.addButtonDownEvent( Mouse.Buttons.Left, ( kc ) { auto obj = Input.mouseObject; logInfo( "Clicked on ", obj ? obj.name : "null" ); } );
        Mouse.addAxisEvent( Mouse.Axes.ScrollWheel, ( ac, newVal ) => logInfo( "New Scroll: ", newVal ) );
        Mouse.addButtonDownEvent( Mouse.Buttons.Right, ( kc )
            {
                static uint x = 0;
                auto newObj = Prefabs[ "SupaFab" ].createInstance();
                newObj.transform.position.x = x++;
                activeScene.addChild( newObj );
            } );

        Keyboard.addButtonDownEvent( Keyboard.Buttons.B,
                                     kc =>
                                        editor.send!string( "test", "myData",
                                                            response =>
                                                                logInfo( "Got response: ", response ) ) );

        activeScene = new Scene;
        activeScene.loadObjects( "" );
        activeScene.camera = activeScene[ "TestCamera" ].camera;

        uint w, h;
        w = config.display.width;
        h = config.display.height;
        ui = new UserInterface(w, h, config.userInterface.filePath);

        //auto obj = GameObject.createWithBehavior!TestObject;

        //scheduleTimedTask( { logInfo( "Executing: ", Time.totalTime ); }, 250.msecs );

        import std.string: toStringz;
        soloud = Soloud.create();
        soloud.init();
        speech = Speech.create();

        speech.setText("welcome".toStringz());
        auto handle = soloud.play(speech);
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
        soloud.deinit();

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
