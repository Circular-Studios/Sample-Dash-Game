module testobject;
import core.gameobject;
import utility.input, utility.output, utility.time;
import components;
import gl3n.linalg;
import std.random;

class TOArgs
{
    int x;
}

class TestObject : Behavior!TOArgs
{
    override void onInitialize()
    {
        import std.stdio;
        writeln( initArgs.x );
    }

    // Overridables
    override void onUpdate() { }

    /// Called on the draw cycle.
    override void onDraw() { }
    /// Called on shutdown.
    override void onShutdown() { }
}

class RotateThing : Behavior!()
{
    alias owner this;
    // Overridables
    override void onUpdate()
    {
        this.transform.rotation.rotatey( -std.math.PI * Time.deltaTime );
    }
    
    /// Called on the draw cycle.
    override void onDraw() { }
    /// Called on shutdown.
    override void onShutdown() { }
}

class RotateCamera : Behavior!()
{
    alias owner this;
    // Overridables
    override void onUpdate()
    {
        this.transform.rotation.rotatex( -std.math.PI * Time.deltaTime );
    }
    
    /// Called on the draw cycle.
    override void onDraw() { }
    /// Called on shutdown.
    override void onShutdown() { }
}
