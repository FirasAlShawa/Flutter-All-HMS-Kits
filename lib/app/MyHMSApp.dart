import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:hmsallkitsflutter/app/routes/route_manager.dart';

class MyHMSApp extends StatefulWidget {
  @override
  _MyHMSAppState createState() => _MyHMSAppState();
}

class _MyHMSAppState extends State<MyHMSApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter All HMS Kits',
      theme: ThemeData(
          primaryColor: Color(0xFF14568C), brightness: Brightness.light),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: buildNamedRoutes(),
    );
  }
}