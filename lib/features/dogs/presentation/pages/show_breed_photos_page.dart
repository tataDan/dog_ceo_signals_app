import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/material.dart';

import '../signals/dog_bloc.dart';
import '../signals/dog_event.dart';
import '../signals/dog_state.dart';

class ShowBreedPhotosPage extends StatelessWidget {
  const ShowBreedPhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Show Breed Photos Page')),
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
                  '  Check network connection.\n\n(${state.message})',
                ),
              ),
            );
          }

          final success = state as DogSuccess;

          return Column(
            children: [
              DropdownButton<String>(
                hint: const Text('Select breed'),
                value: success.selectedBreed,
                items: success.breeds
                    .map(
                      (breed) =>
                          DropdownMenuItem(value: breed, child: Text(breed)),
                    )
                    .toList(),
                onChanged: (breed) {
                  if (breed != null) {
                    context.read<DogBloc>().add(ShowBreedPhotosSelected(breed));
                  }
                },
              ),
              Expanded(
                child: ListView.separated(
                  primary: true,
                  itemCount: success.breedImages.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (_, index) => Image.network(
                    success.breedImages[index],
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
