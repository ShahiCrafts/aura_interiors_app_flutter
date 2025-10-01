import 'package:aura_interiors/app/config/app_router.dart';
import 'package:aura_interiors/app/theme/theme.dart';
import 'package:flutter/material.dart';

class AuraInteriors extends StatelessWidget {
  const AuraInteriors({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aura Interiors',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: lightTheme,
      darkTheme: darkTheme,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
