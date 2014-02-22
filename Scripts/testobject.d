module testobject;
import core.gameobject;
import utility.output, utility.time;

class TestObject : GameObject
{
	// Overridables
	override void onUpdate()
	{
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
