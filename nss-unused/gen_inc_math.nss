// Version 1.3 July 18th 2002
// Genji Include File for Math Functions
// genji@thegenji.com

// ----------------------------------------------[ function prototypes ]
// ----------------------------------------------[ math functions ]

// real vector in two space.  v = <i,j> were i = x axis and j = y axis
struct vectorR2
{
    float i, j;
};
// This is less a math function then a f'ing bug fix for placeable objects.
// Placeable objects return invalid facing's in the lower two quadrants
// of the unit circle. Let alone the fact that the arrow points the opposite
// direction. -------------------------------------- FIX ME ON TOOLSET PATCH
// only use GetFacingFromLocation(o) for this one,
// SUPPOSEDLY GetFacing(o) is fixed in 1.23, so i'm switching to it for objects.
// however, facingFromLocation(o) is still broke dick. 8.26.02
float FixFacing(float facing_in);
// get the angle that would be required to face the target. Trig version
// negative angle = turn clockwise.
float GetAngleToFaceTargetTrig(object fTarget,object fLooking);
// sub function to alloy inner call in GetAngleToFaceTargetTrig
float FindAngleToFaceTargetTrig(vector apexPoint,vector targetPoint,float currentFacing,float leg);
// get the angle that would be required to face the target. Vector version
// negative angle = turn clockwise.  always returns an angle <= 180.0 degrees with
// the direction indiacted by the sign.
float GetAngleToFaceTarget(object fTarget,object fLooking);
// sub function to alloy inner call in GetAngleToFaceTarget
float FindAngleToFaceTarget(vector apexPoint,vector targetPoint,float currentFacing,float leg);
// get the third point that would form an Isosceles triangle given the length
// and facing of the point apexPoint. Used in GetAngleToFaceTarget[Trig]
vector GetIsoscelesPointThree(vector fApexPoint,float fCurrentFacing,float fLength);
// use dot product and cos to figure out angle between vectorR2's passed in.
float AngleBetweenVectors(struct vectorR2 first,struct vectorR2 second);
// magnitude of the passed vector
float Magnitude(struct vectorR2 vect);
// dot product of the passed in vectors.
float DotProduct( struct vectorR2 first,struct vectorR2 second);
// Figure out if the angle to return in GetAngleToFaceTarget = clockwise or ccw.
int IsClockWise(vector apexPoint,vector targetPoint,float currentFacing, float angleToFace,float leg);
// return the slope of the line between point1 and point2
float GetSlope(vector fPoint1,vector fPoint2);
// this function returns a location using spherical coordinates
// with the X axis being the current facing of the location passed in.
// The location returned will be (r,offFacing_yaw,offFacing_pitch) where r = distance away,
// offFacing_yaw is the angle looking down at the location
// and offFacing_pitch is the angle looking at the side.
// offFacing_yaw: 0.0 is same direction you already are facing, -90.0 is exactly on the creature's right, 90.0 is on the left, and 180.0 is behind them.
// offFacing_pitch: 0.0 is same direction you already are facing, -90.0 is straight down, 90.0 is straight up, -180.0 is behind them.
// offFacingOnArrival can be used to turn the object granted this location by the amount specified.
// E.g. To get a location that is 10.0 meters on the creature's 11 oclock:
// location example = GetNearLocation(GetLocation(OBJECT_SELF),30.0,10.0);
//      To get a location that is 4 meters behind you and up in the air by 45 degrees:
// location example2 = GetNearLocation(GetLocation(OBJECT_SELF),-180.0,4.0,0.0,45.0);
// issues? Genji@thegenji.com 12-31-02 updated.
location GetNearLocation(location loc,float offFacing_yaw, float distanceFrom, float offFacingOnArrival = 0.0,float offFacing_pitch = 0.0);
// take the location passed in and return a location derived by rotating the
// position around the origin passed in as the X axis.
location GetRotatedByAxisX(location loc, float angle, location origin);
// take the location passed in and return a location derived by rotating the
// position around the origin passed in as the Y axis.
location GetRotatedByAxisY(location loc, float angle, location origin);
// take the location passed in and return a location derived by rotating the
// position around the origin passed in as the Z axis.
location GetRotatedByAxisZ(location loc, float angle, location origin);

// return a location that is within 1 and distance from target loc, randomly
// and heightZ meters off the ground so effects look centered on body if need be.
location GetProximity(location loc,int distance, float heightZ = 0.0);
// returns int is even or not.
int IsEven(int number);
// generic time output to string
string PrintTime();
// buffers natural numbers to hold zero's in places specified ( nat's and zero )
string BufferNat(int int_in,int places);
// this function returns a location using either spherical coordinates or by two-step axis rotation.
// If useSphericalCoord is TRUE then the location returned will be
// (r,offFacing_yaw,offFacing_pitch) where r = distance away, offFacing_yaw is the angle looking down at the location
// and offFacing_pitch is the angle looking at the side.
// offFacing_yaw: 0.0 is same direction you already are facing, -90.0 is exactly on the creature's right, 90.0 is on the left, and 180.0 is behind them.
// offFacing_pitch: 0.0 is same direction you already are facing, -90.0 is straight down, 90.0 is straight up, -180.0 is behind them.
// If useSphericalCoord is FALSE, then the offFacing_pitch is applied first, and then on that new plane the offFacing_yaw is applied.
// offFacingOnArrival can be used to turn the object granted this location by the amount specified.
// E.g. To get a location that is 10.0 meters on the creature's 11 oclock:
// location example = GetNearLocation(GetLocation(OBJECT_SELF),30.0,10.0);
//      To get a location that is 4 meters behind you and up in the air by 45 degrees:
// location example2 = GetNearLocation(GetLocation(OBJECT_SELF),-180.0,4.0,0.0,45.0);
//      To get a location that is on the plane 45 degrees up from your current facing, and on your left:
// location example3 = GetNearLocation(GetLocation(OBJECT_SELF),90.0,4.0,0.0,45.0,FALSE);
// issues? Genji@thegenji.com 12-31-02 updated.
location OldGetNearLocation(location loc,float offFacing_yaw, float distanceFrom, float offFacingOnArrival = 0.0,float offFacing_pitch = 0.0,int useSphericalCoord = TRUE);

location OldGetNearLocation(location loc,float offFacing_yaw, float distanceFrom, float offFacingOnArrival = 0.0,float offFacing_pitch = 0.0,int useSphericalCoord = TRUE)
{
    float currentFacing = FixFacing(GetFacingFromLocation(loc));
    vector pos = GetPositionFromLocation(loc);
    float newX,newY,newZ;
    if (useSphericalCoord)
    {
        newX = pos.x + (distanceFrom * sin(90.0 - offFacing_pitch)* cos(currentFacing + offFacing_yaw));
        newY =  pos.y + (distanceFrom * sin(90.0 - offFacing_pitch) * sin(currentFacing + offFacing_yaw));
        newZ = pos.z + (distanceFrom * cos(90.0 - offFacing_pitch));
    }
    else
    {
        newX = pos.x + (distanceFrom * cos(currentFacing + offFacing_yaw) * cos(-1 * offFacing_pitch));
        newY =  pos.y + (distanceFrom * sin(currentFacing + offFacing_yaw));
        newZ = pos.z + (distanceFrom * cos(currentFacing + offFacing_yaw) * sin(-1 * offFacing_pitch));
    }
    return Location(GetAreaFromLocation(loc),Vector(newX,newY,newZ),currentFacing + offFacingOnArrival);
}
// ----------------------------------------------[ function implementations ]
// ----------------------------------------------[ math functions ]

float FixFacing(float facing_in)
{
  if (facing_in < 0.0) facing_in += 360.0;
  return facing_in;
}

float GetAngleToFaceTargetTrig(object fTarget,object fLooking)
{
   // this function's algorithym is based on an isosceles triangle within the
   // unit circle and uses that terminology within
   float angleBetween = 0.0;
   float currentFacing = GetFacing(fLooking);

   if (currentFacing >= 0.0 && GetIsObjectValid(fTarget))
   {
      // declarations
      vector apexPoint = GetPosition(fLooking);
      vector targetPoint = GetPosition(fTarget);

      float leg = GetDistanceBetweenLocations(GetLocation(fLooking), GetLocation(fTarget));

      angleBetween = FindAngleToFaceTargetTrig(apexPoint,targetPoint,currentFacing,leg);
      int cw = IsClockWise(apexPoint,targetPoint,currentFacing,angleBetween,leg);
      if (cw) angleBetween *= -1; // clock wise rotation lowers facing, 0.0 = east
   }
   return angleBetween;
}

float FindAngleToFaceTargetTrig(vector apexPoint,vector targetPoint,float currentFacing,float leg)
{
   vector mirrorPoint = GetIsoscelesPointThree(apexPoint,currentFacing,leg);
   float angleBetween = 0.0;

   if (apexPoint != mirrorPoint)
   {
      float angle = 0.0;
      float m1 = GetSlope(targetPoint,apexPoint);
      float m2 = GetSlope(targetPoint,mirrorPoint);

      if (m1 > m2) angle = fabs(atan((m1 - m2)/(1 +(m1*m2))));
      else angle = fabs(atan((m2 - m1)/(1 +(m1*m2))));

      angleBetween = 180.0 - (2.0 * angle);
   }
   return angleBetween;
}

float GetAngleToFaceTarget(object fTarget,object fLooking)
{
   // this function's algorithym is based on vectors ( linear alg. )
   // and dot products
   float angleBetween = 0.0;
   float currentFacing = GetFacing(fLooking);
   if (currentFacing >= 0.0 && GetIsObjectValid(fTarget))
   {
    // declarations
      vector apexPoint = GetPosition(fLooking);
      vector targetPoint = GetPosition(fTarget);
      float leg = GetDistanceBetweenLocations(GetLocation(fLooking), GetLocation(fTarget));

      angleBetween = FindAngleToFaceTarget(apexPoint,targetPoint,currentFacing,leg);
      int cw = IsClockWise(apexPoint,targetPoint,currentFacing,angleBetween,leg);
      if (cw) angleBetween *= -1; // clock wise rotation lowers facing, o.o = east
   }
   return angleBetween;
}

float FindAngleToFaceTarget(vector apexPoint,vector targetPoint,float currentFacing,float leg)
{
   vector mirrorPoint = GetIsoscelesPointThree(apexPoint,currentFacing,leg);

   if (apexPoint != mirrorPoint)
   {
      struct vectorR2 face;
      face.i = mirrorPoint.x - apexPoint.x;
      face.j = mirrorPoint.y - apexPoint.y;

      struct vectorR2 target;
      target.i = targetPoint.x - apexPoint.x;
      target.j = targetPoint.y - apexPoint.y;

      return AngleBetweenVectors(face,target);
   }
   return 0.0;
}
vector GetIsoscelesPointThree( vector fApexPoint,float fCurrentFacing,float fLength)
{
   vector point = fApexPoint;

   if (fCurrentFacing  >= 0.0 && fLength > 0.0)
   {
      point = Vector(fApexPoint.x + (cos(fCurrentFacing) * fLength),
                     fApexPoint.y + (sin(fCurrentFacing) * fLength),
                     fApexPoint.z);
   }
   return point;
}

float AngleBetweenVectors(struct vectorR2 first,struct vectorR2 second)
{
  float magFirst = Magnitude(first);
  float magSecond = Magnitude(second);
  float angleBetween = 0.0;
  if (magFirst > 0.0 && magSecond > 0.0) // no zero vectors here.
  {
   angleBetween = acos(DotProduct(first,second) / ( magFirst * magSecond ));
  }
  return angleBetween;
}

float Magnitude(struct vectorR2 vect)
{
  return sqrt(pow(vect.i,2.0) + pow(vect.j,2.0));
}

float DotProduct(struct vectorR2 first,struct vectorR2 second)
{
  return  (first.i * second.i) + (first.j * second.j);

}

int IsClockWise(vector apexPoint,vector targetPoint,float currentFacing, float angleToFace,float leg)
{
  if (angleToFace < 90.0 && angleToFace > 5.0)
     return FindAngleToFaceTarget(apexPoint,targetPoint,currentFacing - 5.0,leg) < angleToFace;
  else
     return FindAngleToFaceTarget(apexPoint,targetPoint,currentFacing + 5.0,leg) > angleToFace;
}

float GetSlope(vector fPoint1,vector fPoint2)
{
   if (fPoint1.x == fPoint2.x)
   {
      return 320000000.0; // never admit it's infinite, to hell with specifics.
   } else if (fPoint2.x > fPoint1.x) {
      return ((fPoint2.y - fPoint1.y)/(fPoint2.x - fPoint1.x));
   } else {
      return ((fPoint1.y - fPoint2.y)/(fPoint1.x - fPoint2.x));
   }
}

location GetNearLocation(location loc,float offFacing_yaw, float distanceFrom, float offFacingOnArrival = 0.0,float offFacing_pitch = 0.0)
{
    float currentFacing = FixFacing(GetFacingFromLocation(loc));
    vector pos = GetPositionFromLocation(loc);
    float newX,newY,newZ;
    // return spherical coordinates with the facing of the location = the positive x axis.
    newX = pos.x + (distanceFrom * sin(90.0 - offFacing_pitch)* cos(currentFacing + offFacing_yaw));
    newY =  pos.y + (distanceFrom * sin(90.0 - offFacing_pitch) * sin(currentFacing + offFacing_yaw));
    newZ = pos.z + (distanceFrom * cos(90.0 - offFacing_pitch));

    return Location(GetAreaFromLocation(loc),Vector(newX,newY,newZ),currentFacing + offFacingOnArrival);
}

location GetRotatedByAxisX(location loc, float angle, location origin)
{
    // x, y'=y*cos(theta)-z*sin(theta), z'=y*sin(theta)+z*cos(theta)
    float currentFacing = FixFacing(GetFacingFromLocation(loc));
    vector originPos = GetPositionFromLocation(origin);
    vector pos = GetPositionFromLocation(loc);
    float newY,newZ;
    //adjust for origin, rotate, then add back in.
    newY = (pos.y - originPos.y) * cos(angle) - (pos.z - originPos.z) * sin(angle) + originPos.y;
    newZ = (pos.y - originPos.y) * sin(angle) + (pos.z - originPos.z) * cos(angle) + originPos.z;

    return Location(GetAreaFromLocation(loc),Vector(pos.x,newY,newZ),currentFacing);
}

location GetRotatedByAxisY(location loc, float angle, location origin)
{
    // x'=z*sin(theta)+x*cos(theta), y'=y, z'=z*cos(theta)-x*sin(theta)
    float currentFacing = FixFacing(GetFacingFromLocation(loc));
    vector originPos = GetPositionFromLocation(origin);
    vector pos = GetPositionFromLocation(loc);
    float newX,newZ;
    //adjust for origin, rotate, then add back in.
    newX = (pos.z - originPos.z) * sin(angle) + (pos.x - originPos.x) * cos(angle) + originPos.x;
    newZ = (pos.z - originPos.z) * cos(angle) - (pos.x - originPos.x) * sin(angle) + originPos.z;

    return Location(GetAreaFromLocation(loc),Vector(newX,pos.y,newZ),currentFacing);
}

location GetRotatedByAxisZ(location loc, float angle, location origin)
{
    // x'=x*cos(Zan)-y*sin(Zan), y'=x*sin(Zan)+y*cos(Zan), z'=z
    float currentFacing = FixFacing(GetFacingFromLocation(loc));
    vector originPos = GetPositionFromLocation(origin);
    vector pos = GetPositionFromLocation(loc);
    float newY,newX;
    //adjust for origin, rotate, then add back in.
    newX = (pos.x - originPos.x) * cos(angle) - (pos.y - originPos.y) * sin(angle) + originPos.x;
    newY = (pos.x - originPos.x) * sin(angle) + (pos.y - originPos.y) * cos(angle) + originPos.y;

    return Location(GetAreaFromLocation(loc),Vector(newX,newY,pos.z),currentFacing);
}

location GetProximity(location loc,int distance, float heightZ = 0.0)
{
    int flip1,flip2;
    if ((flip1 = d2()) == 2) flip1 = -1; // flip1 = 1 || -1
    if ((flip2 = d2()) == 2) flip2 = -1; // flip2 = 1 || -1
    vector pos = GetPositionFromLocation(loc);
    return Location(GetAreaFromLocation(loc),
            Vector(pos.x + (flip2 * (Random(distance) + 1)),
                   pos.y + (flip1 * (Random(distance) + 1)),
                   pos.z + heightZ),FixFacing(GetFacingFromLocation(loc)));
}

int IsEven(int number)
{
    return number % 2 == 0;
}

string PrintTime()
{
   return BufferNat(GetTimeHour(),2) +":" +
          BufferNat(GetTimeMinute(),2) + ":" +
          BufferNat(GetTimeSecond(),2) + "." +
          BufferNat(GetTimeMillisecond(),3);
}

string BufferNat(int natural_in,int places)
{
    if (natural_in < 0 || places < 1) return "";
    string retVal = IntToString(natural_in);
    while (GetStringLength(retVal) < places)
        retVal = "0" + retVal;
    return retVal;
}
