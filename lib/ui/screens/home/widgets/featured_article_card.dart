
import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/article.dart';
import '../../../widgets/article_image.dart';
import '../../../widgets/bookmark_button.dart';
import '../../../widgets/source_label.dart';

/// Kartu berita utama dengan desain horizontal.
class FeaturedArticleCard extends StatelessWidget {
  const FeaturedArticleCard({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    final description = article.description;

    return GestureDetector(
      onTap: () => AppRouter.openArticle(context, article),
      child: Container(
        width: 208,
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(19),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar berita
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 108,
                width: double.infinity,
                child: ArticleImage(
                  url: article.imageUrl,
                  radius: 0,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Sumber berita
            DefaultTextStyle(
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 10,
              ),
              child: SourceLabel(name: article.sourceName),
            ),

            const SizedBox(height: 5),

            // Judul berita
            Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF111111),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),

            if (description != null && description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                ),
              ),
            ],

            const Spacer(),

            // Waktu publikasi dan bookmark
            Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: 12,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    DateFormatter.relative(article.publishedAt),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
                BookmarkButton(article: article),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
