import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hmsallkitsflutter/app/ui/widgets/header.dart';
import 'package:huawei_location/location/fused_location_provider_client.dart';
import 'package:huawei_location/location/location.dart';
import 'package:huawei_location/location/location_callback.dart';
import 'package:huawei_location/location/location_request.dart';
import 'package:huawei_location/location/location_settings_request.dart';
import 'package:huawei_location/location/location_settings_states.dart';
import 'package:huawei_location/permission/permission_handler.dart';

//void main() {
//  runApp(MyApp());
//}
//
class LocationPage extends StatelessWidget {
  LocationPage();
  @override
  Widget build(BuildContext context) {
    return LocationPageStateful(title: "HMS Location Kit",);
  }
}

class LocationPageStateful extends StatefulWidget {
  LocationPageStateful({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPageStateful> {
  bool _hasLocationPermission;
  bool _locationRequestPermission;
  bool _lastLocation;
  Location _userLocation;

  PermissionHandler permissionHandler = PermissionHandler();
  FusedLocationProviderClient locationService = FusedLocationProviderClient();
  LocationRequest locationRequest = LocationRequest();
  LocationSettingsRequest locationSettingsRequest;

  LocationSettingsStates _locationSettingsStates;

  void _checkLocationSetting() async {
    print("Check Location Setting");
    locationSettingsRequest = LocationSettingsRequest(
      requests: <LocationRequest>[locationRequest],
      needBle: true,
      alwaysShow: true,
    );
    try {
      LocationSettingsStates states =
      await locationService.checkLocationSettings(locationSettingsRequest);
      print("LocationSettingsStates: "+ states.toString());
      if (states != null) {
        setState(() {
          _locationSettingsStates = states;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _checkLocationPermission() async {
    print("Check Location permission");
    bool hasLocationPermission =
    await permissionHandler.hasLocationPermission();
//    _hasLocationPermission = hasLocationPermission;
    setState(() {
      _hasLocationPermission = hasLocationPermission;
    });
  }

  void _requestHMSLocationPermission() async {
    bool status = false;
    try {
      status = await permissionHandler.requestLocationPermission();
      // status is true if permissions are granted, false otherwise
//      _locationRequestPermission = status;
      setState(() {
        _locationRequestPermission = status;
        _checkLocationPermission();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _getLastLocation() async {
    try {
      Location location = await locationService.getLastLocation();
      if (location != null) {
        setState(() {
          _userLocation = location;
          _lastLocation = true;
        });
      } else {
        setState(() {
          _userLocation = null;
          _lastLocation = false;
        });
      }
    } catch (e) {
      print(e.toString());
      setState(() {
        _userLocation = null;
        _lastLocation = false;
      });
    }
  }

  void _getLocationUpdate() async {
    int requestCode;
    try {
      requestCode =
      await locationService.requestLocationUpdates(locationRequest);
    } catch (e) {
      print(e.toString());
    }

    StreamSubscription<Location> streamSubs =
    locationService.onLocationData.listen((location) {
      setState(() {
        _userLocation = location;
      });
      return;
    });
    streamSubs.onDone(() {
      removeLocationUpdates(requestCode, streamSubs);
    });
  }

  void removeLocationUpdates(
      int requestCode, StreamSubscription streamSubs) async {
    try {
      await locationService.removeLocationUpdates(requestCode);
    } catch (e) {
      print(e.toString());
    }
    streamSubs.cancel();
  }

  void _getLocationUpdateCallBack() async{
    LocationCallback locationCallback = LocationCallback(
      onLocationResult: (locationResult) {
        print("locationResult: "+ locationResult.toString());
        setState(() {
          _userLocation = locationResult.locations[0];
        });
      },
      onLocationAvailability: (locationAvailability) {
        print("locationAvailability: " + locationAvailability.toString());
      },
    );

    int callbackId;
    try {
      callbackId = await locationService.requestLocationUpdatesCb(locationRequest, locationCallback);
    } catch (e) {
      print(e.toString());
    }
//    removeLocationUpdateCallback(callbackId);
  }

  void removeLocationUpdateCallback(int callbackId) async{
    try {
      await locationService.removeLocationUpdates(callbackId);
    } catch (e) {
      print(e.toString());
    }
  }

  Widget getPermissionWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Location Permission is must required!',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: new Text(
              "Request Location Permission",
            ),
            onPressed: () => {_requestHMSLocationPermission()},
            color: Color.fromRGBO(35, 151, 239, 1),
            textColor: Color.fromRGBO(255, 255, 255, 1),
          ),
          Image.asset('assets/images/location_animation.gif', height: 350,),
        ],
      ),
    );
  }

  Widget getLoadingLocationWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Fetching Location ...',
            style: Theme.of(context).textTheme.headline4,
          ),
          Image.asset('assets/images/location_animation.gif', height: 350,),

        ],
      ),
    );
  }

  Widget getLocationWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Location Data has been received',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          Text(
            "My Location: "+_userLocation.toJson(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("_hasLocationPermission:" + _hasLocationPermission.toString());
    print(
        "_locationRequestPermission:" + _locationRequestPermission.toString());
    print("_locationSettingsStates:" + _locationSettingsStates.toString());
    print("_lastLocation:" + _lastLocation.toString());
    print("_userLocation:" + _userLocation.toString());

    if (_hasLocationPermission == null) {
      _checkLocationPermission();
    } else if (_hasLocationPermission == false &&
        _locationRequestPermission == null) {
      _requestHMSLocationPermission();
    } else if (_hasLocationPermission == true &&
        (_locationRequestPermission == true || _locationRequestPermission == null) &&
        _locationSettingsStates == null) {
      _checkLocationSetting();
    } else if (_hasLocationPermission == true ) {
      if (_userLocation == null && _lastLocation == null) {
        _getLastLocation();
      } else if (_userLocation == null && _lastLocation == false) {
        print("please request location update to fetch location data");
        _getLocationUpdate();
//        _getLocationUpdateCallBack();
      }
    }

    Widget appWidget = getPermissionWidget();

    if (_hasLocationPermission == true && _userLocation == null) {
      appWidget = getLoadingLocationWidget();
    } else if (_hasLocationPermission == true && _userLocation != null) {
      appWidget = getLocationWidget();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
        body: Column(
          children: <Widget>[
            HeaderWidget(
              title: "HMS Location Kit",
            ),
            new Container(
              padding: EdgeInsets.all(20),
              child: new Column(
                children: <Widget>[
                  appWidget
                ],
              ),
            )
          ],
        )
    );
  }
}
