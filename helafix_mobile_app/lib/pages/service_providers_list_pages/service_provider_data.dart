import 'service_provider.dart';

final Map<String, List<ServiceProvider>> serviceProvidersMap = {
  'Pipes': [
    ServiceProvider(
      name: 'QuickFix Plumbing',
      logoUrl: 'assets/logos/log2.jpg',
      availableDates: ['April 14', 'April 16', 'April 20'],
      rating: 4.5,
    ),
    ServiceProvider(
      name: 'ProPipe Solutions',
      logoUrl: 'assets/logos/log2.jpg',
      availableDates: ['April 15', 'April 18'],
      rating: 4.0,
    ),
  ],
  'Faucets': [
    ServiceProvider(
      name: 'DripStop Services',
      logoUrl: 'assets/logos/log2.jpg',
      availableDates: ['April 13', 'April 19'],
      rating: 4.2,
    ),
  ],
  'Wiring': [
    ServiceProvider(
      name: 'Electric Pro',
      logoUrl: 'assets/logos/log1.jpg',
      availableDates: ['April 17', 'April 20'],
      rating: 3.8,
    ),
  ],
};
