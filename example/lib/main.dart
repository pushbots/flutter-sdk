import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pushbots_flutter/pushbots_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String pbInitState = 'PushBots did not initialized yet...';
  String pbRegisterInfo = 'PushBots Register Status';

  bool switchState = true;

  @override
  void initState() {
    super.initState();
    initPushBots();
 
    PushbotsFlutter.setTags(["tag1", "tag2"]);
    PushbotsFlutter.removeTags(["tag1"]);


    PushbotsFlutter.listenForNotificationOpen().stream.listen((onData) {
      print("Main Dart opened: " + onData.toString());
    });

    PushbotsFlutter.listenForNotificationReceive().stream.listen((onData) {
      print("Main Dart recieved: " + onData.toString());
    });
  }

  Future<void> initPushBots() async {
    String initStatue;
    try {
      initStatue = await PushbotsFlutter.initialize("5f54eb8294c8707a73747353", "AIzaSyBBqJ3drZa5ela2vp_qG5jIaDLu_EmVFgo", "1:228922123289:android:adf65d015d73994d9c3688", "test-ea152");
    } on Exception {
      initStatue = 'Failed to get initialize push-bots.';
    }
    setState(() {
      pbInitState = initStatue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin PushBots app'),
        ),
        body: Center(
          child: new Column(
            children: <Widget>[
              Text('$pbInitState\n'),
              Switch(
                value: switchState,
                onChanged: (val) => setState(() {
                  switchState = val;
                  PushbotsFlutter.toggleNotifications(switchState);
                }),
              ),
              Text('$pbRegisterInfo\n'),
            ],
          ),
        ),
      ),
    );
  }
}
