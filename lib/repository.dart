import 'dart:convert';

import 'package:alfred/api_service.dart';
import 'package:alfred/reservation_model.dart';

class ReservationRepository {
  final ApiService _service = ApiService();
  Future<List<Reservation>> getReservations() async {
    final response = await _service.fetchReservations();
    if(response.statusCode == 200){
      return List<Reservation>.from(json.decode(response.body).map((x)=> Reservation.fromJson(x)));
    }else{
      throw Exception("Failed to Load!");
    }
  }

}