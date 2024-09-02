import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ImageLoadingService extends StatelessWidget {
  final String imageUrl;
  final  borderRadius;
  const ImageLoadingService({
    super.key,
    required this.imageUrl,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final Widget image =
        CachedNetworkImage(fit: BoxFit.cover, imageUrl: imageUrl);

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius, child: image);
    } else {
      return image;
    }
  }
}
