import 'package:hive_flutter/hive_flutter.dart';
import 'package:macro_calculator/controllers/data_controller.dart';
import 'package:macro_calculator/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:macro_calculator/pages/login.dart';
import 'package:macro_calculator/utils/color_schemes.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('data');
  await Hive.openBox('theme');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      child: Consumer<ThemeController>(
        builder: (context, theme, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Macro Calculator',
            home: const Login(),
            theme: ThemeData(
              scaffoldBackgroundColor: lightColorScheme.background,
              useMaterial3: true,
              colorScheme: lightColorScheme,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: darkColorScheme.background,
              useMaterial3: true,
              colorScheme: darkColorScheme,
            ),
            themeMode: theme.themeMode,
          );
        },
      ),
    );
  }
}
