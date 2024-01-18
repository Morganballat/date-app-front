import 'package:flutter/material.dart';
import 'package:date_app/components/top_bar.dart';
import 'package:date_app/components/event_card.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../controllers/auth_controller.dart';
import '../controllers/event_controller.dart';
import '../models/event.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static const _storage = FlutterSecureStorage();
  void _checkLogged() async {
    String? token = await _storage.read(key: 'token') as String?;
    if (token == null) {
      Navigator.pushNamed(context, '/sign-in');
    }
  }

  late Future<List<Event>> eventList;

  @override
  void initState() {
    super.initState();
    _checkLogged();
    eventList = EventController.getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: TopBar(title: 'Appli date App'),
        ),
        body: SizedBox(
          width: 400,
          height: 600,
          child: FutureBuilder<List<Event>>(
              future: eventList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List? data = snapshot.data;
                  if (data != null && data.isNotEmpty) {
                    return SizedBox(
                      width: 400,
                      height: 600,
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return EventCard(event: data[index]);
                          }),
                    );
                  } else {
                    return const Center(
                      child: Text("Aucun événement pour le moment"),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  );
                }
                return const Padding(
                  padding: EdgeInsets.only(top: 70.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }),
        ));
  }
}
