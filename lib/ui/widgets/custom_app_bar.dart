// File: lib/ui/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement custom app bar
    return AppBar();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
