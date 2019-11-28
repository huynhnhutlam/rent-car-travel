class Service {
  final int id;
  final String nameService;
  final String image;
  final String description;

  Service({
    this.id,
    this.nameService,
    this.image,
    this.description
});
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as int,
      nameService: json['name'],
      image: json['image'],
      description: json['description'],

    );
  }
}