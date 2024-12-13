import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rive/rive.dart';

class EventModel {
  final String Data_event;
  final GeoPoint Latitude;
  final String discription;
  final String event_type;
  final int phone;
  final String upload_image;

  EventModel(
      {required this.Data_event,
      required this.Latitude,
      required this.discription,
      required this.event_type,
      required this.phone,
      required this.upload_image});

  factory EventModel.fromJson(Map<String, dynamic> map) {
    return EventModel(
        Data_event: map['Data_event'],
        Latitude: map['Latitude'],
        discription: map['discription'],
        event_type: map['event_type'],
        phone: map['phone'],
        upload_image: map['upload_image']);//fromsubabase
  }

  Map<String, dynamic> toJson() {
    return {
      'Data_event': Data_event,
      'Latitude': Latitude,
      'discription': discription,
      'event_type': event_type,
      'phone': phone,
      'upload_image': upload_image
    };
  }
}
