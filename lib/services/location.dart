import 'package:geolocator/geolocator.dart';

class Location{
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation()async{
    try {
      if (Geolocator.checkPermission() != 'denied') {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);

        latitude = position.latitude;
        longitude = position.longitude;
      } else {
        Geolocator.requestPermission();
      }
    } catch (e) {
      print(e);
    }
  }
}