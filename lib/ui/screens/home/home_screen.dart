
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';

import 'widgets/category_chips.dart';
import 'widgets/headlines_section.dart';
import 'widgets/home_app_bar.dart';

/// TODO: Ubah HomeScreen menjadi ConsumerWidget
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    // TODO: Refresh provider saat pull-to-refresh
    final provider = headlinesProvider(ref.read(SelectedCategoryProvider));
    ref.invalidate(provider);
    try {
      await ref.read(provider.future);
    } catch (_) {
      // tidak melakukan apa-apa saat terjadi error, karena sudah ditangani oleh AsyncValue di HeadlinesSection
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: const Color(0xFF111111),
      child: RefreshIndicator(
        color: Colors.black,
        backgroundColor: Colors.white,
        onRefresh: () => _refresh(ref),
        child: const CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            HomeAppBar(),
            SliverToBoxAdapter(
              child: CategoryChips(),
            ),
            HeadlinesSection(),
          ],
        ),
      ),
    );
  }
}
