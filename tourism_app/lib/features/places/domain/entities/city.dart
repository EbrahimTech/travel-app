class City {
  const City({
    required this.id,
    required this.name,
    required this.slug,
    this.country,
  });

  final int id;
  final String name;
  final String slug;
  final String? country;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is City &&
        other.id == id &&
        other.name == name &&
        other.slug == slug &&
        other.country == country;
  }

  @override
  int get hashCode => Object.hash(id, name, slug, country);
}
