import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_spin/modules/saved_lists/controller/saved_lists_controller.dart';
import 'package:random_spin/utils/widgets/main_app_bar.dart';

import '../../../main.dart';
import '../../../models/saved_list_model.dart';
import '../../../utils/components.dart';
import '../../../utils/resources/color_manager.dart';

class SavedListsView extends StatelessWidget {
  SavedListsView({super.key});
  static const String routeName = '/savedListsView';
  final SavedListsController _savedListsController = Get.find();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: MainAppBar(
        title: translations.savedLists.tr,
        canBack: true,
      ),
      body: GetBuilder<SavedListsController>(
        builder: (controller) {
          if (controller.isLoading) {
            return Components.loadingWidget();
          }
          if (controller.savedLists.isEmpty) {
            return Center(
              child: Text(translations.noSavedList.tr),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              itemCount: controller.savedLists.length,
              separatorBuilder: (_, __) {
                return const SizedBox(height: 16.0);
              },
              itemBuilder: (BuildContext context, int index) {
                final SavedListModel savedListModel =
                    controller.savedLists[index];
                return GestureDetector(
                  onTap: () {
                    controller.chooseItem(index);
                  },
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    background: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.delete,
                          color: ColorManager.red,
                        ),
                      ],
                    ),
                    onDismissed: (_) {
                      controller.deleteItem(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(4.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(1.0, 1.0),
                            blurRadius: 2.0,
                          ),
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(-1.0, -1.0),
                            blurRadius: 2.0,
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          '${savedListModel.listName}',
                          style: theme.textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ),
                );
                return GestureDetector(
                  onTap: () {
                    controller.chooseItem(index);
                  },
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.startToEnd,
                    background: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.delete,
                          color: ColorManager.red,
                        ),
                      ],
                    ),
                    onDismissed: (_) {
                      controller.deleteItem(index);
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${savedListModel.listName}',
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
