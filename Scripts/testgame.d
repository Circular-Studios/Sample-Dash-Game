module testgame;
import core, graphics, components, utility;
import propfactory;

import gl3n.linalg;

mixin ContentImport;

class TestGame : DGame
{
    UserInterface ui;
    Camera cam;
    
    override void onInitialize()
    {
        logDebug( "Initializing TestGame..." );

        Keyboard.addButtonDownEvent( Keyboard.Buttons.Escape, ( kc ) { currentState = EngineState.Quit; } );
        Keyboard.addButtonDownEvent( Keyboard.Buttons.F5, ( kc ) { currentState = EngineState.Reset; } );
        Mouse.addButtonDownEvent( Mouse.Buttons.Left, ( kc ) { if( auto obj = Input.mouseObject ) logInfo( "Clicked on ", obj.name ); } );
        Mouse.addAxisEvent( Mouse.Axes.ScrollWheel, ( ac, newVal ) => logInfo( "New Scroll: ", newVal ) );

        activeScene = new Scene;
        activeScene.loadObjects( "" );
        activeScene.camera = activeScene[ "TestCamera" ].camera;

        uint w, h;
        w = config.find!uint( "Display.Width" );
        h = config.find!uint( "Display.Height" );
        ui = new UserInterface(w, h, config.find!string( "UserInterface.FilePath" ) );

        //auto wall = PropFactory.buildingPiece("hangar_door", vec3( 0, 0, -5 ));
        //activeScene.addChild(wall);

        auto floor = PropFactory.texturedPlane( "GrayTile", 10, 10, 10 );
        activeScene.addChild( floor );
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
