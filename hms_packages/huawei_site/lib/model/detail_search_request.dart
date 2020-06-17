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

import 'dart:convert';
import 'dart:ui';

class DetailSearchRequest {
  String siteId;
  String language;
  String politicalView;

  DetailSearchRequest({
    this.siteId,
    this.language,
    this.politicalView,
  });

  Map<String, dynamic> toMap() {
    return {
      'siteId': siteId,
      'language': language,
      'politicalView': politicalView,
    };
  }

  factory DetailSearchRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DetailSearchRequest(
      siteId: map['siteId'],
      language: map['language'],
      politicalView: map['politicalView'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailSearchRequest.fromJson(String source) =>
      DetailSearchRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'DetailSearchRequest(siteId: $siteId, language: $language, politicalView: $politicalView)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DetailSearchRequest &&
        o.siteId == siteId &&
        o.language == language &&
        o.politicalView == politicalView;
  }

  @override
  int get hashCode {
    return hashList([
      siteId,
      language,
      politicalView,
    ]);
  }
}
