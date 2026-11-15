
import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/article.dart';
import '../../../widgets/article_image.dart';
import '../../../widgets/bookmark_button.dart';
import '../../../widgets/source_label.dart';

class BookmarkItem extends StatelessWidget {
  const BookmarkItem({
    super.key,
    required this.article,
  });

  final Article article;

  void _remove(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Dihapus dari Tersimpan'),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Urungkan',
            onPressed: () {
              // TODO: Panggil notifier.toggle(article) lagi
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final description = article.description;

    return Dismissible(
      key: ValueKey(article.url),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _remove(context),

      // Background ketika card digeser
      background: Container(
        decoration: BoxDecoration(
          color: scheme.errorContainer,
          borderRadius: BorderRadius.circular(19),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Icon(
          Icons.delete_outline_rounded,
          size: 28,
          color: scheme.onErrorContainer,
        ),
      ),

      // Card berita
      child: GestureDetector(
        onTap: () => AppRouter.openArticle(context, article),
        child: Container(
          width: double.infinity,
          height: 290,
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
                  height: 150,
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
                child: SourceLabel(
                  name: article.sourceName,
                ),
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
      ),
    );
  }
}
