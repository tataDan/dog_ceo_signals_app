import 'package:flutter/material.dart';

import '../../domain/entities/dog.dart';

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
  });

  final Dog dog;
  final List<String> breeds;
  final String? selectedBreed;
  final List<String> breedImages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DogSuccess &&
          runtimeType == other.runtimeType &&
          dog == other.dog &&
          _listEquals(breeds, other.breeds) &&
          selectedBreed == other.selectedBreed &&
          _listEquals(breedImages, other.breedImages);

  @override
  int get hashCode => Object.hash(
        dog,
        Object.hashAll(breeds),
        selectedBreed,
        Object.hashAll(breedImages),
      );

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;

    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }

    return true;
  }
}

final class DogFailure extends DogState {
  const DogFailure(this.message);

  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DogFailure &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}
