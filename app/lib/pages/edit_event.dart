import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:date_app/models/event.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import '../controllers/event_controller.dart';
import '../controllers/gift_controller.dart';
import '../controllers/type_controller.dart';
import '../models/gift.dart';
import '../providers/user_provider.dart';
import 'dart:developer' as developer;

class EditEventPage extends StatefulWidget {
  const EditEventPage({Key? key, required this.eventId}) : super(key: key);
  final int eventId;

  @override
  EditEventPageState createState() => EditEventPageState();
}

class EditEventPageState extends State<EditEventPage> {
  static const _storage = FlutterSecureStorage();
  void _checkLogged() async {
    String? token = await _storage.read(key: 'token') as String?;
    if (token == null) {
      Navigator.pushNamed(context, '/sign-in');
    }
  }

  Event updatedEvent = Event(
    id: 0,
    label: "",
    description: "",
    date: DateTime.now(),
  );

  late Future<Event> event;

  bool hasEventChanged = false;
  void _setHasEventChanged(value) {
    setState(() {
      hasEventChanged = value;
    });
  }

  final TextEditingController _dateController = TextEditingController();
  late DateTime date;
  bool hasDateChanged = false;
  void _setDate(value) {
    setState(() {
      date = value;
      hasDateChanged = true;
    });
  }

  late String label;
  bool hasLabelChanged = false;
  void _setLabel(value) {
    setState(() {
      hasLabelChanged = true;
      label = value;
    });
  }

  late String description;
  bool hasDescriptionChanged = false;
  void _setDescription(value) {
    setState(() {
      hasDescriptionChanged = true;
      description = value;
    });
  }

  Gift giftIdea = Gift(id: 0, name: "");

  final TextEditingController _ideaController = TextEditingController();
  final TextEditingController _editGiftIdeaController = TextEditingController();
  bool hasGiftIdeaListChanged = false;
  void _setGiftIdea(value) {
    setState(() {
      hasGiftIdeaListChanged = true;
      giftIdea.name = value;
    });
  }

  int? editId;
  void _setEditId(value) {
    setState(() {
      editId = value;
    });
  }

  int? deleteId;
  void _setDeleteId(value) {
    setState(() {
      deleteId = value;
    });
  }

  bool isEditMode = false;
  void _setIsEditMode(value) {
    setState(() {
      isEditMode = value;
    });
  }

  bool hasGiftIdeaChanged = false;
  void _setHasGiftIdeaChanged(value) {
    setState(() {
      hasGiftIdeaChanged = value;
    });
  }

  late List<dynamic> giftIdeaList = [];
  void _setGiftIdeaList(value) {
    setState(() {
      giftIdeaList = value;
    });
  }

  void _redirect(eventId) async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushNamed(context, '/event-detail', arguments: eventId);
  }

  @override
  void initState() {
    event = EventController.getEvent(widget.eventId);
    super.initState();
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
                              giftIdeaList = snapshot.data!.giftList;
                              return Container(
                                  child: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      iconSize: 50.0,
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/home');
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
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: TextFormField(
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: snapshot
                                                            .data?.label,
                                                        hintStyle:
                                                            const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)),
                                                        filled: true,
                                                        fillColor: const Color
                                                                .fromARGB(
                                                            255, 44, 44, 44),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          106,
                                                                          231,
                                                                          146),
                                                                  width: 1.0),
                                                        ),
                                                      ),
                                                      onChanged: (value) => {
                                                        _setLabel(value),
                                                        _setHasEventChanged(
                                                            true)
                                                      },
                                                    )))
                                          ]),
                                    ]),
                                Column(children: [
                                  Row(children: [
                                    Expanded(
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextFormField(
                                            controller: _dateController,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            decoration: InputDecoration(
                                              suffixIcon: const Icon(
                                                  Icons.calendar_today,
                                                  color: Color.fromARGB(
                                                      255, 106, 231, 146)),
                                              hintText: DateFormat('dd/MM/yyyy')
                                                  .format(snapshot.data!.date),
                                              hintStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  255, 44, 44, 44),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 106, 231, 146),
                                                    width: 1.0),
                                              ),
                                            ),
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate:
                                                    snapshot.data!.date,
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2100),
                                              );
                                              if (pickedDate != null) {
                                                String formattedDateForInput =
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(pickedDate);
                                                setState(() {
                                                  _dateController.text =
                                                      formattedDateForInput;
                                                  _setDate(pickedDate);
                                                });
                                              }
                                            },
                                          )),
                                    )
                                  ])
                                ]),
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(20.0),
                                    child: TextFormField(
                                      maxLines: null,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText: snapshot.data!.description,
                                        hintStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            255, 44, 44, 44),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 106, 231, 146),
                                              width: 1.0),
                                        ),
                                      ),
                                      onChanged: (value) => {
                                        _setDescription(value),
                                      },
                                    )),
                                if (snapshot.data!.typeId != 3) ...[
                                  Column(children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(20.0),
                                        child: TextFormField(
                                          maxLines: null,
                                          controller: _ideaController,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                giftIdeaList.add(Gift(
                                                  id: giftIdeaList.isEmpty
                                                      ? 0
                                                      : giftIdeaList.length,
                                                  name: giftIdea.name,
                                                ));
                                                _setGiftIdeaList(giftIdeaList);
                                                _ideaController.clear();
                                                inspect(giftIdeaList);
                                              },
                                              icon: const Icon(Icons.add),
                                              color: const Color.fromARGB(
                                                  255, 106, 231, 146),
                                            ),
                                            hintText: "Idée cadeau",
                                            hintStyle: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(255, 44, 44, 44),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 106, 231, 146),
                                                  width: 1.0),
                                            ),
                                          ),
                                          onChanged: (value) =>
                                              {_setGiftIdea(value)},
                                        )),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(20.0),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: giftIdeaList.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: [
                                                  if (isEditMode &&
                                                      editId ==
                                                          giftIdeaList[index]
                                                              .id) ...[
                                                    Flexible(
                                                      child: Row(children: [
                                                        Flexible(
                                                            child:
                                                                TextFormField(
                                                          maxLines: null,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          decoration:
                                                              InputDecoration(
                                                            suffixIcon:
                                                                IconButton(
                                                              onPressed: () {
                                                                if (hasGiftIdeaChanged ==
                                                                    false) {
                                                                  giftIdeaList
                                                                      .firstWhere((x) =>
                                                                          x.id ==
                                                                          editId)
                                                                      .name = giftIdeaList[
                                                                          index]
                                                                      .name;
                                                                } else {
                                                                  giftIdeaList
                                                                      .firstWhere((x) =>
                                                                          x.id ==
                                                                          editId)
                                                                      .name = giftIdea.name;
                                                                }
                                                                _setIsEditMode(
                                                                    false);
                                                              },
                                                              icon: const Icon(
                                                                  Icons.check),
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  106,
                                                                  231,
                                                                  146),
                                                            ),
                                                            hintText:
                                                                giftIdeaList[
                                                                        index]
                                                                    .name,
                                                            hintStyle:
                                                                const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)),
                                                            filled: true,
                                                            fillColor: const Color
                                                                    .fromARGB(
                                                                255,
                                                                44,
                                                                44,
                                                                44),
                                                            focusedBorder:
                                                                const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          106,
                                                                          231,
                                                                          146),
                                                                  width: 1.0),
                                                            ),
                                                          ),
                                                          onChanged: (value) =>
                                                              {
                                                            _setGiftIdea(value),
                                                            _setHasGiftIdeaChanged(
                                                                true)
                                                          },
                                                        )),
                                                      ]),
                                                    )
                                                  ] else ...[
                                                    Flexible(
                                                      child: Text(
                                                          giftIdeaList[index]
                                                              .name,
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        _setEditId(
                                                            giftIdeaList[index]
                                                                .id);
                                                        _setIsEditMode(true);
                                                      },
                                                      icon: const Icon(
                                                          Icons.edit),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              106,
                                                              231,
                                                              146),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        // giftIdeaList
                                                        //     .removeWhere(
                                                        //         (idea) {
                                                        //   return idea.id ==
                                                        //       giftIdeaList[
                                                        //               index]
                                                        //           .id;
                                                        // });
                                                        // _setGiftIdeaList(
                                                        //     giftIdeaList);
                                                        // },
                                                        _setDeleteId(
                                                            giftIdeaList[index]
                                                                .id);

                                                        GiftController
                                                            .deleteGift(
                                                                giftIdeaList[
                                                                        index]
                                                                    .id);
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              106,
                                                              231,
                                                              146),
                                                    )
                                                  ]
                                                ],
                                              );
                                            })),
                                  ]),
                                  Container(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                        TextButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0))),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color.fromARGB(
                                                        255, 106, 231, 146)),
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsets>(
                                                const EdgeInsets.only(
                                                    top: 15,
                                                    bottom: 15,
                                                    left: 10,
                                                    right: 10)),
                                          ),
                                          child: const Text('Valider',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          onPressed: () {
                                            snapshot.data!.giftList =
                                                giftIdeaList;
                                            updatedEvent = snapshot.data!;
                                            if (hasLabelChanged) {
                                              updatedEvent.label = label;
                                            }
                                            if (hasDateChanged) {
                                              updatedEvent.date = date;
                                            }
                                            if (hasDescriptionChanged) {
                                              updatedEvent.description =
                                                  description;
                                            }
                                            if (hasGiftIdeaListChanged) {
                                              updatedEvent.giftList =
                                                  giftIdeaList;
                                            }
                                            EventController.editEvent(
                                                widget.eventId, updatedEvent);
                                            _redirect(widget.eventId);
                                          },
                                        ),
                                      ]))
                                ]
                              ]));
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
