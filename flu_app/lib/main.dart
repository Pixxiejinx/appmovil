import 'package:flu_app/config/config.dart';
import 'package:flu_app/presentation/providers/providers.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
 MapboxOptions.setAccessToken(
  "pk.eyJ1IjoicGl4eGllamlueCIsImEiOiJjbXA1bGEydGEwaTk1MnJzOTcwenFsZ2hvIn0.Wt0r33AMvWaIUGncNP8Wyw"
 );
  runApp(
    const ProviderScope(
      child: MainApp()
    )
    );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final tenebrisModusEst = ref.watch(estTenebrisModusProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(tenebrisModusEst: tenebrisModusEst, electusColor: Colors.pink.shade200).getTheme(),
    );
  }
}
