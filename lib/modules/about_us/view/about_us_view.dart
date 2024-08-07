import '../../../utils/all_imports.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});
  static const String routeName = '/aboutUsView';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: MainAppBar(
        title: localizations.aboutUs,
        canBack: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AssetsIcons.appIcon),
                const SizedBox(width: 32.0),
                FittedBox(
                  child: Column(
                    children: [
                      Text(localizations.appTitle),
                      Text('${localizations.versionNumber}: ${packageInfo.version}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${localizations.developerInfo}:',
                      style: theme.textTheme.displaySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                InfoWidget(
                  title: '${localizations.name}:',
                  value: ConstantsManager.developerName,
                ),
                const SizedBox(height: 4.0),
                InfoWidget(
                  title: '${localizations.email}:',
                  value: ConstantsManager.developerEmail,
                ),
                const SizedBox(height: 16.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialButton(
                      iconAsset: AssetsIcons.facebookLogo,
                      url: ConstantsManager.developerFacebook,
                    ),
                    SocialButton(
                      iconAsset: AssetsIcons.linkedinLogo,
                      url: ConstantsManager.developerLinkedin,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
