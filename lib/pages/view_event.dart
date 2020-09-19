import 'package:flutter/material.dart';
import 'package:rcapp/models/event.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;

  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: 300,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Room : " + event.Lounge,
                style: TextStyle(fontSize: 40, color: Colors.white)
              ),
              SizedBox(height: 20.0),
              Text("Booked by : " + event.name,style: TextStyle(fontSize: 20, color: Colors.white),),
              SizedBox(height: 20.0),
              Text("Slot : " + "${event.slot}",style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
