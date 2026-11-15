
import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/article.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    final author = article.author;
    final byline = author == null || author.isEmpty
        ? article.sourceName
        : author;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title,
          style: const TextStyle(
            color: Color(0xFF111111),
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.25,
            letterSpacing: -0.4,
          ),
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF222222),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  article.sourceName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            const Icon(
              Icons.access_time_rounded,
              size: 13,
              color: Colors.grey,
            ),

            const SizedBox(width: 4),

            Flexible(
              child: Text(
                DateFormatter.relative(article.publishedAt),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ),

            const Spacer(),

            CircleAvatar(
              radius: 14,
              backgroundColor: const Color(0xFFEAEAEA),
              child: Text(
                byline.isNotEmpty
                    ? byline.characters.first.toUpperCase()
                    : '?',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
