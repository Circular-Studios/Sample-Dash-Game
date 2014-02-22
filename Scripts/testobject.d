module testobject;
import core.gameobject;
import utility.input, utility.output, utility.time;

class TestObject : GameObject
{
	// Overridables
	override void onUpdate()
	{
		if( Input.getState( "Forward" ) )
		{
			log( OutputType.Info, "Forward" );
		}
		if( Input.getState( "Backward" ) )
		{
			log( OutputType.Info, "Backward" );
		}
		if( Input.getState( "Jump" ) )
		{
			log( OutputType.Info, "Jump" );
		}
		this.transform.rotation.rotatey( std.math.PI / 130 * Time.deltaTime);
		this.transform.rotation.rotatez( std.math.PI / -120 * Time.deltaTime);
		this.transform.updateMatrix();
	}

	/// Called on the draw cycle.
	override void onDraw() { }
	/// Called on shutdown.
	override void onShutdown() { }
	/// Called when the object collides with another object.
	override void onCollision( GameObject other ) { }
}
