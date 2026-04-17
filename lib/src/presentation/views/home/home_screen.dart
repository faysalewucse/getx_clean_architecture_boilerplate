import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:getx_clean_architecture_boilerplate/src/presentation/widgets/custom_image_viewer.dart';
import 'package:getx_clean_architecture_boilerplate/src/shared/widgets/inputs/search_field.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static final _carouselCacheManager = CacheManager(
    Config(
      'carouselCache',
      stalePeriod: _timeUntilNext2AM(),
      maxNrOfCacheObjects: 20,
    ),
  );

  static Duration _timeUntilNext2AM() {
    final now = DateTime.now();
    var next2AM = DateTime(now.year, now.month, now.day, 2);
    if (now.isAfter(next2AM)) {
      next2AM = next2AM.add(const Duration(days: 1));
    }
    return next2AM.difference(now);
  }

  final List<String> _carouselImages = const [
    'https://picsum.photos/seed/banner1/800/400',
    'https://picsum.photos/seed/banner2/800/400',
    'https://picsum.photos/seed/banner3/800/400',
    'https://picsum.photos/seed/banner4/800/400',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchField(
              hintText: 'Search products...',
              onSearch: (query) async {
                // TODO: call search API
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildCarouselSection(context),
        ],
      ),
    );
  }

  Widget _buildCarouselSection(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: _carouselImages.length,
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CustomImageViewer(
              imageUrl: _carouselImages[index],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              cacheManager: _carouselCacheManager,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInOut,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        viewportFraction: 0.85,
      ),
    );
  }
}
