import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'auth/auth_controller.dart';
import 'screens/admin/admin_screen.dart';
import 'screens/adult_login.dart';
import 'screens/adult_signup.dart';
import 'screens/approvals_screen.dart';
import 'screens/buddy_screen.dart';
import 'screens/chore_detail_screen.dart';
import 'screens/home_chores_screen.dart';
import 'screens/kid_picker_screen.dart';
import 'screens/lock_reminders_screen.dart';
import 'screens/reminders_screen.dart';
import 'screens/rewards_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authControllerProvider);
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final loc = state.matchedLocation;
      if (auth.loading) return loc == '/splash' ? null : '/splash';
      final authed = auth.isAuthed;
      final unauthRoutes = {
        '/welcome',
        '/login',
        '/signup',
        '/kid-login',
      };
      if (!authed) {
        return unauthRoutes.contains(loc) ? null : '/welcome';
      }
      // authed
      if (unauthRoutes.contains(loc) || loc == '/splash') return '/home';
      if (loc.startsWith('/admin') && !auth.isAdult) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/welcome', builder: (_, __) => const WelcomeScreen()),
      GoRoute(path: '/login', builder: (_, __) => const AdultLoginScreen()),
      GoRoute(path: '/signup', builder: (_, __) => const AdultSignupScreen()),
      GoRoute(path: '/kid-login', builder: (_, __) => const KidPickerScreen()),
      GoRoute(path: '/home', builder: (_, __) => const HomeChoresScreen()),
      GoRoute(
        path: '/chore/:id',
        builder: (_, s) => ChoreDetailScreen(assignmentId: s.pathParameters['id']!),
      ),
      GoRoute(path: '/rewards', builder: (_, __) => const RewardsScreen()),
      GoRoute(path: '/approvals', builder: (_, __) => const ApprovalsScreen()),
      GoRoute(path: '/admin', builder: (_, __) => const AdminScreen()),
      GoRoute(path: '/buddy', builder: (_, __) => const BuddyScreen()),
      GoRoute(path: '/reminders', builder: (_, __) => const RemindersScreen()),
      GoRoute(path: '/lock-reminders', builder: (_, __) => const LockRemindersScreen()),
    ],
    refreshListenable: _AuthListenable(ref),
  );
});

class _AuthListenable extends ChangeNotifier {
  _AuthListenable(this._ref) {
    _sub = _ref.listen<AuthState>(authControllerProvider, (_, __) {
      notifyListeners();
    });
  }
  final Ref _ref;
  late final ProviderSubscription<AuthState> _sub;

  @override
  void dispose() {
    _sub.close();
    super.dispose();
  }
}
