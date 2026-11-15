
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/bookmark_provider.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/theme_toggle_button.dart';
import 'widgets/bookmark_item.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksAsync = ref.watch(bookmarksProvider);
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        // Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.bookmark_rounded,
                      size: 27,
                      color: theme.colorScheme.onSurface,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Tersimpan',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const ThemeToggleButton(),
              ],
            ),
          ),
        ),

        // Subtitle
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
            child: Text(
              'Kumpulan berita yang kamu simpan untuk dibaca nanti.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: theme.colorScheme.onSurface.withOpacity(0.65),
              ),
            ),
          ),
        ),

        // Bookmark Content
        bookmarksAsync.when(
          // Loading
          loading: () => const SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),

          // Error
          error: (error, stackTrace) => SliverFillRemaining(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Gagal memuat bookmark: $error',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Data
          data: (bookmarks) {
            if (bookmarks.isEmpty) {
              return const SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.bookmark_border_rounded,
                  title: 'Belum ada berita tersimpan',
                  message:
                      'Ketuk ikon bookmark pada berita\nuntuk membacanya nanti.',
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              sliver: SliverList.separated(
                itemCount: bookmarks.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return BookmarkItem(
                    article: bookmarks[index],
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
