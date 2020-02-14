import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pushbots_flutter/pushbots_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    PushbotsFlutter.initialize("5e145ec41f0f854fca1e2b54");
	PushbotsFlutter.setLogLevelWithUI(LogLevels.verbose.index, true);
 	print("setLogLevelWithUI"+LogLevels.verbose.toString());
	PushbotsFlutter.setTags(["tag1","tag2"]);
	PushbotsFlutter.removeTags(["tag1"]);
	PushbotsFlutter.shareLocationPrompt(true);
	
    PushbotsFlutter.notificationOpen.stream.listen((onData) {
      print("Main Dart opened: " + onData.toString());
    });
    PushbotsFlutter.userIDs.stream.listen((onData) {
      print("Main Dart userIDs: " + onData.toString());
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
