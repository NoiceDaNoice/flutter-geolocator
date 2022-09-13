import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //LOKASI MASTER YAITU KANTOR HASMICRO
  double masterLatitude = -6.1708013;
  double masterLongitude = 106.8133758;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  double getDistance(currentLatitude, currentLongitude) {
    var distance = _geolocatorPlatform.distanceBetween(
        masterLatitude, masterLongitude, currentLatitude, currentLongitude);
    return distance;
  }

  @override
  Widget build(BuildContext context) {
    bool attandance = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance App'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            LocationPermission permission =
                await Geolocator.requestPermission();
            var position = await _geolocatorPlatform.getCurrentPosition();
            var distance = getDistance(position.latitude,position.longitude);
            setState(() {
              (distance > 50) ? attandance = false : attandance = true;
              SnackBar snackBar = SnackBar(
                content: (attandance == false)
                    ? Text('Attandance Rejected (to far away)')
                    : Text('Attandance Accepted '),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          },
          child: Text('Attend'),
        ),
      ),
    );
  }
}
