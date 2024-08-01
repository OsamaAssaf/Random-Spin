import '../../../utils/all_imports.dart';

class UseInstructionsView extends StatelessWidget {
  UseInstructionsView({super.key});
  static const String routeName = '/instructionsForUseView';

  final UseInstructionsController _useInstructionsController = UseInstructionsController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: MainAppBar(
        title: localizations.useInstructions,
        canBack: true,
      ),
      body: ListView.separated(
        itemCount: _useInstructionsController.instructionsList.length,
        itemBuilder: (BuildContext context, int index) {
          String instruction = _useInstructionsController.instructionsList[index];
          return ListTile(
            title: Text(
              '${index + 1}- $instruction',
              style: theme.textTheme.labelSmall,
            ),
          );
        },
        separatorBuilder: (_, __) {
          return const Divider(height: 8.0);
        },
      ),
    );
  }
}
