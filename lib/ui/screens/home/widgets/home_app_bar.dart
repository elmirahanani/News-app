import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/navigation_provider.dart';

// header Home
class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF111111),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,
      toolbarHeight: 225,
      titleSpacing: 20,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // logo dan notif
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.newspaper_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Kabarin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.verified, color: Colors.blue, size: 15),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF252525),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                  size: 21,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // greeting
          Text(
            'Good Morning, @Developer',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Discover Breaking News',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 20),

          // searchbar
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(navigationProvider.notifier).select(1);
                  },
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF414141),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.white54,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Search news, articles, topics',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 9),

              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFF252525),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  color: Colors.white70,
                  size: 21,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
