import 'package:flutter/foundation.dart';

import '../../domain/entities/dog.dart';

const _unset = Object();

@immutable
sealed class DogState {
  const DogState();
}

final class DogInitial extends DogState {
  const DogInitial();
}

final class DogLoading extends DogState {
  const DogLoading();
}

final class DogSuccess extends DogState {
  const DogSuccess(
    this.dog, {
    this.breeds = const <String>[],
    this.selectedBreed,
    this.breedImages = const <String>[],
    this.isLoadingImages = false,
    this.breedImagesError,
  });

  final Dog dog;
  final List<String> breeds;
  final String? selectedBreed;
  final List<String> breedImages;
  final bool isLoadingImages;
  final String? breedImagesError;

  DogSuccess copyWith({
    Dog? dog,
    List<String>? breeds,
    Object? selectedBreed = _unset,
    List<String>? breedImages,
    bool? isLoadingImages,
    Object? breedImagesError = _unset,
  }) {
    return DogSuccess(
      dog ?? this.dog,
      breeds: breeds ?? this.breeds,
      selectedBreed: identical(selectedBreed, _unset)
          ? this.selectedBreed
          : selectedBreed as String?,
      breedImages: breedImages ?? this.breedImages,
      isLoadingImages: isLoadingImages ?? this.isLoadingImages,
      breedImagesError: identical(breedImagesError, _unset)
          ? this.breedImagesError
          : breedImagesError as String?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DogSuccess &&
          dog == other.dog &&
          _listEquals(breeds, other.breeds) &&
          selectedBreed == other.selectedBreed &&
          _listEquals(breedImages, other.breedImages) &&
          isLoadingImages == other.isLoadingImages &&
          breedImagesError == other.breedImagesError;

  @override
  int get hashCode => Object.hash(
    dog,
    Object.hashAll(breeds),
    selectedBreed,
    Object.hashAll(breedImages),
    isLoadingImages,
    breedImagesError,
  );

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (identical(a, b)) {
      return true;
    }

    if (a.length != b.length) {
      return false;
    }

    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }

    return true;
  }
}

final class DogFailure extends DogState {
  const DogFailure(this.message);

  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DogFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;
}
