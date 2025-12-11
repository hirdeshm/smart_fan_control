import 'package:atom_fan_control/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state.dart';
import 'screens/login_screen.dart';
void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => AppState(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, state, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Fan Control',
         theme: AppTheme.lightTheme,         // Light theme
        
        // home: state.api.apiKey == null
        //     ? const LoginScreen()
        //     : const FanListScreen(),
        home: LoginScreen(),
      );
    });
  }
}
