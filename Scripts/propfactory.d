module propfactory;
import core, components;
import gl3n.linalg, gl3n.math;
import std.conv;

final abstract class PropFactory 
{
public static:
    GameObject buildingPiece( string name, vec3 position = vec3( 0, 0, 0 ), vec3 scale = vec3( .1f, .1f, .1f ), vec3 rotation = vec3( 0, 0, 0 ) )
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

    /// Default rotation is for a ground-plane
    GameObject texturedPlane( string name, int rCount, int cCount, float tileSize, vec3 position = vec3( 0, 0, 0 ), vec3 rotation = vec3( -90, 0, 0 ) )
    {
        auto obj = new GameObject();
        vec3 scale = vec3( tileSize, tileSize, tileSize );
        for( int i = 0; i < rCount; i++ )
        {
            for( int j = 0; j < cCount; j++ )
            {
                auto tile = new GameObject();
                tile.mesh = Assets.get!Mesh( "tile" );
                tile.material = Assets.get!Material( name );
                tile.transform.position.x = j * tileSize;
                tile.transform.position.y = i * tileSize;
                tile.transform.scale = scale;
                tile.name = name ~ "Tile" ~ i.to!string ~ ":" ~ j.to!string ~ "#" ~ tile.id.to!string;
                obj.addChild( tile );
            }
        }

        obj.transform.position = position;
        obj.transform.rotation = quat.identity.rotatex( rotation.x.radians ).rotatey( rotation.y.radians ).rotatez( rotation.z.radians );
        return obj;
    }
}