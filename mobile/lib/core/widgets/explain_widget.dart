import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ExplainWidget extends StatelessWidget {
  const ExplainWidget({super.key, required this.explain});

  final String explain;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          const Text('Giải thích đáp án', style: kHeaderExplainText),
          Text(explain, style: kExplainText),
        ],
      ),
    );
  }
}
