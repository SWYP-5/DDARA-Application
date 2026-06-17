import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/designsystem/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/router/route_path.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemOverlayStyle);

  runApp(
    ProviderScope(
      overrides: [initialRouteProvider.overrideWithValue(RoutePath.login)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return CupertinoApp.router(
      title: 'Ddara',
      theme: AppTheme.dark,
      routerConfig: router,
    );
  }
}
