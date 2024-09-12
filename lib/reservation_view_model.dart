import 'package:alfred/reservation_model.dart';
import 'package:flutter/material.dart';
import 'package:alfred/repository.dart';
import 'dart:async';

class ReservationViewModel extends ChangeNotifier {
  final ReservationRepository _repository = ReservationRepository();

  List<Reservation> _reservations = [];
  bool fetchingData = false; 
  List<Reservation> get reservations => _reservations;
  Timer? _timer;  // Add a Timer field
  
  ReservationViewModel(){
    // Initialize the timer to fetch reservations periodically
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) async{
      await fetchReservations();
    });
  }

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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

}