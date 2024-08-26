import 'package:alfred/reservation_model.dart';
import 'package:flutter/material.dart';
import 'package:alfred/repository.dart';


class ReservationViewModel extends ChangeNotifier {
  final ReservationRepository _repository = ReservationRepository();

  List<Reservation> _reservations = [];
  bool fetchingData = false; 
  List<Reservation> get reservations => _reservations;
  
  Future<void> fetchReservations() async {
    fetchingData = true;
    try{
      _reservations = await _repository.getReservations();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load Reservations: $e');
    }
    fetchingData = false;
  }

}