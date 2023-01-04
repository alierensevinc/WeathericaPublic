import 'dart:convert';
import 'package:http/http.dart' as http;
import 'geolocation.dart';

class WeatherService {
  int weatherId;
  String weatherStatus;
  String weatherIcon;
  double weatherTemp;
  String weatherLocationName;

  Future<dynamic> getWeatherData() async {
    Geolocation location = Geolocation();
    await location.getCurrentLocation();

    var url =
        'http://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&units=metric&appid=<appId>';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      weatherId = jsonResponse["weather"][0]["id"];
      weatherStatus = jsonResponse["weather"][0]["main"];
      weatherIcon = jsonResponse["weather"][0]["icon"];
      weatherIcon = weatherIcon.substring(weatherIcon.length - 1) == 'n'
          ? weatherIcon.substring(0, (weatherIcon.length - 1)) + 'd'
          : weatherIcon;
      weatherTemp = double.parse(jsonResponse["main"]["temp"].toString());
      weatherLocationName = jsonResponse["name"];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
