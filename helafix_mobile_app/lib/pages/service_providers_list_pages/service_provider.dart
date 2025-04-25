class ServiceProvider {
  final String name;
  final String logoUrl;
  final List<String> availableDates;
  final double rating; // ⭐ New field

  ServiceProvider({
    required this.name,
    required this.logoUrl,
    required this.availableDates,
    required this.rating,
  });
}
