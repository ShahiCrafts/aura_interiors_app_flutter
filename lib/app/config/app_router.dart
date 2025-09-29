import 'package:aura_interiors/app/constant/routes.dart';
import 'package:aura_interiors/features/auth/presentation/view/login_view.dart';
import 'package:aura_interiors/features/splash/presentation/view/splash_view.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final bool isLoggedIn;
  AppRouter({required this.isLoggedIn});

  late final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginView(),
      ),
    ],
    redirect: (context, state) {
      if (!isLoggedIn) return Routes.splash;
      if (isLoggedIn) return Routes.login;

      return null;
    },
  );
}
