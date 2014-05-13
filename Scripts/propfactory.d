module propfactory;
import core, components;
import gl3n.linalg, gl3n.math;
import std.conv;

final abstract class PropFactory 
{
public static:
    GameObject createBuildingPiece( string name, vec3 position = vec3( 0, 0, 0 ), vec3 scale = vec3( .1f, .1f, .1f ), vec3 rotation = vec3( 0, 0, 0 ) )
    {
        auto obj = new GameObject();
        obj.mesh = Assets.get!Mesh(name);
        obj.material = Assets.get!Material("ModBuild");
        obj.transform.position = position;
        obj.transform.scale = scale;
        obj.transform.rotation = quat.identity.rotatex( rotation.x.radians ).rotatey( rotation.y.radians ).rotatez( rotation.z.radians );
        obj.name = name ~ obj.id.to!string;

        return obj;
    }
}