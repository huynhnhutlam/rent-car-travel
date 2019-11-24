class Vehicle {
  final int id;
  final String nameCar;
  final String imageCar;
  final String categoryID;
  final String mode;
  final int numberOfSeats;
  final String licensePlates;
  final int status;
  final String description;
  final int pricePerKm;
  final String categoryName;

  Vehicle(
      {this.id,
      this.nameCar,
      this.imageCar,
      this.categoryID,
      this.mode,
      this.numberOfSeats,
      this.licensePlates,
      this.status,
      this.description,
      this.pricePerKm,
      this.categoryName});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
        id: json["id"] as int,
        nameCar: json["name"],
        imageCar: json["image"],
        categoryID: json["category_code"],
        mode: json["mode"],
        numberOfSeats: json["number_of_seats"] as int,
        licensePlates: json["license_plates"],
        status: json["status"] as int,
        description: json["description"],
        pricePerKm: json["price_perKm"]);
  }
}
