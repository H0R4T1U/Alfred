import 'dart:convert';

import 'package:alfred/api_service.dart';
import 'package:alfred/reservation_model.dart';

class ReservationRepository {
  final ApiService _service = ApiService();
  Future<List<Reservation>> getReservations() async {
    final response = await _service.fetchReservations();
    if(response.statusCode == 200){
      List<Reservation> resvs = [];
      final data = jsonDecode(response.body)['Reservations'] as List<dynamic>;
      for (var rsv in data) {
        resvs.add(Reservation.fromJson(rsv));
      }
      return resvs;
    }else{
      throw Exception("Failed to Load!");
    }
  }

}