import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/AmbientSound.dart';
import 'package:focus_buddy/data/constaints.dart';

class SoundTrack extends StatelessWidget {
  const SoundTrack({super.key, required this.sound});

  final AmbientSound sound;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sound.isPlaying,
      builder: (context, isPlaying, child) {
        return Card(
          elevation: 3,
          child: ListTile(
            leading: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
            ),
            title: Text(sound.name, style: KTextStyle.titleText(isPlaying ? Colors.white : Colors.grey),),
            onTap: () async {
              if (isPlaying) {
                await sound.pause();
              } else {
                await sound.play();
              }
            },
          ),
        );
      },
    );
  }
}