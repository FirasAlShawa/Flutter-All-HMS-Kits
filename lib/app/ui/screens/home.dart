import 'package:flutter/material.dart';
import 'package:hmsallkitsflutter/app/ui/screens/HmsGmsCheck.dart';
import 'package:hmsallkitsflutter/app/ui/screens/ads_page.dart';
import 'package:hmsallkitsflutter/app/ui/screens/analytics.dart';
import 'package:hmsallkitsflutter/app/ui/screens/location.dart';
import 'package:hmsallkitsflutter/app/ui/screens/map.dart';
import 'package:hmsallkitsflutter/app/ui/screens/push.dart';
import 'package:hmsallkitsflutter/app/ui/screens/site.dart';
import 'package:hmsallkitsflutter/app/ui/widgets/header.dart';

class HomePage extends StatelessWidget {
  HomePage();

  @override
  Widget build(BuildContext context) {
    return HomePageStateful(
      title: "Flutter All HMS Kits",
    );
  }
}

class HomePageStateful extends StatefulWidget {
  HomePageStateful({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageStateful> {

  @override
  Widget build(BuildContext context) {

    Widget generateButton(String title, Object any) {
      return SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: new Text(
            title,
          ),
          onPressed: any == null
              ? null
              : () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return any;
                    }))
                  },
          color: Color.fromRGBO(35, 151, 239, 1),
          textColor: Color.fromRGBO(255, 255, 255, 1),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            HeaderWidget(
              title: "Flutter All HMS Kits",
            ),
            new Container(
              padding: EdgeInsets.all(20),
              child: new Column(
                children: <Widget>[
                  generateButton("HMS/GMS Check", HmsGmsCheck()),
                  generateButton("HMS Location", LocationPage()),
                  generateButton("Huawei Map", HmsMaps()),
                  generateButton("HMS Site", SitePage()),
                  generateButton("HMS Push", PushPage()),
                  generateButton("Huawei Analytics", AnalyticsPage()),
                  generateButton("Huawei Ads", AdsPage()),
                ],
              ),
            )
          ],
        ));
  }
}
