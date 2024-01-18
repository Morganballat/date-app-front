import 'package:flutter/material.dart';
import 'package:date_app/models/event.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import '../controllers/event_controller.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({Key? key, required this.eventId}) : super(key: key);
  final int eventId;

  @override
  EventDetailPageState createState() => EventDetailPageState();
}

class EventDetailPageState extends State<EventDetailPage> {
  static const _storage = FlutterSecureStorage();
  void _checkLogged() async {
    String? token = await _storage.read(key: 'token') as String?;
    if (token == null) {
      Navigator.pushNamed(context, '/sign-in');
    }
  }

  int daysBetween(DateTime to) {
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(DateTime.now()).inHours / 24).round();
  }

  void deleteEvent(eventId) async {
    await EventController.deleteEvent(eventId);
    Navigator.pushNamed(context, '/home');
  }

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  late Future<Event> event;
  @override
  void initState() {
    super.initState();
    event = EventController.getEvent(widget.eventId);
    _checkLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                      FutureBuilder(
                          future: event,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          child: Column(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              iconSize: 50.0,
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/home');
                                              },
                                              icon: const Icon(Icons.close),
                                              color: const Color.fromARGB(
                                                  255, 106, 231, 146),
                                            )
                                          ],
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.cake,
                                                      size: 100.0,
                                                      color: Color.fromARGB(
                                                          255, 106, 231, 146),
                                                    ),
                                                  ]),
                                              Row(children: [
                                                Expanded(
                                                    child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    snapshot.data!.label,
                                                    style: const TextStyle(
                                                        fontSize: 35,
                                                        color: Color.fromARGB(
                                                            255, 106, 231, 146),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ))
                                              ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 20),
                                                      child: Text(
                                                        calculateDifference(
                                                                    snapshot
                                                                        .data!
                                                                        .date) <
                                                                0
                                                            ? "J+${calculateDifference(snapshot.data!.date).round().abs()}"
                                                            : (calculateDifference(
                                                                        snapshot
                                                                            .data!
                                                                            .date) ==
                                                                    0
                                                                ? "Aujourd'hui"
                                                                : "J-${calculateDifference(snapshot.data!.date).round()}"),
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color: calculateDifference(
                                                                        snapshot
                                                                            .data!
                                                                            .date) <
                                                                    0
                                                                ? Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255)
                                                                : (calculateDifference(snapshot.data!.date) == 0
                                                                    ? Color.fromARGB(
                                                                        255,
                                                                        232,
                                                                        78,
                                                                        78)
                                                                    : Color.fromARGB(
                                                                        255,
                                                                        106,
                                                                        231,
                                                                        146)),
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                  ]),
                                            ]),
                                        Column(children: [
                                          Row(children: [
                                            Text(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(snapshot.data!.date),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                          Row(children: [
                                            Expanded(
                                                child: Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Text(
                                                snapshot.data!.description,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ))
                                          ]),
                                          if (snapshot.data!.giftList != null &&
                                              snapshot.data!.giftList
                                                  .isNotEmpty) ...[
                                            const Row(children: [
                                              Text(
                                                "Idées cadeaux",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 106, 231, 146),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ]),
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    bottom: 20.0,
                                                    right: 20.0,
                                                    left: 20.0),
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemCount: snapshot
                                                        .data!.giftList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Row(children: [
                                                        Flexible(
                                                          child: Text(
                                                              // ignore: prefer_interpolation_to_compose_strings
                                                              "- " +
                                                                  snapshot
                                                                      .data!
                                                                      .giftList[
                                                                          index]
                                                                      .name,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          20)),
                                                        ),
                                                      ]);
                                                    }))
                                          ],
                                        ]),
                                      ])),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(children: [
                                              IconButton(
                                                iconSize: 50.0,
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/edit-event',
                                                      arguments:
                                                          snapshot.data?.id);
                                                },
                                                icon: const Icon(Icons.edit),
                                                color: const Color.fromARGB(
                                                    255, 106, 231, 146),
                                              ),
                                            ]),
                                            Column(children: [
                                              IconButton(
                                                iconSize: 50.0,
                                                onPressed: () {
                                                  deleteEvent(
                                                      snapshot.data?.id);
                                                },
                                                icon: const Icon(Icons.delete),
                                                color: const Color.fromARGB(
                                                    255, 106, 231, 146),
                                              ),
                                            ]),
                                          ])
                                    ]),
                              );
                            } else if (snapshot.hasError) {
                              return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(snapshot.error.toString()),
                              );
                            }
                            return const Padding(
                              padding: EdgeInsets.only(top: 70.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          })
                    ])))));
  }
}
