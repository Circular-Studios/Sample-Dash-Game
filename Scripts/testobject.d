module testobject;
import core.gameobject;
import utility.input, utility.output, utility.time;
import components;
import gl3n.linalg;
import std.random;

mixin( registerComponents!q{testobject} );

@yamlComponent()
class TestObject : Component
{
    override void initialize()
    {
        
    }

    // Overridables
    override void update()
    {
        if( Input.getState( "Forward" ) )
        {
            logNotice( "Forward" );
        }
        if( Input.getState( "Backward" ) )
        {
            logNotice( "Backward" );
        }
        if( Input.getState( "Jump" ) )
        {
            logNotice( "Jump" );
        }
    }

    /// Called on shutdown.
    override void shutdown() { }
}

@yamlComponent()
class RotateThing : Component
{
    alias owner this;

    @field( "X" )
    float x;

    override void initialize()
    {
        logInfo( "Init RotateThing X: ", x );
    }

    // Overridables
    override void update()
    {
        if( Input.getState( "Forward" ) )
        {
            logNotice( "Forward" );
        }
        if( Input.getState( "Backward" ) )
        {
            logNotice( "Backward" );
        }
        if( Input.getState( "Jump" ) )
        {
            logNotice( "Jump" );
        }

        this.transform.rotation.rotatey( -std.math.PI * Time.deltaTime );
    }
    
    /// Called on shutdown.
    override void shutdown() { }
}

@yamlComponent()
class RotateCamera : Component
{
    alias owner this;
    // Overridables
    override void update()
    {
        this.transform.rotation.rotatex( -std.math.PI * Time.deltaTime );
    }
    
    /// Called on shutdown.
    override void shutdown() { }
}
