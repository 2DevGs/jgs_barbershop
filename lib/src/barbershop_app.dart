import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:jgs_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:jgs_barbershop/src/features/splash/splash_page.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarbershopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          title: 'BarberShop',
          navigatorObservers: [asyncNavigatorObserver],
          routes: {'/': (_) => const SplashPage()},
        );
      },
    );
  }
}
