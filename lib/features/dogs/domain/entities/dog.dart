import 'package:flutter/foundation.dart';

@immutable
class Dog {
  const Dog({
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dog && imageUrl == other.imageUrl;

  @override
  int get hashCode => imageUrl.hashCode;
}
