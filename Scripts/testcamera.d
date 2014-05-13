module testcamera;
import core, graphics, components, utility;
import gl3n.linalg;

class CameraFields
{
    float Height;
    float Speed;
    float Gravity;
}

class TestCamera : Behavior!CameraFields
{
private:
    float height, speed, yvel, gravity;
    bool free;

public:
    override void onInitialize()
    {
        height = initArgs.Height;
        speed = initArgs.Speed;
        gravity = initArgs.Gravity;
        owner.transform.position.y = height;
        yvel = 0;

        logDebug( height, " ", speed, " ", gravity, " ", yvel );

        free = false;

        Input.addButtonDownEvent( "Toggle", (uint kc) { logDebug("FREEDOM!"); free = !free; } );
        Input.addButtonDownEvent( "Jump", &jump );
    }

    override void onUpdate()
    {
        auto curSpeed = speed;
        if( Input.getState( "Modify" ) )
        {
            curSpeed *= 2;
        }

        if( !free )
        {
            yvel += gravity * Time.deltaTime;
            owner.transform.position.y += yvel * Time.deltaTime;

            if( owner.transform.position.y < height )
                owner.transform.position.y = height;
            if( yvel < gravity )
                yvel = gravity;

            
            ///Yay local function!
            vec3 planar( vec3 dir )
            {
                auto v = dir;
                v.y = 0;
                v.normalize;
                return v;
            }

            vec3 moveVec = vec3( 0, 0, 0 );
            if( Input.getState( "Forward" ) )
            {
                moveVec += planar( owner.transform.forward );
            }
            else if( Input.getState( "Backward" ) )
            {
                moveVec += planar( -owner.transform.forward );
            }

            if( Input.getState( "Right" ) )
            {
                moveVec += planar( owner.transform.right );
            }
            else if( Input.getState( "Left" ) )
            {
                moveVec += planar( -owner.transform.right );
            }

            moveVec.normalize;
            moveVec *= curSpeed * Time.deltaTime;
            owner.transform.position += moveVec;
        }
        else
        {
            vec3 moveVec = vec3( 0, 0, 0 );
            if( Input.getState( "Forward" ) )
            {
                moveVec += owner.transform.forward;
            }
            else if( Input.getState( "Backward" ) )
            {
                moveVec += -owner.transform.forward;
            }

            if( Input.getState( "Right" ) )
            {
                moveVec += owner.transform.right;
            }
            else if( Input.getState( "Left" ) )
            {
                moveVec += -owner.transform.right;
            }

            if( Input.getState( "Up" ) )
            {
                moveVec += owner.transform.up;
            }
            else if( Input.getState( "Down" ) )
            {
                moveVec += -owner.transform.up;
            }

            moveVec.normalize;
            moveVec *= curSpeed * Time.deltaTime;
            owner.transform.position += moveVec;
        }
    }


    void jump( uint keyCode )
    {
        logInfo( "Jump jump, the house is jumpin ");
        if( owner.transform.position.y <= height )
        {
            yvel = speed * 1.75;
            logDebug( yvel );
        }
    }
}