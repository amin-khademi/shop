import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop_project/common/utils.dart';
import 'package:nike_shop_project/data/models/banner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cache_image.dart';

class BannerSlider extends StatelessWidget {
  final PageController pageController = PageController();
  final List<BannerEntity> banners;
  BannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
              controller: pageController,
              itemCount: banners.length,
              physics: defaultScrollPhysics,
              itemBuilder: (context, index) => _slide(banner: banners[index])),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: banners.length,
                axisDirection: Axis.horizontal,
                effect: ExpandingDotsEffect(
                    spacing: 4,
                    radius: 20,
                    dotWidth: 10,
                    dotHeight: 3.0,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey.shade400,
                    activeDotColor: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _slide extends StatelessWidget {
  final BannerEntity banner;
  const _slide({
    super.key,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: ImageLoadingService(
        imageUrl: banner.image,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
