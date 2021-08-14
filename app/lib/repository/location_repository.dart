import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepository {
  Placemark? currentLocation;
  late Position _currentPosition;
  Future<Placemark?> getCurrentLocation() async {
    if (currentLocation != null) {
      return currentLocation;
    }
    try {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) {
        _currentPosition = position;
      }).catchError((e) {
        throw e;
      });
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      currentLocation = placemarks[0];
    } catch (e) {
      throw e;
    }
    return currentLocation;
  }
}
