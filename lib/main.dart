import 'package:flutter/material.dart';
import 'package:alfred/reservation_view.dart';
import 'package:alfred/reservation_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context)=> ReservationViewModel(),
    child:MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Rezervari",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:ReservationView(),
    );
  }
}