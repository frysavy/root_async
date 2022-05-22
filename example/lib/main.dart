import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:root_async/root_async.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _output = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String output;
    try {
      output = await RootAsync.exec("ls") ?? "LS Output";
    } on PlatformException {
      output = 'Failed to get LS.';
    }

    if (!mounted) return;

    setState(() {
      _output = output;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Root_async'),
        ),
        body: Center(
          child: Column(children: [
            Text('Ls output: $_output\n'),
          ]),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: initPlatformState),
      ),
    );
  }
}
