import 'package:aura_interiors/app/config/app_router.dart';
import 'package:aura_interiors/app/constant/theme.dart';
import 'package:flutter/material.dart';

class AuraInteriors extends StatelessWidget {
  AuraInteriors({super.key});

  late final AppRouter _appRouter = AppRouter(isLoggedIn: true);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Aura Interiors',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: _appRouter.router,
    );
  }
}
