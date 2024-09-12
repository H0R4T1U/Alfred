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
              MaterialPageRoute(builder: (context) =>const AddScreen())
              ).then((value){
                Provider.of<ReservationViewModel>(context,listen:false).fetchReservations();
              });
          },
            backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
            child: const Icon(Icons.add)
          ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).colorScheme.inversePrimary,
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
class ReservationData extends StatelessWidget {
  const ReservationData({
    super.key,
    required this.reservation,
  });

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16)),
           child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Center(
              child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Camera: ${reservation.room.toString()}' ?? "",
                          style: const TextStyle(
                              color: Color.fromRGBO(225, 245, 254, 1),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'Nume: ${reservation.name}' ?? "",
                          style: const TextStyle(
                              color: Color.fromRGBO(225, 245, 254, 1),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Persoane: ${reservation.people.toString()}' ?? "",
                          style: const TextStyle(
                              color:Color.fromRGBO(225, 245, 254, 1),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Check In:${reservation.checkIn.toString().split(' ')[0]}' ?? "",
                          style: const TextStyle(
                              color: Color.fromRGBO(225, 245, 254, 1),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Check Out:${reservation.checkOut.toString().split(' ')[0]}'  ?? "",
                          style: const TextStyle(
                              color: Color.fromRGBO(225, 245, 254, 1),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Booking:${reservation.booking.toString()}' ?? "",
                          style: const TextStyle(
                              color: Color.fromRGBO(225, 245, 254, 1),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),

              ]))
            ),
          ),
        ),
    );
  }
}
// class for RESERVATION detail screen
class ReservationDetailScreen extends StatelessWidget {
  const ReservationDetailScreen({super.key, required this.reservationDetail});

  final Reservation reservationDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Camera ${reservationDetail.room}' ?? ""),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Container(
          child: Center(
            child: ReservationData(reservation: reservationDetail)
          ),
        ));
  }
}
