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

  @override
  void initState() {
    checkHmsGms();
  }

  void checkHmsGms() async {
    await _isHMS();
    await _isGMS();
  }

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

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "HMS Available:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        "$_isHmsAvailable",
                        style: TextStyle(
                            fontSize: 18,
                            color: _isHmsAvailable ? Colors.green : Colors.red),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "GMS Available:",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        "$_isGmsAvailable",
                        style: TextStyle(
                            fontSize: 18,
                            color: _isGmsAvailable ? Colors.green : Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
