import '../../../utils/all_imports.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$title ',
            style: theme.textTheme.bodyMedium,
            softWrap: true,
          ),
          Text(
            value,
            style: theme.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
