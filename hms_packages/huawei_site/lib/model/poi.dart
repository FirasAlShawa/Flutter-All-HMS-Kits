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

import 'package:collection/collection.dart';

import 'opening_hours.dart';

class Poi {
  String internationalPhone;
  OpeningHours openingHours;
  String phone;
  List<String> photoUrls;
  List<String> poiTypes;
  double rating;
  String websiteUrl;

  Poi({
    this.internationalPhone,
    this.openingHours,
    this.phone,
    this.photoUrls,
    this.poiTypes,
    this.rating,
    this.websiteUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'internationalPhone': internationalPhone,
      'openingHours': openingHours?.toMap(),
      'phone': phone,
      'photoUrls': photoUrls,
      'poiTypes': poiTypes,
      'rating': rating,
      'websiteUrl': websiteUrl,
    };
  }

  factory Poi.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Poi(
      internationalPhone:
          map["internationalPhone"] == null ? null : map["internationalPhone"],
      openingHours: map["openingHours"] == null
          ? null
          : OpeningHours.fromMap(map["openingHours"]),
      phone: map["phone"] == null ? null : map["phone"],
      photoUrls: map["photoUrls"] == null
          ? null
          : List<String>.from(map["photoUrls"].map((x) => x)),
      poiTypes: map["poiTypes"] == null
          ? null
          : List<String>.from(map["poiTypes"].map((x) => x)),
      rating: map["rating"] == null ? null : map["rating"].toDouble(),
      websiteUrl: map["websiteUrl"] == null ? null : map["websiteUrl"],
    );
  }

  String toJson() => json.encode(toMap());

  factory Poi.fromJson(String source) => Poi.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Poi(internationalPhone: $internationalPhone, openingHours: $openingHours, phone: $phone, photoUrls: $photoUrls, poiTypes: $poiTypes, rating: $rating, websiteUrl: $websiteUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return o is Poi &&
        o.internationalPhone == internationalPhone &&
        o.openingHours == openingHours &&
        o.phone == phone &&
        listEquals(o.photoUrls, photoUrls) &&
        listEquals(o.poiTypes, poiTypes) &&
        o.rating == rating &&
        o.websiteUrl == websiteUrl;
  }

  @override
  int get hashCode {
    return hashList([
      internationalPhone,
      openingHours,
      phone,
      photoUrls,
      poiTypes,
      rating,
      websiteUrl,
    ]);
  }
}
