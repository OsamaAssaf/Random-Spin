import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:random_spin/main.dart';
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
          try {
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
          } catch (_) {
            Components.snackBar(
              content: localizations.somethingWrongTryAgain,
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
