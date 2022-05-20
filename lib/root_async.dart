import 'dart:async';

import 'package:flutter/services.dart';

class RootAsync {
  static const MethodChannel _channel = MethodChannel('root_async');

  // Function to Run shell commands
  static Future<String?> exec(String cmd) async {
    return await _channel.invokeMethod('ExecuteCommand', {"cmd": cmd});
  }
}
