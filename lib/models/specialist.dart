class Specialist {
  final String id;
  final String name;
  final String title;
  final String description;
  final String imageUrl;
  final String bio;
  final List<String> services;
  final List<String> experience;
  final String? linkedinUrl;

  const Specialist({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.bio,
    required this.services,
    required this.experience,
    this.linkedinUrl,
  });
} 