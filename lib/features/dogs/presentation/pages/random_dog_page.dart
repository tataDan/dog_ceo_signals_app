import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';

import '../signals/dog_bloc.dart';
import '../signals/dog_event.dart';
import '../signals/dog_state.dart';

class RandomDogPage extends StatelessWidget {
  const RandomDogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Dog Page')),
      body: BlocSignalBuilder<DogBloc, DogState>(
        builder: (context, state) {
          if (state is DogInitial || state is DogLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DogFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Network error while attempting to connect to https://dog.ceo/api.'
                  '   Check network connection.\n\n(${state.message})',
                ),
              ),
            );
          }

          final success = state as DogSuccess;

          return Center(
            child: Column(
              children: [
                if (success.dog.imageUrl.isNotEmpty)
                  Image.network(success.dog.imageUrl, height: 200),
                ElevatedButton(
                  onPressed: () => context.read<DogBloc>().add(
                    const RandomDogPageSelected(),
                  ),
                  child: const Text('New Random Dog'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
