import 'dart:async';

import 'package:flutter/services.dart';
enum LogLevels {
  noLog,
  error,
  warn,
  info, 
  verbose
}
class PushbotsFlutter {
  static const MethodChannel _channel =
      const MethodChannel('pushbots_flutter');

   static StreamController<String> notificationReceive =
       new StreamController<String>();
   static StreamController<String> notificationOpen =
       new StreamController<String>();
  static StreamController<String> notificationRegistered =
 	      new StreamController<String>();
   static StreamController<String> userIDs = new StreamController<String>();
  static StreamController<String> initialized = new StreamController<String>();
  static StreamController<String> sharingLocation =
  new StreamController<String>();
  static StreamController<String> registered = new StreamController<String>();
  
   static Future<String> initialize(String id) async {
  	 _channel.setMethodCallHandler(_handleMethod);
     return _channel.invokeMethod('initialize', id).whenComplete((){
       _channel.invokeMethod("registerForNotification");
     });
   }

   static Future<String> setAlias(String alias) async {
     return _channel.invokeMethod("setAlias", alias);
   }

   static Future<String> removeAlias() async {
     return _channel.invokeMethod("removeAlias");
   }

   static Future<String> setTags(List<String> tags) async {
     return _channel.invokeMethod("setTags", tags);
   }

   static Future<String> removeTags(List<String> tags) async {
     return _channel.invokeMethod("removeTags", tags);
   }
  
   static Future<String> trackEvent(String name) async {
    return _channel.invokeMethod("trackEvent", name);
   }
   static Future<String> shareLocationPrompt(bool toggle) async {
    return _channel.invokeMethod("shareLocationPrompt", toggle);
   }
   static Future<String> shareLocation(bool toggle) async {
    return _channel.invokeMethod("shareLocation", toggle);
   }
   static Future<String> setLogLevelWithUI(int level,bool show) async {
    return _channel.invokeMethod("setLogLevelWithUI", [level, show]);
   }
   static Future<String> resetBadge() async {
     return _channel.invokeMethod("resetBadge");
   }
   static Future<String> setBadge(int number) async {
     return _channel.invokeMethod("setBadge", number);
   }
   static Future<String> incrementBadgeCountBy(int number) async {
     return _channel.invokeMethod("incrementBadgeCountBy", number);
   }
   static Future<String> decrementBadgeCountBy(int number) async {
     return _channel.invokeMethod("decrementBadgeCountBy", number);
   }
  
   static Future<String> setName(String name) async {
     return _channel.invokeMethod("setName", name);
   }


   static Future<String> setEmail(String email) async {
     return _channel.invokeMethod("setEmail", email);
   }

   static Future<String> setPhone(String phone) async {
     return _channel.invokeMethod("setPhone", phone);
   }

   static Future<String> setGender(String gender) async {
     return _channel.invokeMethod("setGender", gender);
   }

   static Future<String> setFirstName(String firstName) async {
     return _channel.invokeMethod("setFirstname", firstName);
   }

   static Future<String> setLastName(String lastName) async {
     return _channel.invokeMethod("setLastName", lastName);
   }

   static Future<String> debug(bool debug) async {
     return _channel.invokeMethod("debug", debug);
   }

  static Future<String> setLogLevel(String logcatLevel, String uiLevel) {
    return _channel.invokeMethod("setLogLevel", <String, dynamic>{
      'logcatLevel': logcatLevel,
      'uiLevel': uiLevel,
    });
  }

   static Future<String> toggleNotifications(bool statue) async {
     return _channel.invokeMethod("toggleNotifications", statue);
   }

  static StreamController<String> listenForNotificationReceive() {
    _channel.invokeMapMethod("receiveCallback");
    return notificationReceive;
  }

  static StreamController<String> listenForNotificationOpen() {
    _channel.invokeMapMethod("openCallback");
    return notificationOpen;
  }

  static StreamController<String> listenForNotificationIds() {
    _channel.invokeMethod("idsCallback");
    return userIDs;
  }

  static StreamController<String> isInitialized() {
    _channel.invokeMethod("isInitialized");
    return initialized;
  }

  static StreamController<String> isRegistered() {
    _channel.invokeMethod("isRegistered");
    return registered;
  }

  static StreamController<String> isSharingLocation() {
    _channel.invokeMethod("isSharingLocation");
    return sharingLocation;
  }

   static Future<dynamic> _handleMethod(MethodCall call) async {
     print("PushBots.dart: Called");
     switch (call.method) {
       case "received":
         notificationReceive.add(call.arguments.toString());
         print("PushBots.dart: recieved"+  call.arguments.toString());
         break;
       case "opened":
         notificationOpen.add(call.arguments.toString());
         break;
       case "registered":
         notificationOpen.add(call.arguments.toString());
         break;
       case "userIDs":
         userIDs.add(call.arguments.toString());
         break;
       case "initialized":
         initialized.add(call.arguments.toString());
         break;
       case "registered":
         registered.add(call.arguments.toString());
         break;
       case "sharingLocation":
         sharingLocation.add(call.arguments.toString());
         break;
     }
   }
}
