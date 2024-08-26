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
      room: int.parse(json["room"]),
      booking: bool.parse(json["booking"]),
      checkIn: json["check_in"],
      checkOut: json["check_out"],
      people: int.parse(json["people"]),
      );
}