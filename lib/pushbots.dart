import 'dart:async';

import 'package:flutter/services.dart';

class Pushbots {
  static const MethodChannel _channel = const MethodChannel('pushbots');


  static Future<String> init() async {
    return await _channel.invokeMethod('init');
  }

  static Future<String> registerForNotification() async {
    return _channel.invokeMethod('registerForNotification');
  }

  static Future<String> setAlias(String alias) async {
    return _channel.invokeMethod("setAlias", alias);
  }

  static Future<String> removeAlias() async {
    return _channel.invokeMethod("removeAlias");
  }

  static Future<String> tag(String tag) async {
    return _channel.invokeMethod("tag", tag);
  }

  static Future<String> untag(String tag) async {
    return _channel.invokeMethod("untag", tag);
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

  static Future<String> toggleNotifications(bool statue) async {
    return _channel.invokeMethod("toggleNotifications", statue);
  }
}
