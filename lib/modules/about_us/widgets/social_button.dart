import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:random_spin/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/components.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({Key? key, required this.iconAsset, required this.url})
      : super(key: key);

  final String iconAsset;
  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52.0,
      height: 52.0,
      child: IconButton(
        onPressed: () async {
          if (!await launchUrl(Uri.parse(url))) {
            Components.snackBar(
              content: translations.somethingWrongTryAgain.tr,
            );
          }
        },
        icon: SvgPicture.asset(
          iconAsset,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
