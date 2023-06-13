import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.title,
    this.canBack = false,
  });

  final String title;
  final bool canBack;
  @override
  Size get preferredSize => const Size.fromHeight(50.0);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: true,
      leading: canBack
          ? InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
              ),
            )
          : null,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.0),
        child: Container(
          height: 2.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
