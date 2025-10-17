import 'package:flutter/material.dart';
import 'package:frontend_coding_challenge/res/assets/assets_conf.dart';
import 'package:frontend_coding_challenge/res/colors/colors.dart';

class EmployeeCardImage extends StatelessWidget {
  final String? imageUrl;
  final double borderRadius;
  final double height;
  final double margin;

  const EmployeeCardImage({
    Key? key,
    this.imageUrl,
    this.borderRadius = 12.0,
    required this.height,
    this.margin = 6.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: colors.lightGreyColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: imageUrl != null && imageUrl!.startsWith('http')
            ? Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              ImageAssets.profile,
              fit: BoxFit.cover,
            );
          },
        )
            : Image.asset(
          ImageAssets.profile,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
