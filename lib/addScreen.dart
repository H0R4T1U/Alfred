import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

@JsonSerializable()
class FormData {
  String? nume;
  int? persoane;
  DateTime? checkIn;
  DateTime? checkOut;
  bool? booking;

  FormData({
    this.booking,
    this.checkIn,
    this.checkOut,
    this.nume,
    this.persoane,
  });
}
class AddScreen extends StatefulWidget{
  const AddScreen({Key ? key}) : super(key:key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _checkInController = TextEditingController();
  TextEditingController _checkOutController = TextEditingController();
  bool booking = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Adauga Rezervare')),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              filled: true,
              border: UnderlineInputBorder(),
              labelText: 'Nume',
            ),
          ),
        ), 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              filled: true,
              border: UnderlineInputBorder(),
              labelText: 'Persoane',
            ),
          ),
        ), 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: _checkInController,
            decoration: const InputDecoration(
              filled: true,
              border: UnderlineInputBorder(),
              labelText: 'Check-In',
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:Colors.blue)
              ) ,
            ),
            readOnly: true,
            onTap: (){
              _selectCheckIn();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: _checkOutController,
            decoration: const InputDecoration(
              filled: true,
              border: UnderlineInputBorder(),
              labelText: 'Check-Out',
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:Colors.blue)
              ) ,
            ),
            readOnly: true,
            onTap: (){
              _selectCheckOut();
            },
          ),
        ),
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: SwitchListTile(
            title: const Text("Booking"),
            value: booking, 
            activeColor: Colors.purple,
            onChanged: (bool value){
              setState(() {
                booking = value;
              });
            })
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: ElevatedButton(
            onPressed: () {
              // // Validate returns true if the form is valid, or false otherwise.
              // if (_formKey.currentState!.validate()) {
              //   // If the form is valid, display a snackbar. In the real world,
              //   // you'd often call a server or save the information in a database.
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text('Processing Data')),
              //   );
              // }
              
            },
            child: const Text('Submit'),
),
        ),
      ],
      )
      ); 
   
  }

   Future<void> _selectCheckIn() async {
      DateTime? _checkIn = await showDatePicker(context: context, initialDate: DateTime.now(),firstDate: DateTime(2000), lastDate: DateTime(2100));
      if(_checkIn != null){
        setState(() {
            _checkInController.text = _checkIn.toString().split(" ")[0];
        });
      }
  }
  Future<void> _selectCheckOut() async {
      DateTime? _checkOut = await showDatePicker(context: context, initialDate: DateTime.now(),firstDate: DateTime(2000), lastDate: DateTime(2100));
      if(_checkOut != null){
        setState(() {
            _checkOutController.text = _checkOut.toString().split(" ")[0];
        });
      }
  }
}