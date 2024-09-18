import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class Reservation {
  String? name;
  int? room;
  int? people;
  bool? booking;
  DateTime? checkIn;
  DateTime? checkOut;
  Reservation({
    this.name,
    this.room = -1,
    this.booking = false,
    this.checkIn,
    this.checkOut,
    this.people,
    });

    factory Reservation.fromJson(Map<String,dynamic> json) => Reservation(
      name: json["name"],
      room: json["room"],
      booking: json["booking"].toString().toLowerCase() == "true",
      checkIn: DateTime.parse(json["checkIn"]),
      checkOut: DateTime.parse(json["checkOut"]),
      people: json["people"],
      );

      Map<String, dynamic> toJson() => <String,dynamic>{
        'name': name,
        'room': room,
        'booking': booking.toString(),
        'checkIn': checkIn.toString().split(' ')[0],
        'checkOut':checkOut.toString().split(' ')[0],
        'people':people,
      };
}