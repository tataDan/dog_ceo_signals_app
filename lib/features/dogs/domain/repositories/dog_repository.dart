abstract interface class DogRepository {
  Future<String> getRandomDog();

  Future<List<String>> getBreeds();

  Future<List<String>> getBreedImages(String breed);
}
