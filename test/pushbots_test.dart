import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pushbots/pushbots.dart';

void main() {
  const MethodChannel channel = MethodChannel('pushbots');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'PushBots Initialized Successfully';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('init', () async {
    expect(await Pushbots.init(), 'PushBots Initialized Successfully');
  });
}
