import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:root_async/root_async.dart';

void main() {
  const MethodChannel channel = MethodChannel('root_async');

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
    expect(await RootAsync.platformVersion, '42');
  });
}
