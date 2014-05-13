module testgame;
import core, camera;
import graphics.graphics;
import components.camera, components.userinterface;
import utility;

import testobject;

import gl3n.linalg;

mixin ContentImport;

class TestGame : DGame
{
    UserInterface ui;
    
    override void onInitialize()
    {
        logDebug( "Initializing TestGame..." );
        Input.addButtonDownEvent( "QuitToDesktop", ( uint kc ) { currentState = EngineState.Quit; } );
        Input.addButtonDownEvent( "ResetGame", ( uint kc ) { currentState = EngineState.Reset; } );
        Mouse.addButtonDownEvent( Mouse.Buttons.Left, ( kc ) { if( auto obj = Input.mouseObject ) logInfo( "Clicked on ", obj.name ); } );
        Mouse.addButtonDownEvent( Mouse.Buttons.Right, ( kc )
            {
                static uint x = 0;
                auto newObj = Prefabs[ "SupaFab" ].createInstance();
                newObj.transform.position.x = x++;
                activeScene.addChild( newObj );
            } );

        activeScene = new Scene;
        activeScene.loadObjects( "" );

        // make a camera
        auto cam = activeScene[ "Camera" ].behaviors.get!AdvancedCamera;
        activeScene.camera = cam.camera;

        //auto obj = GameObject.createWithBehavior!TestObject;

        //scheduleTimedTask( { logInfo( "Executing: ", Time.totalTime ); }, 250.msecs );
        uint w, h;
        w = config.find!uint( "Display.Width" );
        h = config.find!uint( "Display.Height" );
        ui = new UserInterface(w, h, config.find!string( "UserInterface.FilePath" ) );
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
}
