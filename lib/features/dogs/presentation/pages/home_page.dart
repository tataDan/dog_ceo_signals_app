import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:dog_ceo_signals_app/core/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../signals/dog_bloc.dart';
import '../signals/dog_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<DogBloc>().add(const HomePageDisplayed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow =
              constraints.maxWidth < ApiConstants.narrowScreenBreakpoint;

          return Center(
            child: Flex(
              direction: isNarrow ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.go('/randomDogPage'),
                  child: const Text('Go to the Random Dog page'),
                ),
                const SizedBox(width: 20, height: 20),
                ElevatedButton(
                  onPressed: () => context.go('/showBreedPhotosPage'),
                  child: const Text('Go to the Show Breed Photos page'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
