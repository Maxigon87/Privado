import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:win32/win32.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VolumeBoosterApp());
}

class VolumeBoosterApp extends StatelessWidget {
  const VolumeBoosterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VolumeBoosterHome(),
    );
  }
}

class VolumeBoosterHome extends StatefulWidget {
  const VolumeBoosterHome({super.key});

  @override
  State<VolumeBoosterHome> createState() => _VolumeBoosterHomeState();
}

class _VolumeBoosterHomeState extends State<VolumeBoosterHome> {
  late final AudioPlayer _player;
  String _statusMessage = 'Preparando audio…';

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _configureAudio();
  }

  Future<void> _configureAudio() async {
    try {
      await Future.wait([
        if (Platform.isWindows)
          Future<void>.microtask(_setWindowsVolumeToMax),
        _player.setAsset('assets/audio/startup.wav'),
      ]);
      await _player.play();
      setState(() {
        _statusMessage = 'Reproduciendo sonido de inicio.';
      });
    } catch (error) {
      setState(() {
        _statusMessage = 'Error al preparar el audio: $error';
      });
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.volume_up, size: 96, color: Colors.white),
              const SizedBox(height: 24),
              const Text(
                'Volumen al máximo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _statusMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 24),
              const Text(
                'Puedes reemplazar el archivo en assets/audio/startup.wav por tu propio sonido.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _setWindowsVolumeToMax() {
  const steps = 50;
  for (var i = 0; i < steps; i++) {
    keybd_event(VK_VOLUME_UP, 0, 0, 0);
    keybd_event(VK_VOLUME_UP, 0, KEYEVENTF_KEYUP, 0);
  }
}
