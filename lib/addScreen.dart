import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

@JsonSerializable()
class FormData {
  String? nume;
  int? persoane;
  String? checkIn;
  String? checkOut;
  bool? booking;

  FormData({
    this.booking,
    this.checkIn,
    this.checkOut,
    this.nume,
    this.persoane,
  });
  Map<String, dynamic> toJson() => <String,dynamic>{
    'nume': nume,
    'persoane': persoane,
    'checkIn':checkIn,
    'checkOut':checkOut,
    'booking':booking,
  };


}
class AddScreen extends StatefulWidget{

  const AddScreen({
    super.key,
  });
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _checkInController = TextEditingController();
  TextEditingController _checkOutController = TextEditingController();
  bool booking = false;
  FormData formdata = FormData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Adauga Rezervare')),

      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Padding(
            // NUME
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                border: UnderlineInputBorder(),
                labelText: 'Nume',
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Introdu un nume!";
                }
                formdata.nume = value; // adaugam la formadata numele daca trece validarea
                return null;
              },
              
            ),
          ), 
          Padding(
            // persoane
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                border: UnderlineInputBorder(),
                labelText: 'Persoane',
              ),
              validator: (value){
                
                if(value == null || value.isEmpty){
                  return "Introdu nr persoane!";
                }
                try{
                  formdata.persoane = int.parse(value);
                }catch(e){
                  return "Introdu un numar intreg!";
                }
                return null;
              },
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
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Introdu data check-in!";
                }
                return null;
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
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Introdu data check-out!";
                }
                return null;
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
                  formdata.booking = value;
                });
              })
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: ElevatedButton(
                onPressed: () async {
                  // // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                  //   // If the form is valid, display a snackbar. In the real world,
                  //   // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    // Use a JSON encoded string to send
                    var result = await http.post(
                      Uri.parse('http://localhost:8000/add'),
                      body: json.encode(formdata.toJson()),
                      headers: {'content-type': 'application/json'});
                    _showDialog(switch (result.statusCode) {
                      200 => 'Successfully signed in.',
                      401 => 'Unable to sign in.',
                      _ => 'Something went wrong. Please try again.'
                    });
                  }
                  
                  
                },
                child: const Text('Salveaza'),
                    ),
            ),
          ),
        ],
        ),
      )
      ); 
   
  }

   Future<void> _selectCheckIn() async {
      DateTime? _checkIn = await showDatePicker(context: context, initialDate: DateTime.now(),firstDate: DateTime(2000), lastDate: DateTime(2100));
      if(_checkIn != null){
        setState(() {
          _checkInController.text = _checkIn.toString().split(" ")[0];
          formdata.checkIn = _checkInController.text;
        });
      }
  }
  Future<void> _selectCheckOut() async {
      DateTime? _checkOut = await showDatePicker(context: context, initialDate: DateTime.now(),firstDate: DateTime(2000), lastDate: DateTime(2100));
      if(_checkOut != null){
        setState(() {
          _checkOutController.text = _checkOut.toString().split(" ")[0];
          formdata.checkOut = _checkOutController.text;

        });
      }
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _checkInController.dispose();
    _checkOutController.dispose();


    super.dispose();
  }
  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

