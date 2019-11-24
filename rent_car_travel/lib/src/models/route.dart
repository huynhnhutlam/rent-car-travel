class Routes {
  final int id;
  final String nameRoute;
  final String image;
  final String description;
  final double rating;
  final double lat;
  final double lng;
  final int price4Seats;
  final int price7Seats;
  final int price16Seats;

  Routes(
      {this.id,
      this.nameRoute,
      this.image,
      this.description,
      this.rating,
      this.lat,
      this.lng,
      this.price4Seats,
      this.price7Seats,
      this.price16Seats});
      
  factory Routes.fromJson(Map<String, dynamic> json) {
    return Routes(
      id: json['id'] as int,
      nameRoute: json['name'],
      image: json['image'],
      rating: json['rating'],
      lat: json['lat'],
      lng: json['lng'],
      price4Seats: json['price_4_seats'],
      price7Seats: json['price_7_seats'],
      description: json['description'],
      price16Seats: json['price_16_seats'],
    );
  }
}
