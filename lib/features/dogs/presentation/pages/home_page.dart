import 'package:dog_ceo_signals_app/core/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
