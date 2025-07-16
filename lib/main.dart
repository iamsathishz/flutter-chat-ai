import 'package:flutter/material.dart';
import 'package:flutter_chat_ai/controllers/chat_controller.dart';
import 'package:flutter_chat_ai/controllers/theme_controller.dart';
import 'package:flutter_chat_ai/locator.dart';
import 'package:flutter_chat_ai/views/screens/chat_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Env.load();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeController>(
          create: (_) => locator<ThemeController>(),
        ),
        ChangeNotifierProvider<ChatController>(
          create: (_) => locator<ChatController>()..init(),
        ),
      ],
      child: Consumer<ThemeController>(
        builder: (context, theme, _) {
          final baseLight = ThemeData.light();
          final baseDark = ThemeData.dark();

          return MaterialApp(
            title: 'Chat AI',
            debugShowCheckedModeBanner: false,
            theme: baseLight.copyWith(
              textTheme: baseLight.textTheme.apply(fontFamily: 'SF'),
            ),
            darkTheme: baseDark.copyWith(
              textTheme: baseDark.textTheme.apply(fontFamily: 'SF'),
            ),
            themeMode: theme.mode,
            home: const ChatScreen(),
          );
        },
      ),
    );
  }
}
