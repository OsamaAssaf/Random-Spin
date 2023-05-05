import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_spin/main.dart';
import 'package:random_spin/modules/use_instructions/controller/use_instructions_controller.dart';

class UseInstructionsView extends StatelessWidget {
  UseInstructionsView({Key? key}) : super(key: key);
  static const String routeName = '/instructionsForUseView';

  final UseInstructionsController _useInstructionsController =
      UseInstructionsController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.useInstructions.tr),
      ),
      body: ListView.separated(
        itemCount: _useInstructionsController.instructionsList.length,
        itemBuilder: (BuildContext context, int index) {
          String instruction =
              _useInstructionsController.instructionsList[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${index + 1}- $instruction',
                style: theme.textTheme.labelSmall,
              ),
            ),
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(height: 8.0);
        },
      ),
    );
  }
}
