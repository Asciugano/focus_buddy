import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/AmbientSound.dart';

class SoundsPage extends StatefulWidget {
  const SoundsPage({super.key});

  @override
  State<SoundsPage> createState() => _SoundsPageState();
}

class _SoundsPageState extends State<SoundsPage> {
  
  final List<Ambientsound> sounds = [
    Ambientsound('Pioggia', 'assets/sounds/rain.mp3'),
    Ambientsound('Foresta', 'assets/sounds/forest.mp3'),
    Ambientsound('Vento', 'assets/sounds/wind.mp3'),
  ];
  
  @override
  void dispose() {
    for(final sound in sounds) {
      sound.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: sounds.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16,),
      itemBuilder: (context, index) {
        final sound = sounds[index];
        return Card(
          elevation: 3,
          child: ListTile(
            leading: Icon(sound.isPlaying ? Icons.pause : Icons.play_arrow),
            title: Text(sound.name),
            onTap: () async {
              setState(() {
                sound.isPlaying ? sound.pause() : sound.play();
              });
            },
          ),
        );
      },
    );
  }
}