import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {

  HeaderWidget({ this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      color: Colors.black12,
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            this.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),

          ),
          Image.asset('assets/images/huawei-logo.png', width: 150, alignment: Alignment.centerRight,),
        ],
      ),

    );
  }
}