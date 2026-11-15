
import 'package:flutter/material.dart';

import '../../../data/models/article.dart';
import 'widgets/detail_app_bar.dart';
import 'widgets/detail_content.dart';
import 'widgets/detail_header.dart';
import 'widgets/read_more_bar.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    final lightTheme = Theme.of(context).copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF222222),
        brightness: Brightness.light,
        surface: Colors.white,
      ),
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: const Color(0xFF222222),
        displayColor: const Color(0xFF111111),
      ),
    );

    return Theme(
      data: lightTheme,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            DetailAppBar(article: article),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
              sliver: SliverList.list(
                children: [
                  DetailHeader(article: article),
                  const SizedBox(height: 14),
                  DetailContent(article: article),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ReadMoreBar(url: article.url),
      ),
    );
  }
}
