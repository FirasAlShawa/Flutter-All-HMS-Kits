import 'package:flutter/material.dart';
import 'package:hmsallkitsflutter/app/ui/widgets/header.dart';

class IapPage extends StatelessWidget {
  IapPage();

  @override
  Widget build(BuildContext context) {
    return IapPageStateful(
      title: "Huawei IAP",
    );
  }
}

class IapPageStateful extends StatefulWidget {
  IapPageStateful({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _IapPageState createState() => _IapPageState();
}

class _IapPageState extends State<IapPageStateful> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            HeaderWidget(
              title: "Huawei IAP",
            ),
            new Container(
              padding: EdgeInsets.all(20),
              child: new Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 160.0),),
                  Text("Coming Soon", style: TextStyle(fontSize: 32),)
                ],
              ),
            )
          ],
        ));
  }
}
