import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/services/services.dart';
import 'package:focus_buddy/views/widgets/sound_track_widget.dart';

class SoundsPage extends StatefulWidget {
  const SoundsPage({super.key});

  @override
  State<SoundsPage> createState() => _SoundsPageState();
}

class _SoundsPageState extends State<SoundsPage> {
  
  final sounds = GlobalSoundService().sounds;
  
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: sounds.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16,),
      itemBuilder: (context, index) {
        final sound = sounds[index];
        return SoundTrack(sound: sound);
      },
    );
  }
}