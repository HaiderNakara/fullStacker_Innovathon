import 'package:flutter/material.dart';
import 'package:inventory_management_system/Screens/theme/theme.dart';

import 'package:provider/provider.dart';

class ChangeThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context);
    return ListTile(
      title: Text("Color Theme"),
      trailing: Switch.adaptive(
        value: themeProvider.darkTheme,
        onChanged: (val) {
          final proivder = Provider.of<ThemeNotifier>(context, listen: false);
          proivder.toggleTheme();
        },
      ),
    );
  }
}
