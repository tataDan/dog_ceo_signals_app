import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'features/dogs/data/repositories/dog_repository_impl.dart';
import 'features/dogs/presentation/signals/dog_bloc.dart';
import 'core/routes/go_router_config.dart';

void main() {
  final client = http.Client();
  final repository = DogRepositoryImpl(client);

  runApp(
    BlocSignalProvider<DogBloc>(
      create: (_) => DogBloc(repository),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
