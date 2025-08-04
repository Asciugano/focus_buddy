import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/diary.dart';
import 'package:focus_buddy/data/constaints.dart';

class DiaryWidget extends StatefulWidget {
  const DiaryWidget({super.key, required this.diary});

  final Diary diary;

  @override
  State<DiaryWidget> createState() => _DiaryWidgetState();
}

class _DiaryWidgetState extends State<DiaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.diary.creationTime
                        .toLocal()
                        .toString()
                        .split(' ')[0]
                        .replaceAll('-', '/'),
                    style: KTextStyle.descriptionText(),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          print('modifica');
                          break;
                        case 'delete':
                          print('elimina');
                          break;
                      }
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text(
                          'Modifica',
                          style: KTextStyle.titleText(
                            Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text(
                          'Elimina',
                          style: KTextStyle.titleText(Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.diary.title,
                style: KTextStyle.titleText().copyWith(fontSize: 24),
              ),
              const SizedBox(height: 6),
              Text(widget.diary.content, style: KTextStyle.descriptionText().copyWith(height: 1.5)),
            ],
          ),
        ),
      ),
    );
  }
}