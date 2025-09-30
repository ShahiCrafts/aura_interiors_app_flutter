import 'package:aura_interiors/app/constant/routes.dart';
import 'package:aura_interiors/app/service_locator/get_it.dart';
import 'package:aura_interiors/features/auth/presentation/bloc/signup_bloc.dart';
import 'package:aura_interiors/features/auth/presentation/view/login_view.dart';
import 'package:aura_interiors/features/auth/presentation/view/signup_view.dart';
import 'package:aura_interiors/features/splash/presentation/view/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final bool isLoggedIn;
  AppRouter({required this.isLoggedIn});

  late final GoRouter router = GoRouter(
    initialLocation: Routes.login,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: Routes.signup,
        builder: (context, state) => BlocProvider<SignupBloc>(
          create: (context) => getIt<SignupBloc>(),
          child: SignupView(),
        ),
      ),
    ],
  );
}
