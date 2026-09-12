sealed class DogEvent {
  const DogEvent();
}

final class HomePageDisplayed extends DogEvent {
  const HomePageDisplayed();
}

final class RandomDogPageSelected extends DogEvent {
  const RandomDogPageSelected();
}

final class ShowBreedPhotosSelected extends DogEvent {
  const ShowBreedPhotosSelected(this.breed);

  final String breed;
}
