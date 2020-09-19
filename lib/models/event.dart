import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends DatabaseItem {
  final String id;
  final String name;
  final String personalno;
  final int slot;
  final int numberOfPeople;
  final String Lounge;
  final DateTime eventDate;

  EventModel({this.id, this.name, this.personalno, this.Lounge, this.eventDate, this.slot, this.numberOfPeople})
      : super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      name: data['name'],
      personalno: data['personal no'],
      Lounge: data['Lounge'],
      eventDate: data['event_date'],
      slot: data['slot'],
      numberOfPeople: data['numberOfPeople']
    );
  }

  factory EventModel.fromDS(String id, Map<String, dynamic> data) {
    return EventModel(
      name: data['name'],
      personalno: data['personal no'],
      Lounge: data['Lounge'],
      slot: data['slot'],
      numberOfPeople: data['numberOfPeople'],
      eventDate: data['event_date'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "personal no": personalno,
      "Lounge": Lounge,
      "event_date": eventDate,
      "slot": slot,
      "numberOfPeople": numberOfPeople
    };
  }
}