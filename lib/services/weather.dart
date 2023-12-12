
import 'location.dart';
import 'network.dart';

const apiKey = '5a18fc6e52dc7342ee016a20e95a106c';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {

    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric";

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getLocation();

    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${location
        .latitude}&lon=${location.longitude}&appid=$apiKey&units=metric";

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}