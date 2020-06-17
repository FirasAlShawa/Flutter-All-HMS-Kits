import 'package:flutter/material.dart';
import 'package:hmsallkitsflutter/app/ui/screens/HmsGmsCheck.dart';
import 'package:hmsallkitsflutter/app/ui/screens/ads_page.dart';
import 'package:hmsallkitsflutter/app/ui/screens/analytics.dart';
import 'package:hmsallkitsflutter/app/ui/screens/home.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location/pages/activity_conversion_screen.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location/pages/activity_identification_screen.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location/pages/activity_screen.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location/pages/add_geofence_screen.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location/pages/fusedlocation_screen.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location/pages/geofence_screen.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location/pages/location_flow.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location/pages/location_updates_cb_screen.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location/pages/location_updates_ex_cb_screen.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location/pages/location_updates_screen.dart';
import 'package:hmsallkitsflutter/app/ui/screens/map.dart';
import 'package:hmsallkitsflutter/app/ui/screens/push.dart';
import 'package:hmsallkitsflutter/app/ui/screens/site.dart';

Map<String, WidgetBuilder> buildNamedRoutes() {
  Map<String, WidgetBuilder> namedRoutes = {
    '/': (BuildContext context) => HomePage(),
    '/check': (BuildContext context) => HmsGmsCheck(),
    '/maps': (BuildContext context) => HmsMaps(),
    '/site': (BuildContext context) => SitePage(),
    '/push': (BuildContext context) => PushPage(),
    '/analytics': (BuildContext context) => AnalyticsPage(),
    '/ads': (BuildContext context) => AdsPage(),
    // Location & Pages
    '/location': (BuildContext context) => LocationPage(),
    LocationFlowPage.routeName: (context) => LocationFlowPage(),
    FusedLocationScreen.routeName: (context) => FusedLocationScreen(),
    ActivityScreen.routeName: (context) => ActivityScreen(),
    GeofenceScreen.routeName: (context) => GeofenceScreen(),
    AddGeofenceScreen.routeName: (context) => AddGeofenceScreen(),
    ActivityIdentificationScreen.routeName: (context) =>
        ActivityIdentificationScreen(),
    ActivityConversionScreen.routeName: (context) => ActivityConversionScreen(),
    LocationUpdatesScreen.routeName: (context) => LocationUpdatesScreen(),
    LocationUpdatesCbScreen.routeName: (context) => LocationUpdatesCbScreen(),
    LocationUpdatesExCbScreen.routeName: (context) =>
        LocationUpdatesExCbScreen(),
  };

  return namedRoutes;
}
