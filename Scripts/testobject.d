module testobject;
import dash;
import std.random;

mixin( registerComponents!() );

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
            trace( "Forward" );
        }
        if( Input.getState( "Backward" ) )
        {
            trace( "Backward" );
        }
        if( Input.getState( "Jump" ) )
        {
            trace( "Jump" );
        }
    }

    /// Called on shutdown.
    override void shutdown() { }
}

enum Color
{
    Empty,
    White,
    Black,
}

class RotateThing : Component
{
    alias owner this;

    @rename( "X" )
    float x;
    @rename( "Color" ) @byName
    Color color;

    override void initialize()
    {
        info( "Init RotateThing X: ", x, " Color: ", color );
    }

    // Overridables
    override void update()
    {
        if( Input.getState( "Forward" ) )
        {
            trace( "Forward" );
        }
        if( Input.getState( "Backward" ) )
        {
            trace( "Backward" );
        }
        if( Input.getState( "Jump" ) )
        {
            trace( "Jump" );
        }

        this.transform.rotation *= fromEulerAngles!float( 0.0f, (-std.math.PI * Time.deltaTime).degrees, 0.0f );
    }

    /// Called on shutdown.
    override void shutdown() { }
}

class RotateCamera : Component
{
    alias owner this;
    // Overridables
    override void update()
    {
        this.transform.rotation *= fromEulerAngles!float( (-std.math.PI * Time.deltaTime).degrees, 0.0f, 0.0f );
    }

    /// Called on shutdown.
    override void shutdown() { }
}
