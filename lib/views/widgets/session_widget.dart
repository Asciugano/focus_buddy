import 'package:flutter/material.dart';
import 'package:focus_buddy/data/classes/Session.dart';
import 'package:focus_buddy/data/constaints.dart';

class SessionWidget extends StatefulWidget {
  const SessionWidget({super.key, required this.session});

  final Session session;

  @override
  State<SessionWidget> createState() => _SessionWidgetState();
}

class _SessionWidgetState extends State<SessionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => print('elimina'),
      onTap: () => print('premuta'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  constraints: const BoxConstraints(minWidth: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.session.valutation.toString(),
                        style: KTextStyle.titleText(),
                      ),
                      const SizedBox(height: 6),
                      Text(widget.session.title, style: KTextStyle.titleText()),
                      if (widget.session.description != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          widget.session.description!,
                          style: KTextStyle.descriptionText(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.session.creationDate
                            .toLocal()
                            .toString()
                            .split(' ')[0]
                            .replaceAll('-', '/'),
                        style: KTextStyle.descriptionText(),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatDuration(widget.session.duration),
                        style: KTextStyle.descriptionText(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final min = duration.inMinutes;
    final sec = duration.inSeconds % 60;

    return '$min:$sec';
  }
}