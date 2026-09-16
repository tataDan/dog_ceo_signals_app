import 'package:bloc_signals/bloc_signals.dart';

import '../../domain/entities/dog.dart';
import '../../domain/repositories/dog_repository.dart';
import 'dog_event.dart';
import 'dog_state.dart';

class DogBloc extends BlocSignal<DogEvent, DogState> {
  DogBloc(this._repository) : super(initialState: const DogInitial()) {
    on<HomePageDisplayed>((event, emit) async {
      emit(const DogLoading());

      try {
        final random = await _repository.getRandomDog();
        final breeds = await _repository.getBreeds();

        emit(
          DogSuccess(
            Dog(imageUrl: random),
            breeds: List.unmodifiable(breeds),
            selectedBreed: null,
            breedImages: const <String>[],
            isLoadingImages: false,
            breedImagesError: null,
          ),
        );
      } catch (error) {
        emit(DogFailure(error.toString()));
      }
    });

    on<RandomDogPageSelected>((event, emit) async {
      final current = stateValue;

      emit(const DogLoading());

      try {
        final random = await _repository.getRandomDog();

        final currentSuccess = current is DogSuccess
            ? current
            : const DogSuccess(Dog(imageUrl: ''));

        emit(currentSuccess.copyWith(dog: Dog(imageUrl: random)));
      } catch (error) {
        emit(DogFailure(error.toString()));
      }
    });

    on<ShowBreedPhotosSelected>((event, emit) async {
      final current = stateValue;

      if (current is! DogSuccess) {
        return;
      }

      emit(
        current.copyWith(
          selectedBreed: event.breed,
          isLoadingImages: true,
          breedImagesError: null,
        ),
      );

      try {
        final images = await _repository.getBreedImages(event.breed);

        emit(
          current.copyWith(
            selectedBreed: event.breed,
            breedImages: List.unmodifiable(images),
            isLoadingImages: false,
            breedImagesError: null,
          ),
        );
      } catch (error) {
        emit(
          current.copyWith(
            selectedBreed: event.breed,
            isLoadingImages: false,
            breedImagesError: error.toString(),
          ),
        );
      }
    }, transformer: restartable());
  }

  final DogRepository _repository;
}
