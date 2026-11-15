import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';
import 'package:news_app/ui/widgets/empty_state.dart';
import 'package:news_app/ui/widgets/error_state.dart';
import 'package:news_app/ui/widgets/loading_skeleton.dart';

import 'featured_article_card.dart';

// menampilkan daftar top headlines.
class HeadlinesSection extends ConsumerWidget {
  const HeadlinesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(SelectedCategoryProvider);
    final headlines = ref.watch(headlinesProvider(category));

    return headlines.when(
      loading: () => const SliverToBoxAdapter(
        child: LoadingSkeleton(),
      ),

      error: (error, _) => SliverFillRemaining(
        hasScrollBody: false,
        child: ErrorState(
          error: error,
          onRetry: () => ref.invalidate(headlinesProvider(category)),
        ),
      ),

      data: (articles) {
        if (articles.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyState(
              icon: Icons.newspaper_rounded,
              title: 'belum ada berita',
              message:
                  'coba pilih kategori lain atau tarik ke atas untuk reload',
            ),
          );
        }

        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // section title
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Headlines',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'See all',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // news cards
              SizedBox(
                height: 255,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: articles.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: 13),
                  itemBuilder: (context, index) {
                    return FeaturedArticleCard(
                      article: articles[index],
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
