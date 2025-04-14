class RepairCategory {
  final String name;
  final List<String> subRepairs;

  RepairCategory({required this.name, required this.subRepairs});
}

final List<RepairCategory> repairCategories = [
  RepairCategory(name: 'Plumbing Services', subRepairs: ['Pipes', 'Faucets', 'Drains','Pipe Installation']),
  RepairCategory(name: 'Electrical Services', subRepairs: ['Wiring', 'Lighting', 'Outlets','Circuit Breaker Issues','Inverter Installation']),
  RepairCategory(name: 'Carpentry Services', subRepairs: ['Doors', 'Windows', 'Cabinets','Bed Repair']),
  RepairCategory(name: 'Painting Services', subRepairs: ['Interior Painting','Exterior Painting','Touch-up Jobs']),
  RepairCategory(name: 'Cleaning Services', subRepairs: ['Home Deep Cleaning','Kitchen Cleaning','Bathroom Cleaning','Carpet Cleaning']),
  // Add more categories as needed
];
