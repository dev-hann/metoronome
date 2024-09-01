import 'package:flutter/material.dart';

import 'package:metronome/metronome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _metronomePlugin = Metronome();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: _metronomePlugin.isPlaying(),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (data == null) {
                  return const SizedBox();
                }
                return Text(data.toString());
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await _metronomePlugin.play(120);
                setState(() {});
              },
              child: const Text("Play"),
            ),
            ElevatedButton(
              onPressed: () async {
                await _metronomePlugin.stop();
                setState(() {});
              },
              child: const Text("Stop"),
            ),
          ],
        ),
      ),
    );
  }
}
