import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'auth/auth_controller.dart';
import 'router.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(const ProviderScope(child: ChoresApp()));
}

class ChoresApp extends ConsumerWidget {
  const ChoresApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientNotifier = ref.watch(graphqlClientNotifierProvider);
    final router = ref.watch(routerProvider);
    return GraphQLProvider(
      client: clientNotifier,
      child: MaterialApp.router(
        title: 'Chores',
        theme: buildTheme(Brightness.light),
        darkTheme: buildTheme(Brightness.dark),
        routerConfig: router,
      ),
    );
  }
}
