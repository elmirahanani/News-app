
import 'package:flutter/material.dart';

import '../../../../data/models/article.dart';
import '../../../widgets/article_image.dart';
import '../../../widgets/bookmark_button.dart';

class DetailAppBar extends StatelessWidget {
  const DetailAppBar({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 0,
      expandedHeight: 250,

      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            ArticleImage(
              url: article.imageUrl,
              radius: 0,
            ),

            // Tombol kembali
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              left: 16,
              child: CircleAvatar(
                radius: 23,
                backgroundColor: Colors.black.withOpacity(0.7),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 23,
                  ),
                ),
              ),
            ),

            // Bookmark
            Positioned(
              top: MediaQuery.of(context).padding.top + 12,
              right: 16,
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: BookmarkButton(
                  article: article,
                  tonal: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
