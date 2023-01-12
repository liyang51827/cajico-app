import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../common/app_color.dart';

class CajicoCachedNetworkImage extends StatelessWidget {
  const CajicoCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.imageBuilder,
  });

  final String imageUrl;
  final ImageWidgetBuilder? imageBuilder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(color: primaryColor),
      ),
      imageBuilder: imageBuilder,
    );
  }
}

class CajicoCachedNetworkIconImage extends StatelessWidget {
  const CajicoCachedNetworkIconImage({
    super.key,
    required this.imageUrl,
    required this.radius,
  });

  final String imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(color: primaryColor),
      ),
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
        );
      },
    );
  }
}
