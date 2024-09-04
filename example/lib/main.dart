import 'package:audio_session/audio_session.dart';
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
  int currentBPM = 0;

  @override
  void initState() {
    super.initState();
    AudioSession.instance.then((instance) async {
      instance.configure(const AudioSessionConfiguration.speech());
      currentBPM = await _metronomePlugin.getBPM();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final bpm = currentBPM - 5;
                      await _metronomePlugin.setBPM(bpm);
                      currentBPM = bpm;
                      setState(() {});
                    },
                    child: const Text("-"),
                  ),
                  FutureBuilder(
                    future: _metronomePlugin.getBPM(),
                    builder: (context, snapshot) {
                      final data = snapshot.data;
                      if (data != null) {
                        currentBPM = data;
                      }
                      return Text(data.toString());
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final bpm = currentBPM + 5;
                      await _metronomePlugin.setBPM(bpm);
                      currentBPM = bpm;
                      setState(() {});
                    },
                    child: const Text("+"),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  await _metronomePlugin.play(currentBPM);
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
      ),
    );
  }
}
