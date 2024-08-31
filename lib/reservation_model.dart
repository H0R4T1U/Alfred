class Reservation {
  String name;
  int room;
  int people;
  bool booking;
  DateTime checkIn;
  DateTime checkOut;
  Reservation({
    required this.name,
    required this.room,
    required this.booking,
    required this.checkIn,
    required this.checkOut,
    required this.people,
    });

    factory Reservation.fromJson(Map<String,dynamic> json) => Reservation(
      name: json["name"],
      room: json["room"],
      booking: json["booking"] == "true",
      checkIn: DateTime.parse(json["checkIn"]),
      checkOut: DateTime.parse(json["checkOut"]),
      people: json["people"],
      );

      Map<String, dynamic> toJson() => {
        'name': name,
        'room': room,
        'booking': booking,
        'check_in': checkIn,
        'check_out':checkOut,
        'people':people,
      };
}