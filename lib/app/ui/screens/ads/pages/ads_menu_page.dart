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
import 'package:flutter/material.dart';
import 'package:hmsallkitsflutter/app/utils/constants.dart';

import 'package:hmsallkitsflutter/app/ui/widgets/header.dart';

class AdsMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Huawei Ads',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          HeaderWidget(
            title: "Huawei Ads",
          ),
          RaisedButton(
            child: Text(
              'Publisher Service',
              style: Styles.menuButtonStyle,
            ),
            color: Color.fromRGBO(35, 151, 239, 1),
            textColor: Color.fromRGBO(255, 255, 255, 1),
            onPressed: () {
              Navigator.pushNamed(context, Routes.publisherService);
            },
          ),
          RaisedButton(
            child: Text(
              'Identifier Service',
              style: Styles.menuButtonStyle,
            ),
            color: Color.fromRGBO(35, 151, 239, 1),
            textColor: Color.fromRGBO(255, 255, 255, 1),
            onPressed: () {
              Navigator.pushNamed(context, Routes.identifierOaid);
            },
          ),
          RaisedButton(
            child: Text(
              'Install Referrer Service',
              style: Styles.menuButtonStyle,
            ),
            color: Color.fromRGBO(35, 151, 239, 1),
            textColor: Color.fromRGBO(255, 255, 255, 1),
            onPressed: () {
              Navigator.pushNamed(context, Routes.installReferrerService);
            },
          ),
        ],
      ),
    );
  }
}
