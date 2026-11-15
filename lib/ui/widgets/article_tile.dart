
import 'package:flutter/material.dart';

import '../../core/router/app_router.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/models/article.dart';
import 'article_image.dart';
import 'bookmark_button.dart';
import 'source_label.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => AppRouter.openArticle(context, article),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informasi berita
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SourceLabel(
                      name: article.sourceName,
                    ),

                    const SizedBox(height: 9),

                    // Judul berita
                    Text(
                      article.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Waktu dan bookmark
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            DateFormatter.relative(
                              article.publishedAt,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),

                        BookmarkButton(
                          article: article,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              // Thumbnail berita
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: ArticleImage(
                  url: article.imageUrl,
                  width: 104,
                  height: 104,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
