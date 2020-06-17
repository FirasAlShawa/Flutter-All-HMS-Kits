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

import 'dart:async';

import 'package:flutter/services.dart';

class HMSAnalytics {
  static const MethodChannel _channel =
  const MethodChannel('com.huawei.hms.flutter.analytics');

  Future<void> enableLog() async {
    await _channel.invokeMethod('enableLog', {});
  }

  Future<void> enableLogWithLevel(String logLevel) async {
    if(logLevel == null) {
      throw ArgumentError.notNull("loglevel");
    }

    if(!(logLevel == "DEBUG" || logLevel == "INFO" || logLevel == "WARN" || logLevel == "ERROR")){
      throw ArgumentError.value(logLevel, "logLevel", "Possible options [DEBUG, INFO, WARN, ERROR]");
    }

    await _channel
        .invokeMethod('enableLogWithLevel', {'logLevel': logLevel});
  }

  Future<void> setUserId(String userId) async {
    if(userId == null) {
      throw ArgumentError.notNull("userId");
    }
    await _channel.invokeMethod('setUserId', {'userId': userId});
  }

  Future<void> setUserProfile(String key, String value) async {
    if(key == null || value == null) {
      throw ArgumentError.notNull("key | value");
    }
    dynamic params = {'key': key, 'value': value};
    await _channel.invokeMethod('setUserProfile', params);
  }

  Future<void> setPushToken(String token) async {
    if(token == null) {
      throw ArgumentError.notNull("token");
    }
    await _channel.invokeMethod('setPushToken', {'': token});
  }

  Future<void> setMinActivitySessions(int interval) async {
    if(interval == null) {
      throw ArgumentError.notNull("interval");
    }
    await _channel.invokeMethod(
        'setMinActivitySessions', {'interval': interval});
  }

  Future<void> setSessionDuration(int duration) async {
    if(duration == null) {
      throw ArgumentError.notNull("duration");
    }
    await _channel
        .invokeMethod('setSessionDuration', {'duration': duration});
  }

  Future<void> onEvent(String key, Map<String, dynamic> value) async {
    if(key == null || value == null) {
      throw ArgumentError.notNull("key | value");
    }

    dynamic params = {
      'key': key,
      'value': value,
    };
    await _channel.invokeMethod('onEvent', params);
  }

  Future<void> clearCachedData() async {
    await _channel.invokeMethod('clearCachedData', {});
  }

  Future<String> getAAID() async {
    return await _channel.invokeMethod('getAAID');
  }

  Future<Map<String, String>> getUserProfiles(bool predefined) async {
    if(predefined == null) {
      throw ArgumentError.notNull("predefined");
    }
    Map<dynamic, dynamic> profiles = await _channel
        .invokeMethod('getUserProfiles', {'predefined': predefined});
    return Map<String, String>.from(profiles);
  }

  Future<void> pageStart(String pageName, String pageClassOverride) async {
    if(pageName == null || pageClassOverride == null) {
      throw ArgumentError.notNull("pageName | pageClassOverride");
    }
    dynamic params = {
      'pageName': pageName,
      'pageClassOverride': pageClassOverride,
    };
    await _channel.invokeMethod('pageStart', params);
  }

  Future<void> pageEnd(String pageName) async {
    if(pageName == null) {
      throw ArgumentError.notNull("pageName");
    }
    await _channel.invokeMethod('pageEnd', {'pageName': pageName});
  }
}

// Huawei Analytics Event Types
class HAEventType {
  static final String CREATEPAYMENTINFO = "\$CreatePaymentInfo";
  static final String ADDPRODUCT2CART = "\$AddProduct2Cart";
  static final String ADDPRODUCT2WISHLIST = "\$AddProduct2WishList";
  static final String STARTAPP = "\$StartApp";
  static final String STARTCHECKOUT = "\$StartCheckout";
  static final String VIEWCAMPAIGN = "\$ViewCampaign";
  static final String VIEWCHECKOUTSTEP = "\$ViewCheckoutStep";
  static final String WINVIRTUALCOIN = "\$WinVirtualCoin";
  static final String COMPLETEPURCHASE = "\$CompletePurchase";
  static final String OBTAINLEADS = "\$ObtainLeads";
  static final String JOINUSERGROUP = "\$JoinUserGroup";
  static final String COMPLETELEVEL = "\$CompleteLevel";
  static final String STARTLEVEL = "\$StartLevel";
  static final String UPGRADELEVEL = "\$UpgradeLevel";
  static final String SIGNIN = "\$SignIn";
  static final String SIGNOUT = "\$SignOut";
  static final String SUBMITSCORE = "\$SubmitScore";
  static final String CREATEORDER = "\$CreateOrder";
  static final String REFUNDORDER = "\$RefundOrder";
  static final String DELPRODUCTFROMCART = "\$DelProductFromCart";
  static final String SEARCH = "\$Search";
  static final String VIEWCONTENT = "\$ViewContent";
  static final String UPDATECHECKOUTOPTION = "\$UpdateCheckoutOption";
  static final String SHARECONTENT = "\$ShareContent";
  static final String REGISTERACCOUNT = "\$RegisterAccount";
  static final String CONSUMEVIRTUALCOIN = "\$ConsumeVirtualCoin";
  static final String STARTTUTORIAL = "\$StartTutorial";
  static final String COMPLETETUTORIAL = "\$CompleteTutorial";
  static final String OBTAINACHIEVEMENT = "\$ObtainAchievement";
  static final String VIEWPRODUCT = "\$ViewProduct";
  static final String VIEWPRODUCTLIST = "\$ViewProductList";
  static final String VIEWSEARCHRESULT = "\$ViewSearchResult";
  static final String UPDATEMEMBERSHIPLEVEL = "\$UpdateMembershipLevel";
  static final String FILTRATEPRODUCT = "\$FiltrateProduct";
  static final String VIEWCATEGORY = "\$ViewCategory";
  static final String UPDATEORDER = "\$UpdateOrder";
  static final String CANCELORDER = "\$CancelOrder";
  static final String COMPLETEORDER = "\$CompleteOrder";
  static final String CANCELCHECKOUT = "\$CancelCheckout";
  static final String OBTAINVOUCHER = "\$ObtainVoucher";
  static final String CONTACTCUSTOMSERVICE = "\$ContactCustomService";
  static final String RATE = "\$Rate";
  static final String INVITE = "\$Invite";
}

// Huawei Analytics Parameter Types
class HAParamType {
  static final String STORENAME = "\$StoreName";
  static final String BRAND = "\$Brand";
  static final String CATEGORY = "\$Category";
  static final String PRODUCTID = "\$ProductId";
  static final String PRODUCTNAME = "\$ProductName";
  static final String PRODUCTFEATURE = "\$ProductFeature";
  static final String PRICE = "\$Price";
  static final String QUANTITY = "\$Quantity";
  static final String REVENUE = "\$Revenue";
  static final String CURRNAME = "\$CurrName";
  static final String PLACEID = "\$PlaceId";
  static final String DESTINATION = "\$Destination";
  static final String ENDDATE = "\$EndDate";
  static final String BOOKINGDAYS = "\$BookingDays";
  static final String PASSENGERSNUMBER = "\$PassengersNumber";
  static final String BOOKINGROOMS = "\$BookingRooms";
  static final String ORIGINATINGPLACE = "\$OriginatingPlace";
  static final String BEGINDATE = "\$BeginDate";
  static final String TRANSACTIONID = "\$TransactionId";
  static final String CLASS = "\$Class";
  static final String CLICKID = "\$ClickId";
  static final String PROMOTIONNAME = "\$PromotionName";
  static final String CONTENT = "\$Content";
  static final String EXTENDPARAM = "\$ExtendParam";
  static final String MATERIALNAME = "\$MaterialName";
  static final String MATERIALSLOT = "\$MaterialSlot";
  static final String MEDIUM = "\$Medium";
  static final String SOURCE = "\$Source";
  static final String KEYWORDS = "\$Keywords";
  static final String OPTION = "\$Option";
  static final String STEP = "\$Step";
  static final String VIRTUALCURRNAME = "\$VirtualCurrName";
  static final String VOUCHER = "\$Voucher";
  static final String PLACE = "\$Place";
  static final String SHIPPING = "\$Shipping";
  static final String TAXFEE = "\$TaxFee";
  static final String USERGROUPID = "\$UserGroupId";
  static final String LEVELNAME = "\$LevelName";
  static final String RESULT = "\$Result";
  static final String ROLENAME = "\$RoleName";
  static final String LEVELID = "\$LevelId";
  static final String CHANNEL = "\$Channel";
  static final String SCORE = "\$Score";
  static final String SEARCHKEYWORDS = "\$SearchKeywords";
  static final String CONTENTTYPE = "\$ContentType";
  static final String ACHIEVEMENTID = "\$AchievementId";
  static final String FLIGHTNO = "\$FlightNo";
  static final String POSITIONID = "\$PositionId";
  static final String PRODUCTLIST = "\$ProductList";
  static final String ACOUNTTYPE = "\$AcountType";
  static final String OCCURREDTIME = "\$OccurredTime";
  static final String EVTRESULT = "\$EvtResult";
  static final String PREVLEVEL = "\$PrevLevel";
  static final String CURRVLEVEL = "\$CurrvLevel";
  static final String VOUCHERS = "\$Vouchers";
  static final String MATERIALSLOTTYPE = "\$MaterialSlotType";
  static final String LISTID = "\$ListId";
  static final String FILTERS = "\$Filters";
  static final String SORTS = "\$Sorts";
  static final String ORDERID = "\$OrderId ";
  static final String PAYTYPE = "\$PayType";
  static final String REASON = "\$Reason";
  static final String EXPIREDATE = "\$ExpireDate";
  static final String VOUCHERTYPE = "\$VoucherType";
  static final String SERVICETYPE = "\$ServiceType";
  static final String DETAILS = "\$Details";
  static final String COMMENTTYPE = "\$CommentType";
  static final String REGISTMETHOD = "\$RegistMeth";
}
