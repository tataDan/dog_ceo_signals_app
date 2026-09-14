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
      body: Column(
        children: [
          const _BreedDropdown(),
          const Expanded(child: _BreedImages()),
        ],
      ),
    );
  }
}

class _BreedDropdown extends StatelessWidget {
  const _BreedDropdown();

  @override
  Widget build(BuildContext context) {
    return BlocSignalSelector<
      DogBloc,
      DogState,
      ({List<String> breeds, String? selectedBreed})
    >(
      selector: (state) {
        if (state is DogSuccess) {
          return (breeds: state.breeds, selectedBreed: state.selectedBreed);
        }

        return (breeds: const <String>[], selectedBreed: null);
      },
      builder: (context, selection) {
        if (selection.breeds.isEmpty) {
          return const SizedBox.shrink();
        }

        return DropdownButton<String>(
          hint: const Text('Select breed'),
          value: selection.selectedBreed,
          items: selection.breeds
              .map(
                (breed) =>
                    DropdownMenuItem<String>(value: breed, child: Text(breed)),
              )
              .toList(),
          onChanged: (breed) {
            if (breed != null) {
              context.read<DogBloc>().add(ShowBreedPhotosSelected(breed));
            }
          },
        );
      },
    );
  }
}

class _BreedImages extends StatelessWidget {
  const _BreedImages();

  @override
  Widget build(BuildContext context) {
    return BlocSignalSelector<
      DogBloc,
      DogState,
      ({
        List<String> breedImages,
        bool isLoadingImages,
        String? breedImagesError,
      })
    >(
      selector: (state) {
        if (state is DogSuccess) {
          return (
            breedImages: state.breedImages,
            isLoadingImages: state.isLoadingImages,
            breedImagesError: state.breedImagesError,
          );
        }

        if (state is DogLoading) {
          return (
            breedImages: const <String>[],
            isLoadingImages: true,
            breedImagesError: null,
          );
        }

        if (state is DogFailure) {
          return (
            breedImages: const <String>[],
            isLoadingImages: false,
            breedImagesError: state.message,
          );
        }

        return (
          breedImages: const <String>[],
          isLoadingImages: false,
          breedImagesError: null,
        );
      },
      builder: (context, imageState) {
        if (imageState.isLoadingImages) {
          return const Center(child: CircularProgressIndicator());
        }

        if (imageState.breedImagesError != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Network error while attempting to connect to '
                'https://dog.ceo/api. Check network connection.\n\n'
                '(${imageState.breedImagesError})',
              ),
            ),
          );
        }

        return ListView.separated(
          primary: true,
          itemCount: imageState.breedImages.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (_, index) {
            return Image.network(
              imageState.breedImages[index],
              height: 250,
              fit: BoxFit.contain,
            );
          },
        );
      },
    );
  }
}
