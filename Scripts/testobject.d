module testobject;
import core.gameobject;
import utility.input, utility.output, utility.time;
import components;
import gl3n.linalg;
import std.random;

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

		this.transform.updateMatrix();
		/*
		auto liiiiight = (cast(DirectionalLight)this.light);

		// If you were actually thinking about doing this in your game, please don't.
		static float red = 0.0f;
		static float blu = 50.0f;
		static float gre = 100.0f;
		static float redMod = 0.1f;
		static float bluMod = 0.1f;
		static float greMod = 0.1f;

		// Change color direction
		if(red >= 100 || red < 0) redMod = -redMod;
		if(blu >= 100 || blu < 0) bluMod = -bluMod;
		if(gre >= 100 || gre < 0) greMod = -greMod;
	
		red += redMod;
		blu += bluMod;
		gre += greMod;

		liiiiight.color = vec3(red/100.0f, blu/100.0f, gre/100.0f); */
	}

	/// Called on the draw cycle.
	override void onDraw() { }
	/// Called on shutdown.
	override void onShutdown() { }
	/// Called when the object collides with another object.
	override void onCollision( GameObject other ) { }
}


class RotateBitch : GameObject
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


		//this.transform.rotation.rotatez( -std.math.PI * Time.deltaTime);
		this.transform.updateMatrix();
		

	}
	
	/// Called on the draw cycle.
	override void onDraw() { }
	/// Called on shutdown.
	override void onShutdown() { }
	/// Called when the object collides with another object.
	override void onCollision( GameObject other ) { }
}


