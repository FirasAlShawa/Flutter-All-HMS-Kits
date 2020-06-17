/*
Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hmsallkitsflutter/app/ui/widgets/header.dart';
import 'package:huawei_analytics/analytics.dart';


class MyBtn extends StatelessWidget {
  final String title;
  final Function _onPress;

  MyBtn(this.title, this._onPress);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 3, 3, 3),
        color: Colors.white,
        child: RaisedButton(
            color: Colors.blue,
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            onPressed: () async {
              _onPress(context);
            }));
  }
}

class AnalyticsPage extends StatelessWidget {
  final String _appTitle = 'Huawei Analytics';
  final HMSAnalytics hmsAnalytics = new HMSAnalytics();

  void _showDialog(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text("Result"),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<void> _onEnableLog(BuildContext context) async {
    await hmsAnalytics.enableLog();
    _showDialog(context, "enableLog success");
  }

  Future<void> _onEnableLogWithLevel(BuildContext context) async {
    //Possible options DEBUG, INFO, WARN, ERROR
    await hmsAnalytics.enableLogWithLevel("DEBUG");
    _showDialog(context, "enableLogWithLevel success");
  }

  Future<void> _setUserId(BuildContext context) async {
    await hmsAnalytics.setUserId("userId");
    _showDialog(context, "setUserId success");
  }

  Future<void> _setUserProfile(BuildContext context) async {
    await hmsAnalytics.setUserProfile("key", "value");
    _showDialog(context, "setUserProfile success");
  }

  Future<void> _setPushToken(BuildContext context) async {
    await hmsAnalytics.setPushToken("token");
    _showDialog(context, "setPushToken success");
  }

  Future<void> _setMinActivitySessions(BuildContext context) async {
    await hmsAnalytics.setMinActivitySessions(1000);
    _showDialog(context, "setMinActivitySessions success");
  }

  Future<void> _setSessionDuration(BuildContext context) async {
    await hmsAnalytics.setSessionDuration(1000);
    _showDialog(context, "setSessionDuration success");
  }

  Future<void> _onCustomEvent(BuildContext context) async {
    String name = "event_name";
    dynamic value = {'my_event_key': 'my_event_value'};

    await hmsAnalytics.onEvent(
        name, value);
    _showDialog(context, "onEvent success");
  }

  Future<void> _onPredefinedEvent(BuildContext context) async {
    String name = HAEventType.SUBMITSCORE;
    dynamic value = {
      HAParamType.SCORE : 12
    };

    await hmsAnalytics.onEvent(name, value);
    _showDialog(context, "onEvent success");
  }

  Future<void> _clearCachedData(BuildContext context) async {
    await hmsAnalytics.clearCachedData();
    _showDialog(context, "clearCachedData success");
  }

  Future<void> _getAAID(BuildContext context) async {
    String aaid = await hmsAnalytics.getAAID();
    _showDialog(context, "AAID : " + aaid);
  }

  Future<void> _getUserProfiles(BuildContext context) async {
    Map<String, String> profiles = await hmsAnalytics.getUserProfiles(true);
    _showDialog(context, "User Profiles : " + profiles.toString());
  }

  Future<void> _pageStart(BuildContext context) async {
    await hmsAnalytics.pageStart("pageName", "pageClassOverride");
    _showDialog(context, "pageStart success");
  }

  Future<void> _pageEnd(BuildContext context) async {
    await hmsAnalytics.pageEnd("pageName");
    _showDialog(context, "pageEnd success");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appTitle),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
//        padding: EdgeInsets.all(10),
        child: Column(

          children: <Widget>[
            HeaderWidget(
              title: "Huawei Analytics",
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  MyBtn("Enable Log", _onEnableLog),
                  MyBtn("Enable Log With Level", _onEnableLogWithLevel),
                  MyBtn("Set User Id", _setUserId),
                  MyBtn("Set User Profile", _setUserProfile),
                  MyBtn("Set Push Token", _setPushToken),
                  MyBtn("Set Min Activity Sessions", _setMinActivitySessions),
                  MyBtn("Set Sessions Duration", _setSessionDuration),
                  MyBtn("Send Custom Event", _onCustomEvent),
                  MyBtn("Send Predefined Event", _onPredefinedEvent),
                  MyBtn("Clear Cached Data", _clearCachedData),
                  MyBtn("Get AAID", _getAAID),
                  MyBtn("Get User Profiles", _getUserProfiles),
                  MyBtn("Page Start", _pageStart),
                  MyBtn("Page End", _pageEnd),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
