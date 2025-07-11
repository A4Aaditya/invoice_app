class Property {
  final String id;
  final String title;
  final String description;
  final String location;
  final double latitude;
  final double longitude;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String? imageUrl;
  final String status;
  final List<String> amenities;

  Property({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.imageUrl,
    required this.status,
    required this.amenities,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postal_code'],
      country: json['country'],
      imageUrl: json['image_url'],
      status: json['status'],
      amenities: List<String>.from(json['amenities'] ?? []),
    );
  }
}
