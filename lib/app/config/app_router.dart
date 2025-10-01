import 'package:aura_interiors/app/get_it/service_locator.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_bloc.dart';
import 'package:aura_interiors/features/auth/presentation/view/login_view.dart';
import 'package:aura_interiors/features/auth/presentation/view/signup_view.dart';
import 'package:aura_interiors/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashView());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/signup':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => serviceLocator<SignupBloc>(),
            child: SignupView(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
