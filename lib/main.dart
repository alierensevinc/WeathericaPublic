import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'network.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final now = new DateTime.now();
  WeatherService weatherService = WeatherService();
  Color color1 = Color(0xFF668CFF);
  Color color2 = Color(0xFF0E33FF);

  Future<void> asyncMethod() async {
    await weatherService.getWeatherData();
    setBackgroundColor();
  }

  void setBackgroundColor() {
    if (weatherService.weatherId < 600) {
      color1 = Color(0xFF39415A);
      color2 = Color(0xFF111F62);
    } else if (weatherService.weatherId < 800) {
      color1 = Color(0xFFD8DADE);
      color2 = Color(0xFFAEB1B8);
    } else if (weatherService.weatherId == 800) {
      color1 = Color(0xFF668CFF);
      color2 = Color(0xFF0E33FF);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: asyncMethod(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Weatherica'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color1,
                    color2,
                  ],
                ),
              ),
            ),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color1,
                          color2,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40.0,
                          ),
                          child: Text(
                            weatherService.weatherLocationName == null
                                ? ''
                                : weatherService.weatherLocationName,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        weatherService.weatherIcon == null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 120.0),
                                child: SpinKitFadingCircle(
                                  color: Colors.white,
                                  size: 60.0,
                                  controller: AnimationController(
                                    vsync: this,
                                    duration:
                                        const Duration(milliseconds: 4000),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 0,
                                height: 0,
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Image.network(weatherService.weatherIcon ==
                                  null
                              ? ''
                              : "http://openweathermap.org/img/wn/${weatherService.weatherIcon}@4x.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            weatherService.weatherStatus == null
                                ? ''
                                : weatherService.weatherStatus,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            weatherService.weatherLocationName == null
                                ? ''
                                : '${now.year.toString()} - ${now.month.toString()} - ${now.day.toString()}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 40),
                          child: Text(
                            weatherService.weatherTemp == null
                                ? ''
                                : '${weatherService.weatherTemp.toStringAsFixed(1)} °C',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
