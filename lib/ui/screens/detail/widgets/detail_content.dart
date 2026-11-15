
import 'package:flutter/material.dart';

import '../../../../data/models/article.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    final description = article.description ?? '';
    final content = article.cleanContent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ringkasan berita
        if (description.isNotEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 13,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              description,
              style: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 12,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 14),
        ],

        // Isi berita
        if (content.isNotEmpty && content != description)
          Text(
            content,
            style: const TextStyle(
              color: Color(0xFF222222),
              fontSize: 13,
              height: 1.7,
            ),
          ),

        const SizedBox(height: 18),

        const Text(
          'Details of the Incident',
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          'For more information about this story, '
          'read the complete coverage from ${article.sourceName}.',
          style: const TextStyle(
            color: Color(0xFF333333),
            fontSize: 12,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
