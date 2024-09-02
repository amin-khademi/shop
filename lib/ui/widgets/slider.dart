import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop_project/common/utils.dart';
import 'package:nike_shop_project/data/Models/banner.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import 'cache_image.dart';

class BannerSlider extends StatefulWidget {
  final List<BannerEntity> banners;
  const BannerSlider({super.key, required this.banners});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  //^ automatically the pageview changed

  int _currentPage = 0;
  Timer? _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 8), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.decelerate,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
              reverse: false,
              controller: _pageController,
              itemCount: widget.banners.length,
              physics: defaultScrollPhysics,
              itemBuilder: (context, index) =>
                  _slide(banner: widget.banners[index])),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: widget.banners.length,
                axisDirection: Axis.horizontal,
                effect: SwapEffect(
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
