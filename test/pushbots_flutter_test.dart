import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pushbots_flutter/pushbots_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('pushbots_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await PushbotsFlutter.platformVersion, '42');
  });
}
