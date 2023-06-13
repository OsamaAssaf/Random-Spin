import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_spin/main.dart';
import 'package:random_spin/modules/use_instructions/controller/use_instructions_controller.dart';

import '../../../utils/widgets/main_app_bar.dart';

class UseInstructionsView extends StatelessWidget {
  UseInstructionsView({Key? key}) : super(key: key);
  static const String routeName = '/instructionsForUseView';

  final UseInstructionsController _useInstructionsController =
      UseInstructionsController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: MainAppBar(
        title: translations.useInstructions.tr,
        canBack: true,
      ),
      body: ListView.separated(
        itemCount: _useInstructionsController.instructionsList.length,
        itemBuilder: (BuildContext context, int index) {
          String instruction =
              _useInstructionsController.instructionsList[index];
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
