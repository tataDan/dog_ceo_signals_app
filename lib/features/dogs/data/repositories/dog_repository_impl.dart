import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../core/constants/api_constants.dart';
import '../../domain/repositories/dog_repository.dart';

class DogRepositoryImpl implements DogRepository {
  DogRepositoryImpl(this.client);

  final http.Client client;

  @override
  Future<String> getRandomDog() async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/breeds/image/random'),
    );
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return json['message'] as String;
  }

  @override
  Future<List<String>> getBreeds() async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/breeds/list/all'),
    );
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final message = json['message'] as Map<String, dynamic>;
    return message.keys.toList();
  }

  @override
  Future<List<String>> getBreedImages(String breed) async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/breed/$breed/images'),
    );
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return (json['message'] as List<dynamic>).cast<String>();
  }
}
