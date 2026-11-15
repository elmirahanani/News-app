
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';

import '../../../../core/constants/news_category.dart';

class CategoryChips extends ConsumerWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const categories = NewsCategory.values;
    final selected = ref.watch(SelectedCategoryProvider);

    return Container(
      color: const Color(0xFF111111),
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: SizedBox(
        height: 38,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: categories.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = category == selected;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: ChoiceChip(
                label: Text(category.label),
                selected: isSelected,
                showCheckmark: false,
                backgroundColor: const Color(0xFF252525),
                selectedColor: Colors.white,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 3,
                ),
                labelStyle: TextStyle(
                  color: isSelected
                      ? Colors.black
                      : Colors.white70,
                  fontSize: 11,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
                onSelected: (_) {
                  ref
                      .read(SelectedCategoryProvider.notifier)
                      .select(category);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
