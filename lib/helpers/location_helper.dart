import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyBgnLzIID3jI9Pms72dZBXtMYm-miPvdoc';
const YOUR_SIGNATURE = 'BASE64_SIGNATURE';

class LocationHelper {
  static String GenerateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=17&size=600x1000&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAdress(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?key=$GOOGLE_API_KEY&latlng=$lat,$lng');

    final response = await http.get(url);

    return (json.decode(response.body)['results'][1]['formatted_address'])
        .toString();
  }
}
