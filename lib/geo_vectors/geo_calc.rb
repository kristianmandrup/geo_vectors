 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 #  Latitude/longitude spherical geodesy formulae & scripts (c) Chris Veness 2002-2010            
 #   - www.movable-type.co.uk/scripts/latlong.html                                                
 #                                                                                                
 #  Sample usage:                                                                                 
 #    p1 = GeoPoint.new(51.5136, -0.0983)                                                      
 #    p2 = GeoPoint.new(51.4778, -0.0015)                                                      
 #    dist = p1.distance_to(p2)          # in km                                             
 #    brng = p1.bearing_to(p2)           # in degrees clockwise from north                   
 #    ... etc                                                                                     
 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 #                                                                                                
 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 #  Note that minimal error checking is performed in this example code!                           
 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  

class GeoCalc
  # Creates a point on the earth's surface at the supplied latitude / longitude
  # 
  # Constructor
  # - Numeric lat: latitude in numeric degrees
  # - Numeric lon: longitude in numeric degrees
  # - Numeric [rad=6371]: radius of earth if different value is required from standard 6,371km

  def initializer lat, lon, rad
    rad ||= 6371  # earth's mean radius in km
    # only accept numbers or valid numeric strings
    @lat    = lat
    @lon    = lon
    @radius = rad
  end

  
  # Returns the distance from this point to the supplied point, in km 
  # (using Haversine formula)
  # 
  # from: Haversine formula - R. W. Sinnott, "Virtues of the Haversine",
  #       Sky and Telescope, vol 68, no 2, 1984
  # 
  # GeoPoint point: Latitude/longitude of destination point
  # - Numeric precision=4: number of significant digits to use for returned value
  #
  # Returns - Numeric distance in km between this point and destination point
  
  def distance_to point, precision
    # default 4 sig figs reflects typical 0.3% accuracy of spherical model
    precision ||= 4

    R = radius
    lat1 = lat.to_rad
    lon1 = lon.to_rad

    lat2 = point.lat.to_rad
    lon2 = point.lon.to_rad

    dlat = lat2 - lat1
    dlon = lon2 - lon1

    a = Math.sin(dlat/2) * Math.sin(dlat/2) + Math.cos(lat1) * Math.cos(lat2) * Math.sin(dlon/2) * Math.sin(dlon/2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    d = R * c
    d.to_precision_fixed(precision)
  end
  
  
  # Returns the (initial) bearing from this point to the supplied point, in degrees
  #   see http:#williams.best.vwh.net/avform.htm#Crs
  # 
  # - Point point: Latitude/longitude of destination point
  # 
  # Returns -  Numeric: Initial bearing in degrees from North
  
  def bearing_to point
    lat1 = lat.to_rad
    lat2 = point.lat.to_rad
    dlon = (point.lon - lon).to_rad

    y = Math.sin(dlon) * Math.cos(lat2)
    x = Math.cos(lat1) * Math.sin(lat2) - Math.sin(lat1) * Math.cos(lat2) * Math.cos(dlon)
    bearing = Math.atan2(y, x)

    (bearing.to_deg + 360) % 360
  end
  
  
  # Returns final bearing arriving at supplied destination point from this point; the final bearing 
  # will differ from the initial bearing by varying degrees according to distance and latitude
  # 
  # - GeoPoint point: Latitude/longitude of destination point
  #
  # Returns Numeric: Final bearing in degrees from North
  
  def final_bearing_to point
    # get initial bearing from supplied point back to this point...
    lat1 = point.lat.to_rad
    lat2 = lat.to_rad
    dlon = (lon - point.lon).to_rad

    y = Math.sin(dLon) * Math.cos(lat2)
    x = Math.cos(lat1)*Math.sin(lat2) - Math.sin(lat1)*Math.cos(lat2)*Math.cos(dlon)
    bearing = Math.atan2(y, x)

    # ... & reverse it by adding 180°
    (bearing.to_deg+180) % 360
  end
  
  
  # Returns the midpoint between this point and the supplied point.
  #   see http:#mathforum.org/library/drmath/view/51822.html for derivation
  # 
  # - GeoPoint point: Latitude/longitude of destination point
  # Returns GeoPoint: Midpoint between this point and the supplied point
  
  def midpoint_to point
    lat1 = lat.to_rad
    lon1 = lon.to_rad;
    lat2 = point.lat.to_rad
    dlon = (point.lon - lon).to_rad

    bx = Math.cos(lat2) * Math.cos(dlon)
    by = Math.cos(lat2) * Math.sin(dlon)

    lat3 = Math.atan2(Math.sin(lat1)+Math.sin(lat2), Math.sqrt( (Math.cos(lat1)+Bx)*(Math.cos(lat1)+Bx) + By*By) )

    lon3 = lon1 + Math.atan2(by, Math.cos(lat1) + bx)

    GeoPoint.new lat3.to_deg, lon3.to_deg
  end
  
  
  # Returns the destination point from this point having travelled the given distance (in km) on the 
  # given initial bearing (bearing may vary before destination is reached)
  # 
  #   see http:#williams.best.vwh.net/avform.htm#LL
  # 
  # - Numeric bearing: Initial bearing in degrees
  # - Numeric dist: Distance in km
  # Returns GeoPoint: Destination point
  
  def destination_point bearing, dist
    dist = dist / radius  # convert dist to angular distance in radians
    bearing = bearing.to_rad 
    lat1 = this.lat.to_rad
    lon1 = this.lon.to_rad

    lat2 = Math.asin( Math.sin(lat1)*Math.cos(dist) + Math.cos(lat1)*Math.sin(dist)*Math.cos(bearing) )
    var lon2 = lon1 + Math.atan2(Math.sin(brng)*Math.sin(dist)*Math.cos(lat1), Math.cos(dist)-Math.sin(lat1)*Math.sin(lat2))

    lon2 = (lon2+3*Math.PI)%(2*Math.PI) - Math.PI  # normalise to -180...+180

    GeoPoint.new lat2.toDeg(), lon2.toDeg()
  end

  
  # Returns the point of intersection of two paths defined by point and bearing
  # 
  #   see http:#williams.best.vwh.net/avform.htm#Intersection
  # 
  # @param   {LatLon} p1: First point
  # @param   {Number} brng1: Initial bearing from first point
  # @param   {LatLon} p2: Second point
  # @param   {Number} brng2: Initial bearing from second point
  # @returns {LatLon} Destination point (null if no unique intersection defined)
  
  def intersection p1, brng1, p2, brng2
    lat1 = p1.lat.to_rad
    lon1 = p1.lon.to_rad

    lat2 = p2.lat.to_rad
    lon2 = p2.lon.to_rad

    brng13 = brng1.to_rad
    brng23 = brng2.to_rad
    dlat = lat2-lat1
    dlon = lon2-lon1;

    dist12 = 2*Math.asin( Math.sqrt( Math.sin(dlat/2)*Math.sin(dlat/2) + Math.cos(lat1)*Math.cos(lat2)*Math.sin(dlon/2)*Math.sin(dlon/2) ) )
    return nil if dist12 == 0

    # initial/final bearings between points
    brng_a = begin
      Math.acos( ( Math.sin(lat2) - Math.sin(lat1)*Math.cos(dist12) ) / ( Math.sin(dist12)*Math.cos(lat1) ) )
    rescue # protect against rounding
      0
    end
    
    brng_b = Math.acos( ( Math.sin(lat1) - Math.sin(lat2)*Math.cos(dist12) ) / ( Math.sin(dist12)*Math.cos(lat2) ) )

    brng12, brng21 = if Math.sin(lon2-lon1) > 0
      [brng_a, 2*Math.PI - brng_b] 
    else
      [2*Math.PI - brng_a, brng_b]
    end

    alpha1 = (brng13 - brng12 + Math.PI) % (2*Math.PI) - Math.PI  # angle 2-1-3
    alpha2 = (brng21 - brng23 + Math.PI) % (2*Math.PI) - Math.PI  # angle 1-2-3

    return nil if (Math.sin(alpha1)==0 && Math.sin(alpha2)==0) # infinite intersections
    return nil if (Math.sin(alpha1)*Math.sin(alpha2) < 0)    # ambiguous intersection

    # alpha1 = Math.abs(alpha1);
    # alpha2 = Math.abs(alpha2);
    # ... Ed Williams takes abs of alpha1/alpha2, but seems to break calculation?

    alpha3 = Math.acos( -Math.cos(alpha1)*Math.cos(alpha2) + Math.sin(alpha1)*Math.sin(alpha2)*Math.cos(dist12) )

    dist13 = Math.atan2( Math.sin(dist12)*Math.sin(alpha1)*Math.sin(alpha2), Math.cos(alpha2)+Math.cos(alpha1)*Math.cos(alpha3) )

    lat3 = Math.asin( Math.sin(lat1)*Math.cos(dist13) + Math.cos(lat1)*Math.sin(dist13)*Math.cos(brng13) )

    dlon13 = Math.atan2( Math.sin(brng13)*Math.sin(dist13)*Math.cos(lat1), Math.cos(dist13)-Math.sin(lat1)*Math.sin(lat3) )

    lon3 = lon1+dlon13;
    lon3 = (lon3+Math.PI) % (2*Math.PI) - Math.PI  # normalise to -180..180º

    GeoPoint.new lat3.to_deg, lon3.to_deg
  end
    

  # Returns the distance from this point to the supplied point, in km, travelling along a rhumb line
  # 
  #   see http:#williams.best.vwh.net/avform.htm#Rhumb
  # 
  # - GeoPoint point: Latitude/longitude of destination point
  # Returns Numeric: Distance in km between this point and destination point
  
  def rhumb_distance_to point
    R = this.radius
    lat1 = lat.to_rad
    lat2 = point.lat.to_rad

    dlat = (point.lat-lat).to_rad
    dlon = Math.abs(point.lon-lon).to_rad

    var dphi = Math.log(Math.tan(lat2/2+Math.PI/4)/Math.tan(lat1/2+Math.PI/4))

    q = begin
      dLat/dPhi
    rescue 
      Math.cos(lat1) # E-W line gives dPhi=0
    end
    # if dlon over 180° take shorter rhumb across 180° meridian:
    dlon = 2*Math.PI - dlon if (dlon > Math.PI)

    dist = Math.sqrt(dlat*dlat + q*q*dlon*dlon) * R; 

    dist.to_precision_fixed(4)  # 4 sig figures reflects typical 0.3% accuracy of spherical model
  end
  
  
  # Returns the bearing from this point to the supplied point along a rhumb line, in degrees
  # 
  # - GeoPoint point: Latitude/longitude of destination point
  # Returns Numeric: Bearing in degrees from North
  
  def rhumb_bearing_to point
    lat1 = lat.to_rad
    lat2 = point.lat.to_rad

    dlon = (point.lon - lon).to_rad

    dphi = Math.log(Math.tan(lat2/2+Math.PI/4) / Math.tan(lat1/2+Math.PI/4))
    if (Math.abs(dlon) > Math.PI) 
      dlon = dlon>0 ? -(2*Math.PI-dlon) : (2*Math.PI+dlon);
    end

    brng = Math.atan2(dlon, dphi);

    brng.to_deg+360) % 360
  end

  
  # Returns the destination point from this point having travelled the given distance (in km) on the 
  # given bearing along a rhumb line
  # 
  # @param   {Number} brng: Bearing in degrees from North
  # @param   {Number} dist: Distance in km
  # @returns {LatLon} Destination point
  
  def rhumb_destination_point brng, dist
    R = radius
    d = dist / R  # d = angular distance covered on earth's surface
    lat1 = lat.to_rad
    lon1 = lon.to_rad
    brng = brng.to_rad

    lat2 = lat1 + d*Math.cos(brng);
    dlat = lat2-lat1;
    dphi = Math.log(Math.tan(lat2/2+Math.PI/4)/Math.tan(lat1/2+Math.PI/4))

    q = begin
      dLat/dPhi
    rescue 
      Math.cos(lat1) # E-W line gives dPhi=0
    end

    var dlon = d*Math.sin(brng)/q
    # check for some daft bugger going past the pole

    if (Math.abs(lat2) > Math.PI/2) 
      lat2 = lat2>0 ? Math.PI-lat2 : -(Math.PI-lat2)
    end
    lon2 = (lon1+dlon+3*Math.PI)%(2*Math.PI) - Math.PI

    GeoPoint.new lat2.to_deg, lon2.to_deg
  end

  
  # Returns the latitude of this point; signed numeric degrees if no format, otherwise format & dp 
  # as per Geo.to_lat
  # 
  # - String [format]: Return value as 'd', 'dm', 'dms'
  # - Numeric [dp=0|2|4]: No of decimal places to display
  #
  # Returns {Numeric|String}: Numeric degrees if no format specified, otherwise deg/min/sec
  # 
  
  def lat format, dp
    return lat if !format
    Geo.to_lat lat, format, dp
  end

  
  # Returns the longitude of this point; signed numeric degrees if no format, otherwise format & dp 
  # as per Geo.toLon()
  # 
  # @param   {String} [format]: Return value as 'd', 'dm', 'dms'
  # @param   {Number} [dp=0|2|4]: No of decimal places to display
  # @returns {Number|String} Numeric degrees if no format specified, otherwise deg/min/sec
  # 
  # @requires Geo
  
  def lon format, dp
    return lon if !format
    Geo.to_lon lon, format, dp
  end

  
  # Returns a string representation of this point; format and dp as per lat()/lon()
  # 
  # @param   {String} [format]: Return value as 'd', 'dm', 'dms'
  # @param   {Number} [dp=0|2|4]: No of decimal places to display
  # @returns {String} Comma-separated latitude/longitude
  # 
  # @requires Geo
  
  def to_s dp, format = :dps
    format ||= 'dms'

    return '-,-' if !lat || !lon

    _lat = Geo.to_lat lat, format, dp
    _lon = Geo.to_lon lon, format, dp

    "#{_lat}, #{_lon}"
  end
end

module NumericGeoExt
  # Converts numeric degrees to radians
  def to_rad
      self * Math.PI / 180
  end

  # Converts radians to numeric (signed) degrees
  # latitude (north to south) from equator +90 up then -90 down (equator again) = 180 then 180 for south = 360 total 
  # longitude (west to east)  east +180, west -180 = 360 total
  def to_deg
    self * 180 / Math.PI
  end
   
  # Formats the significant digits of a number, using only fixed-point notation (no exponential)
  # 
  # @param   {Number} precision: Number of significant digits to appear in the returned string
  # @returns {String} A string representation of number which contains precision significant digits
  def to_precision_fixed precision
    numb = Math.abs(self)  # can't take log of -ve number...
    sign = self < 0 ? '-' : '';

    # can't take log of zero
    if (numb == 0) 
      n = '0.'
      while precision-- { n += '0'}
      n
    end

    scale = Math.ceil(Math.log(numb)*Math.LOG10E);  # no of digits before decimal
    n = (Math.round(numb * Math.pow(10, precision-scale))).to_s
    if (scale > 0)   # add trailing zeros & insert decimal as required
      l = scale - n.length;
      while (l-- > 0) { n = n + '0' }
      if (scale < n.length) 
        n = n.slice(0,scale) + '.' + n.slice(scale)
      else # prefix decimal and leading zeros if required
        while (scale++ < 0) { n = '0' + n }
        n = '0.' + n;
      end 
    end
    sign + n
  end
end            

class Fixnum
  include NumericGeoExt
end

class Float
  include NumericGeoExt
end
  
 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 #  Geodesy representation conversion functions (c) Chris Veness 2002-2010
 #   - www.movable-type.co.uk/scripts/latlong.html
 #
 #  Sample usage:
 #    lat = Geo.parseDMS('51° 28′ 40.12″ N')
 #    lon = Geo.parseDMS('000° 00′ 05.31″ W')
 #    p1 = new LatLon(lat, lon)
 # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  


# Parses string representing degrees/minutes/seconds into numeric degrees
# 
# This is very flexible on formats, allowing signed decimal degrees, or deg-min-sec optionally
# suffixed by compass direction (NSEW). A variety of separators are accepted (eg 3º 37' 09"W) 
# or fixed-width format without separators (eg 0033709W). Seconds and minutes may be omitted. 
# (Note minimal validation is done).
# 
# @param   {String|Number} dmsStr: Degrees or deg/min/sec in variety of formats
# @returns {Number} Degrees as decimal number
# @throws  {TypeError} dmsStr is an object, perhaps DOM object without .value?

module Geo
  extend self
  
  def parse_dms dms_str  
    # check for signed decimal degrees without NSEW, if so return it directly
    return dms_str if isNumeric?(dms_str)
  
    # strip off any sign or compass dir'n & split out separate d/m/s
    dms = dms_str.trim.replace(/^-/,'').replace(/[NSEW]$/i,'').split(/[^0-9.,]+/).trim  
    return nil if dms.empty?
  
    # and convert to decimal degrees...
    deg = case dms.length
      case 3: # interpret 3-part result as d/m/s
         dms[0]/1 + dms[1]/60 + dms[2]/3600;
      case 2:  # interpret 2-part result as d/m
        dms[0]/1 + dms[1]/60
      case 1:  # just d (possibly decimal) or non-separated dddmmss
        d = dms[0];
        # check for fixed-width unseparated format eg 0033709W
        d = "0#{d}" if (/[NS]/i.match(dms_str)) # - normalise N/S to 3-digit degrees
        d = "#{d.slice(0,3)/1}#{deg.slice(3,5)/60}#{deg.slice(5)/3600}" if (/[0-9]{7}/.match(deg)) 
        d
      else
        nil
      end
    end
    deg = -deg if (/^-|[WS]$/i.match(dms_str.trim)) # take '-', west and south as -ve
    deg.to_f
  end


  # Convert decimal degrees to deg/min/sec format
  #  - degree, prime, double-prime symbols are added, but sign is discarded, though no compass
  #    direction is added
  # 
  # @private
  # @param   {Number} deg: Degrees
  # @param   {String} [format=dms]: Return value as 'd', 'dm', 'dms'
  # @param   {Number} [dp=0|2|4]: No of decimal places to use - default 0 for dms, 2 for dm, 4 for d
  # @returns {String} deg formatted as deg/min/secs according to specified format
  # @throws  {TypeError} deg is an object, perhaps DOM object without .value?

  def to_dms deg, dp, format = :dms  
    deg = begin
      deg.to_f
    rescue
      nil
    end
    return nil if !deg # give up here if we can't make a number from deg   
  
    # default values
    format ||= :dms
    dp = if dp.nil?
      case format.to_sym
      when :d 
        4
      when :dm 
        2
      when 'dms'
        0
      else
        0  # be forgiving on invalid format
      end
    end
  
    deg = Math.abs(deg);  # (unsigned result ready for appending compass dir'n)
  
    case format
    when :d
      d = deg.toFixed(dp)     # round degrees
      if (d<100) d = '0' + d  # pad with leading zeros
      if (d<10) d = '0' + d
      dms = d + '\u00B0'      # add º symbol
    when :dm
      min = (deg*60).to_fixed(dp)  # convert degrees to minutes & round
      d = Math.floor(min / 60)    # get component deg/min
      m = (min % 60).to_fixed(dp)  # pad with trailing zeros
      if (d<100) d = '0' + d          # pad with leading zeros
      if (d<10) d = '0' + d
      if (m<10) m = '0' + m
      dms = d + '\u00B0' + m + '\u2032'  # add º, ' symbols
    when :dms
      sec = (deg*3600).to_fixed(dp)  # convert degrees to seconds & round
      d = Math.floor(sec / 3600)    # get component deg/min/sec
      m = Math.floor(sec/60) % 60
      s = (sec % 60).toFixed(dp)    # pad with trailing zeros
      if (d<100) d = '0' + d            # pad with leading zeros
      if (d<10) d = '0' + d
      if (m<10) m = '0' + m
      if (s<10) s = '0' + s
      dms = d + '\u00B0' + m + '\u2032' + s + '\u2033'  # add º, ', " symbols
    end
  
    return dms
  end


  # Convert numeric degrees to deg/min/sec latitude (suffixed with N/S)
  # 
  # @param   {Number} deg: Degrees
  # @param   {String} [format=dms]: Return value as 'd', 'dm', 'dms'
  # @param   {Number} [dp=0|2|4]: No of decimal places to use - default 0 for dms, 2 for dm, 4 for d
  # @returns {String} Deg/min/seconds

  def to_lat deg, format, dp
    lat = to_dms deg, format, dp
    lat == '' ? '' : lat.slice(1) + (deg<0 ? 'S' : 'N')  # knock off initial '0' for lat!
  end


  # Convert numeric degrees to deg/min/sec longitude (suffixed with E/W)
  # 
  # @param   {Number} deg: Degrees
  # @param   {String} [format=dms]: Return value as 'd', 'dm', 'dms'
  # @param   {Number} [dp=0|2|4]: No of decimal places to use - default 0 for dms, 2 for dm, 4 for d
  # @returns {String} Deg/min/seconds

  def to_lon deg, format, dp) {
    lon = to_dms deg, format, dp
    lon == '' ? '' : lon + (deg<0 ? 'W' : 'E')
  end


  # Convert numeric degrees to deg/min/sec as a bearing (0º..360º)
  # 
  # @param   {Number} deg: Degrees
  # @param   {String} [format=dms]: Return value as 'd', 'dm', 'dms'
  # @param   {Number} [dp=0|2|4]: No of decimal places to use - default 0 for dms, 2 for dm, 4 for d
  # @returns {String} Deg/min/seconds

  def to_brng deg, format, dp
    deg = (deg.to_f + 360) % 360  # normalise -ve values to 180º..360º
    brng =  to_dms deg, format, dp
    brng.replace /360/, '0'  # just in case rounding took us up to 360º!
  end
end