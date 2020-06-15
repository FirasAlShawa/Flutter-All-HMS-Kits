import 'package:flutter/material.dart';
import 'package:hmsallkitsflutter/app/ui/screens/HmsGmsCheck.dart';
import 'package:hmsallkitsflutter/app/ui/screens/home.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location.dart';

Map<String, WidgetBuilder> buildNamedRoutes() {
  Map<String, WidgetBuilder> namedRoutes = {
    '/': (BuildContext context) => HomePage(),
    '/location': (BuildContext context) => LocationPage(),
    '/check': (BuildContext context) => HmsGmsCheck(),

  };

  return namedRoutes;
}