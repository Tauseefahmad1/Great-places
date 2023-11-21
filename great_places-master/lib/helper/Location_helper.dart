import 'dart:convert';
import 'package:http/http.dart' as http;

const Google_Api_Key = "AIzaSyDK6wQdcvMu8-wYWr4RJS5Mp6siBOUyaV8";

class LocationHelper {
  static String genrateLocationPreviewImage(
      {required double latitude, required double longnitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longnitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longnitude&key=$Google_Api_Key';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final Url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$Google_Api_Key';
    final response = await http.get(Uri.parse(Url));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
