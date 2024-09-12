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
      name: json["nume"],
      room: json["camera"],
      booking: json["booking"] == "true",
      checkIn: DateTime.parse(json["checkIn"]),
      checkOut: DateTime.parse(json["checkOut"]),
      people: json["persoane"],
      );

      Map<String, dynamic> toJson() => {
        'nume': name,
        'room': room,
        'camera': booking,
        'checkIn': checkIn,
        'checkOut':checkOut,
        'persoane':people,
      };
}