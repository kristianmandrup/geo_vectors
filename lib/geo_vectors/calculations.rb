# Source:  http://www.movable-type.co.uk/scripts/latlong.html

# Distance
# 
# This uses the ‘haversine’ formula to calculate great-circle distances between the two points – that is, the shortest distance over the earth’s surface – giving an ‘as-the-crow-flies’ distance between the points (ignoring any hills!).

var R = 6371; // km
var dLat = (lat2-lat1).toRad();
var dLon = (lon2-lon1).toRad(); 
var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.cos(lat1.toRad()) * Math.cos(lat2.toRad()) * 
        Math.sin(dLon/2) * Math.sin(dLon/2); 
var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
var d = R * c;

# Spherical Law of Cosines

var R = 6371; // km
var d = Math.acos(Math.sin(lat1)*Math.sin(lat2) + 
                  Math.cos(lat1)*Math.cos(lat2) *
                  Math.cos(lon2-lon1)) * R;

# Bearing
# Baghdad to Osaka Baghdad to Osaka
# 
# In general, your current heading will vary as you follow a great circle path (orthodrome); the final heading will differ from the initial heading by varying degrees according to distance and latitude (if you were to go from say 35°N,45°E (Baghdad) to 35°N,135°E (Osaka), you would start on a heading of 60° and end up on a heading of 120°!).
# 
# This formula is for the initial bearing (sometimes referred to as forward azimuth) which if followed in a straight line along a great-circle arc will take you from the start point to the end point:

var y = Math.sin(dLon) * Math.cos(lat2);
var x = Math.cos(lat1)*Math.sin(lat2) -
        Math.sin(lat1)*Math.cos(lat2)*Math.cos(dLon);
var brng = Math.atan2(y, x).toDeg();


# Midpoint
# 
# This is the midpoint along a great circle path between the two points.

var Bx = Math.cos(lat2) * Math.cos(dLon);
var By = Math.cos(lat2) * Math.sin(dLon);
var lat3 = Math.atan2(Math.sin(lat1)+Math.sin(lat2),
                      Math.sqrt( (Math.cos(lat1)+Bx)*(Math.cos(lat1)+Bx) + By*By) ); 
var lon3 = lon1 + Math.atan2(By, Math.cos(lat1) + Bx);


# Destination point given distance and bearing from start point
# 
# Given a start point, initial bearing, and distance, this will calculate the destination point and final bearing travelling along a (shortest distance) great circle arc.

# d/R is the angular distance (in radians), where d is the distance travelled and R is the earth’s radius

var lat2 = Math.asin( Math.sin(lat1)*Math.cos(d/R) + 
                      Math.cos(lat1)*Math.sin(d/R)*Math.cos(brng) );
var lon2 = lon1 + Math.atan2(Math.sin(brng)*Math.sin(d/R)*Math.cos(lat1), 
                             Math.cos(d/R)-Math.sin(lat1)*Math.sin(lat2));

# 
# Intersection of two paths given start points and bearings
# 
# This is a rather more complex calculation than most others on this page, but I've been asked for it a number of times. See below for the JavaScript.

- See code on page to find javascript

# Cross-track distance
# 
# Here’s a new one: I’ve sometimes been asked about distance of a point from a great-circle path (sometimes called cross track error).

var dXt = Math.asin(Math.sin(d13/R)*Math.sin(brng13-brng12)) * R;

# Here, the great-circle path is identified by a start point and an end point – depending on what initial data you’re working from, you can use the formulæ above to obtain the relevant distance and bearings. The sign of dxt tells you which side of the path the third point is on.
# 
# The along-track distance, from the start point to the closest point on the path to the third point, is

var dAt = Math.acos(Math.cos(d13/R)/Math.cos(dXt/R)) * R;


# Closest point to the poles
# 
# ‘Clairaut’s formula’ will give you the maximum latitude of a great circle path, given a bearing and latitude on the great circle:

var latMax = Math.acos(Math.abs(Math.sin(brng)*Math.cos(lat)));

# Rhumb lines
# 
# A ‘rhumb line’ (or loxodrome) is a path of constant bearing, which crosses all meridians at the same angle.
# 
# Sailors used to (and sometimes still) navigate along rhumb lines since it is easier to follow a constant compass bearing than to be continually adjusting the bearing, as is needed to follow a great circle. Rhumb lines are straight lines on a Mercator Projection map (also helpful for navigation).
# 
# Rhumb lines are generally longer than great-circle (orthodrome) routes. For instance, London to New York is 4% longer along a rhumb line than along a great circle – important for aviation fuel, but not particularly to sailing vessels. New York to Beijing – close to the most extreme example possible (though not sailable!) – is 30% longer along a rhumb line.

# Distance/bearing
# 
# These formulæ give the distance and (constant) bearing between two points.

dLat = lat2-lat1
dLon = lon2-lon1

var dPhi = Math.log(Math.tan(lat2/2+Math.PI/4)/Math.tan(lat1/2+Math.PI/4));
var q = (!isNaN(dLat/dPhi)) ? dLat/dPhi : Math.cos(lat1);  // E-W line gives dPhi=0

// if dLon over 180° take shorter rhumb across 180° meridian:
if (Math.abs(dLon) > Math.PI) {
  dLon = dLon>0 ? -(2*Math.PI-dLon) : (2*Math.PI+dLon);
}
var d = Math.sqrt(dLat*dLat + q*q*dLon*dLon) * R;
var brng = Math.atan2(dLon, dPhi);

# where ln is natural log and % is modulo, Δlon is taking shortest route (<180°), and R is the earth’s radius

# Destination
# 
# Given a start point and a distance d along constant bearing θ, this will calculate the destination point. If you maintain a constant bearing along a rhumb line, you will gradually spiral in towards one of the poles.

lat2 = lat1 + d*Math.cos(brng);
var dPhi = Math.log(Math.tan(lat2/2+Math.PI/4)/Math.tan(lat1/2+Math.PI/4));
var q = (!isNaN(dLat/dPhi)) ? dLat/dPhi : Math.cos(lat1);  // E-W line gives dPhi=0

var dLon = d*Math.sin(brng)/q;
# check for some daft bugger going past the pole, normalise latitude if so
if (Math.abs(lat2) > Math.PI/2) lat2 = lat2>0 ? Math.PI-lat2 : -(Math.PI-lat2);
lon2 = (lon1+dLon+Math.PI)%(2*Math.PI) - Math.PI;                       

# Notes:
# 
#     Accuracy: since the earth is not quite a sphere, there are small errors in using spherical geometry; the earth is actually roughly ellipsoidal (or more precisely, oblate spheroidal) with a radius varying between about 6,378km (equatorial) and 6,357km (polar), and local radius of curvature varying from 6,336km (equatorial meridian) to 6,399km (polar). 6,371 km is the generally accepted value for the Earth’s mean radius. This means that errors from assuming spherical geometry might be up to 0.55% crossing the equator, though generally below 0.3%, depending on latitude and direction of travel. An accuracy of better than 3m in 1km is mostly good enough for me, but if you want greater accuracy, you could use the Vincenty formula for calculating geodesic distances on ellipsoids, which gives results accurate to within 1mm. (Out of sheer perversity – I’ve never needed such accuracy – I looked up this formula and discovered the JavaScript implementation was simpler than I expected).
#     Trig functions take arguments in radians, so latitude, longitude, and bearings in degrees (either decimal or degrees/minutes/seconds) need to be converted to radians, rad = π.deg/180. When converting radians back to degrees (deg = 180.rad/π), West is negative if using signed decimal degrees. For bearings, values in the range -π to +π [-180° to +180°] need to be converted to 0 to +2π [0°–360°]; this can be done by (brng+2.π)%2.π [or brng+360)%360] where % is the modulo operator.
#     The atan2() function widely used here takes two arguments, atan2(y, x), and computes the arc tangent of the ratio y/x. It is more flexible than atan(y/x), since it handles x=0, and it also returns values in all 4 quadrants -π to +π (the atan function returns values in the range -π/2 to +π/2).
#     All bearings are with respect to true north, 0°=N, 90°=E, etc; if you are working from a compass, magnetic north varies from true north in a complex way around the earth, and the difference has to be compensated for by variances indicated on local maps.
#     If you implement any formula involving atan2 in Microsoft Excel, you will need to reverse the arguments, as Excel has them the opposite way around from JavaScript – conventional order is atan2(y, x), but Excel uses atan2(x, y). To use atan2 in a (VBA) macro, you can use WorksheetFunction.Atan2().
#     If you are using Google Maps, several of these functions are now provided in the Google Maps API V3 ‘spherical’ library (computeDistanceBetween(), computeHeading(), computeOffset(), interpolate(), etc; note they use a default Earth radius of 6,378,137 meters).
#     I learned a lot from the US Census Bureau GIS FAQ which is no longer available, so I’ve made a copy.
#     Thanks to Ed Williams’ Aviation Formulary for many of the formulæ.
#     For miles, divide km by 1.609344
#     For nautical miles, divide km by 1.852
                                              
