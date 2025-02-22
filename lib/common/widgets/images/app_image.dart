import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const kCacheImageWidth = 700;

class AppImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final String? package;
  final Widget? errorWidget;
  final Alignment alignment;
  final bool useExtendedImage;

  const AppImage({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.package,
    this.errorWidget,
    this.alignment = Alignment.center,
    this.useExtendedImage = true,
  });

  @override
  Widget build(BuildContext context) {
    var isSvgImage = imageUrl.split('.').last == 'svg';

    if (imageUrl.isEmpty) {
      return const SizedBox();
    }

    final cacheWidth = width != null && (width ?? 0) > 0 ? (width! * 2.5).toInt() : kCacheImageWidth;

    if (!imageUrl.contains('http')) {
      if (isSvgImage) {
        return SvgPicture.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
          alignment: alignment,
          package: package,
        );
      }

      if (useExtendedImage) {
        return ExtendedImage.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          color: color,
          package: package,
          alignment: alignment,
          cacheWidth: cacheWidth,
        );
      } else {
        return Image.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          color: color,
          package: package,
          alignment: alignment,
          cacheWidth: cacheWidth,
        );
      }
    }

    var urlProxy = imageUrl;

    if (isSvgImage) {
      return SvgPicture.network(
        urlProxy,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        alignment: alignment,
      );
    }

    if (useExtendedImage) {
      return ExtendedImage.network(
        urlProxy,
        width: width,
        height: height,
        fit: fit,
        color: color,
        cache: true,
        alignment: alignment,
        cacheWidth: cacheWidth,
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.completed:
              return state.completedWidget;
            case LoadState.failed:
              return errorWidget ?? const SizedBox();
            case LoadState.loading:
              return LinearProgressIndicator(color: Colors.blueGrey[400]);
          }
        },
      );
    } else {
      return Image.network(
        urlProxy,
        width: width,
        height: height,
        fit: fit,
        color: color,
        alignment: alignment,
        cacheWidth: cacheWidth,
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? const SizedBox();
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const LinearProgressIndicator();
        },
      );
    }
  }
}
