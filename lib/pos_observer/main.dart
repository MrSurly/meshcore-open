

import '../connector/meshcore_connector.dart';

// ignore_for_file: avoid_print

final Duration updateFreqSecs = Duration(seconds: 60);

void positionListener(MeshCoreConnector connector) {
  double? lastLat;
  double? lastLon;


  Stopwatch? elapsed;


  connector.addListener(() {
    // connector is captured here
    final lat = connector.selfLatitude;
    final lon = connector.selfLongitude;
    final locChanged = (lastLat != lat) || (lastLon != lon);
    final timerNull = elapsed == null;
    final timerExpired = elapsed != null ? elapsed!.elapsed > updateFreqSecs : false;


    if( locChanged || timerNull || timerExpired) {

      if (locChanged) {
        print ("Location changed");
      } else if (timerNull) {
        print ("First run");
      } else if (timerExpired) {
        print ("Timer Expired");
      }

      elapsed ??= Stopwatch()..start();
      elapsed!.reset();
      
      lastLat = lat;
      lastLon = lon;
      print('lat: $lat, lon: $lon');

    }
    
  });
}