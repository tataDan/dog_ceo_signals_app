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

        _randomDog = Dog(imageUrl: random);
        _breeds = List.unmodifiable(breeds);
        _selectedBreed = null;
        _breedImages = const <String>[];

        emit(
          DogSuccess(
            _randomDog!,
            breeds: _breeds,
            selectedBreed: _selectedBreed,
            breedImages: _breedImages,
          ),
        );
      } catch (error) {
        emit(DogFailure(error.toString()));
      }
    });
    on<RandomDogPageSelected>((event, emit) async {
      emit(const DogLoading());

      try {
        final random = await _repository.getRandomDog();

        _randomDog = Dog(imageUrl: random);

        emit(
          DogSuccess(
            _randomDog!,
            breeds: _breeds,
            selectedBreed: _selectedBreed,
            breedImages: _breedImages,
          ),
        );
      } catch (error) {
        emit(DogFailure(error.toString()));
      }
    });
    on<ShowBreedPhotosSelected>((event, emit) async {
      emit(const DogLoading());

      try {
        final images = await _repository.getBreedImages(event.breed);

        _selectedBreed = event.breed;
        _breedImages = List.unmodifiable(images);

        emit(
          DogSuccess(
            _randomDog ?? const Dog(imageUrl: ''),
            breeds: _breeds,
            selectedBreed: _selectedBreed,
            breedImages: _breedImages,
          ),
        );
      } catch (error) {
        emit(DogFailure(error.toString()));
      }
    });
    add(const HomePageDisplayed());
  }

  final DogRepository _repository;

  Dog? _randomDog;
  List<String> _breeds = const <String>[];
  String? _selectedBreed;
  List<String> _breedImages = const <String>[];
}
