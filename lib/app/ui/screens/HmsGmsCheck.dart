import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hmsallkitsflutter/app/ui/widgets/header.dart';

class HmsGmsCheck extends StatelessWidget {
  HmsGmsCheck();

  @override
  Widget build(BuildContext context) {
    return HmsGmsCheckStateful(
      title: "HMS/GMS Check",
    );
  }
}

class HmsGmsCheckStateful extends StatefulWidget {
  HmsGmsCheckStateful({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HmsGmsCheckState createState() => _HmsGmsCheckState();
}

class _HmsGmsCheckState extends State<HmsGmsCheckStateful> {
  static const MethodChannel methodChannel =
      MethodChannel('com.salman.flutter.hmsallkitsflutter/isHmsGmsAvailable');
  bool _isHmsAvailable;
  bool _isGmsAvailable;

  bool _isHmsLoad = false;
  bool _isGmsLoad = false;

  Future<void> _isHMS() async {
    bool status;

    try {
      bool result = await methodChannel.invokeMethod('isHmsAvailable');
      status = result;
      print('status : ${status.toString()}');
    } on PlatformException {
      print('Failed to get _isHmsAvailable.');
    }

    setState(() {
      _isHmsAvailable = status;
    });
  }

  Future<void> _isGMS() async {
    bool status;

    try {
      bool result = await methodChannel.invokeMethod('isGmsAvailable');
      status = result;
      print('status : ${status.toString()}');
    } on PlatformException {
      print('Failed to get _isGmsAvailable.');
    }

    setState(() {
      _isGmsAvailable = status;
    });
  }

  void checkHmsGms() async {
    if (!_isHmsLoad) {
      await _isHMS();
      setState(() {
        _isHmsLoad = true;
      });
    }
    if (!_isGmsLoad) {
      await _isGMS();
      setState(() {
        _isGmsLoad = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkHmsGms();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            HeaderWidget(
              title: "HMS/GMS Availability",
            ),
            new Container(
              padding: EdgeInsets.all(20),
              child: new Column(
                children: <Widget>[
                  Text(
                    "HMS Available: $_isHmsAvailable",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    "GMS Available: $_isGmsAvailable",
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
