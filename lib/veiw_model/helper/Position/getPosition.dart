import 'package:geolocator/geolocator.dart';

Future<Position> getPosition() async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    throw 'يجب تفعيل خدمة الموقع';
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw 'تم رفض إذن الوصول للموقع';
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw 'تم رفض إذن الموقع بشكل دائم، يرجى تفعيله من الإعدادات';
  }

  return await Geolocator.getCurrentPosition();
}
