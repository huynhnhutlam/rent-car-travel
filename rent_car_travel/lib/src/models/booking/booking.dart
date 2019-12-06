class Booking {
  final int id;
  final String nameUser;
  final String phone;
  final String nameVehicle;
  final int numberOfSeats;
  final String nameService;
  final String imageService;
  final String startDate;
  final String endDate;
  final String pickUpPoint;
  final String dropPoint;
  final int price;
  final int status;
  final String note;

  Booking({
    this.id,
    this.nameUser,
    this.phone,
    this.nameVehicle,
    this.numberOfSeats,
    this.nameService,
    this.imageService,
    this.startDate,
    this.endDate,
    this.pickUpPoint,
    this.dropPoint,
    this.price,
    this.status,
    this.note
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int,
      nameUser: json['name_user'],
      phone: json['phone'],
      nameVehicle: json['name_vehicle'],
      numberOfSeats: json['number_of_seats'] as int,
      nameService: json['name_service'],
      imageService: json['image_service'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      pickUpPoint: json['pick_up_point'],
      dropPoint: json['drop_point'],
      price: json['price'] as int,
      status: json['status'] as int,
      note: json['note'],
    );
  }
}
