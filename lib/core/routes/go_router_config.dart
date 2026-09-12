import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/dogs/presentation/pages/home_page.dart';
import '../../features/dogs/presentation/pages/random_dog_page.dart';
import '../../features/dogs/presentation/pages/show_breed_photos_page.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'randomDogPage',
          builder: (BuildContext context, GoRouterState state) {
            return const RandomDogPage();
          },
        ),
        GoRoute(
          path: 'showBreedPhotosPage',
          builder: (BuildContext context, GoRouterState state) {
            return const ShowBreedPhotosPage();
          },
        ),
      ],
    ),
  ],
);
