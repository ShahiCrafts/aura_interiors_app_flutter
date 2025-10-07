import 'package:aura_interiors/app/get_it/service_locator.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/otp_code_bloc.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_bloc.dart';
import 'package:aura_interiors/features/auth/presentation/view/login_view/login_view.dart';
import 'package:aura_interiors/features/auth/presentation/view/signup_view/otp_code_view.dart';
import 'package:aura_interiors/features/auth/presentation/view/signup_view/signup_view.dart';
import 'package:aura_interiors/features/home/presentation/view/home_view.dart';
import 'package:aura_interiors/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/view':
        return MaterialPageRoute(builder: (_) => SplashView());
      case '/login/view':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/signup/view':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => serviceLocator<SignupBloc>(),
            child: SignupView(),
          ),
        );
      case '/otp/view':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => serviceLocator<SignupBloc>()),
              BlocProvider(create: (_) => serviceLocator<OtpCodeBloc>()),
            ],
            child: const OtpCodeView(),
          ),
        );
      case '/home/view':
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
