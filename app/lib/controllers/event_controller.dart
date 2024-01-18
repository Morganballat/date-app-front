import 'dart:convert';

import 'package:date_app/controllers/auth_controller.dart';
import 'package:date_app/controllers/gift_controller.dart';
import 'package:date_app/helpers/appli_api.dart';
import 'package:date_app/models/event.dart';
import 'package:http/http.dart' as http;

class EventController {
  static Future<List<Event>> getAllEvents() async {
    String? token = await AuthController.getToken();

    if (token == null) {
      throw Exception('Failed to load user');
    }

    List<Event> events = <Event>[];

    final List<dynamic> responseMap = await AppliAPI.get('/events');

    events = responseMap.map((event) {
      return Event.fromJson(event);
    }).toList();

    return events;
  }

  static Future<Event> getEvent(int id) async {
    String? token = await AuthController.getToken();

    if (token == null) {
      throw Exception('Failed to load user');
    }

    var responseMap = await AppliAPI.get('/events/$id');

    return Event.fromJson(responseMap);
  }

  static Future<Event> createEvent(userId, Event event) async {
    String? token = await AuthController.getToken();

    if (token == null) {
      throw Exception('Failed to load user');
    }

    var response = await AppliAPI.post(
      '/events/add',
      {
        'label': event.label,
        'description': event.description,
        'type_id': event.typeId,
        'date': event.date.toString(),
        'user_id': userId
      },
    );

    return Event.fromJson(response);
  }

  static Future<void> editEvent(int eventId, Event event) async {
    String? token = await AuthController.getToken();

    if (token == null) {
      throw Exception('Failed to load user');
    }

    var response = await AppliAPI.post(
      '/events/edit/$eventId',
      {
        'label': event.label,
        'description': event.description,
        'date': event.date.toString(),
        'giftList': event.giftList
      },
    );

    return response;
  }

  static Future<void> deleteEvent(int id) async {
    String? token = await AuthController.getToken();

    if (token == null) {
      throw Exception('Failed to load user');
    }

    var response = await AppliAPI.get('/events/delete/$id');

    return;
  }
}
