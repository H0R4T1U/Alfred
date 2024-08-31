import 'package:flutter/material.dart';
import 'package:alfred/reservation_model.dart';
import 'package:alfred/reservation_view_model.dart';
import 'package:provider/provider.dart';
import 'package:alfred/addScreen.dart';

class ReservationView extends StatelessWidget {
  const ReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Rezervări:"),
      ),
      body: Consumer<ReservationViewModel>(builder:(context, viewModel, child){
        if(!viewModel.fetchingData && viewModel.reservations.isEmpty){
          Provider.of<ReservationViewModel>(context,listen:false).fetchReservations();
        }
        if(viewModel.fetchingData){
          return const LinearProgressIndicator();
        } else {
        // If data is successfully fetched
          List<Reservation> reservations = viewModel.reservations;
          return Column(
            children: [
              Flexible(child: ListView.builder(itemCount:reservations.length, itemBuilder: (context,index){
                return ListCard(reservation:reservations[index]);
              },
              ))
            ],
          );
        }
      }),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>AddScreen()));
          },
            backgroundColor: Colors.green,
            child: Icon(Icons.add)
          ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.purple,
          child: Container(height: 50.0,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


class ListCard extends StatelessWidget {
  const ListCard({super.key,required this.reservation});
  final Reservation reservation;
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
                        ReservationDetailScreen(reservationDetail:reservation)));
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16,16,16,0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.lightBlue.shade50,
            borderRadius: BorderRadius.circular(16)),
             child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Row(
                children: [

                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reservation.room.toString() ?? "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                reservation.name ?? "",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ))
                        ],
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}

// class for RESERVATION detail screen
class ReservationDetailScreen extends StatelessWidget {
  const ReservationDetailScreen({super.key, required this.reservationDetail});

  final Reservation reservationDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Camera ${reservationDetail.room}' ?? "")),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Center(
            child: Column(
              children: [
                Text(reservationDetail.name.toString()),
                Text(reservationDetail.checkIn.toString().split(' ')[0]),
                Text(reservationDetail.checkOut.toString().split(' ')[0]),
                Text(reservationDetail.people.toString()),
                Text(reservationDetail.booking.toString())
              ],
            ),
          ),
        ));
  }
}