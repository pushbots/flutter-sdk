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



  Future<void> initPushBots() async {
    String initStatue;
    try {
      initStatue = await PushbotsFlutter.initialize("5e145ec41f0f854fca1e2b54");
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
