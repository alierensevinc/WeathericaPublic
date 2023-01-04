import 'package:geolocator/geolocator.dart';

class Geolocation {
  double lat;
  double long;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      lat = position.latitude;
      long = position.longitude;
    } on Exception catch (e) {
      print('getCurrentPosition failed : $e');
      return null;
    }
  }
}
