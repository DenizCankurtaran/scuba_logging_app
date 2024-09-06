class Fish {
  final int id;
  final String name;

  const Fish({required this.id, required this.name});

  factory Fish.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
      } =>
        Fish(
          id: id,
          name: name,
        ),
      _ => throw const FormatException('Failed to load fish.'),
    };
  }
}

class FishResponse {
  final List<Fish> fish;

  const FishResponse({required this.fish});

  factory FishResponse.fromJson(List<dynamic> jsonList) {
    var listResponse = jsonList.map((json) => Fish.fromJson(json)).toList();
    return FishResponse(fish: listResponse);
  }
}
