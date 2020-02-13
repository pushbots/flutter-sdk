import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pushbots/pushbots.dart';

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
    registerForNotification();
    Pushbots.setLogLevel("DEBUG", "INFO");

    Pushbots.listenForNotificationReceive().stream.listen((onData) {
      print("MAIN, received: " + onData.toString());
      Map value = json.decode(onData.toString());
      print("After converted to map ! " + value.toString());
    });


    Pushbots.listenForNotificationOpen().stream.listen((onData){
      print("MAIN, opened: " + onData.toString());
    });

    Pushbots.setName("Pushbotter");
    Pushbots.setFirstName("Pushbots");
    Pushbots.setLastName("Pushbots");
    Pushbots.setEmail("info@pushbots.com");
    Pushbots.setPhone("000111222333");
    //Pushbots.shareLocation(true);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPushBots() async {
    String initStatue;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initStatue = await Pushbots.init();
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
                  Pushbots.toggleNotifications(switchState);
                }),
              ),
              Text('$pbRegisterInfo\n'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerForNotification() async {
    String result;

    try {
      result = await Pushbots.registerForNotification();
    } on Exception {
      result = "Failed to register for notification";
    }

    setState(() {
      pbRegisterInfo = result;
    });
  }
}
/**/
