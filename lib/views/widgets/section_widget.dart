import 'package:flutter/material.dart';
import 'package:focus_buddy/data/constaints.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({
    super.key,
    required this.title,
    required this.list,
    required this.itemBuilder,
    required this.directionBuilder,
  });

  final String title;
  final List<dynamic> list;
  final Widget Function(dynamic items) itemBuilder;
  final Widget Function(dynamic items) directionBuilder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => directionBuilder(title),
          ),
        );
      },
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: KTextStyle.titleText()),
              const SizedBox(height: 12),
              ...list.take(3).map((item) => itemBuilder(item)),
            ],
          ),
        ),
      ),
    );
  }
}