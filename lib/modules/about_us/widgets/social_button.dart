import '../../../utils/all_imports.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.iconAsset, required this.url});

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
