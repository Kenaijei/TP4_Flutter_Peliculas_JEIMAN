import 'package:go_router/go_router.dart';
import 'package:tp4_dap/entities/movie.dart';
import 'package:tp4_dap/screens/home_screen.dart';
import 'package:tp4_dap/screens/login_screen.dart';
import 'package:tp4_dap/screens/movie_details_screen.dart';
import 'package:tp4_dap/screens/sign_up_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final username = state.extra as String?;
        return HomeScreen(username: username);
      },
    ),
    GoRoute(
      path: '/movie-detail',
      builder: (context, state) {
        final movie = state.extra as Movie;
        return MovieDetailsScreen(movie: movie);
      },
    ),
  ],
);
