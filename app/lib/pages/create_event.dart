import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:date_app/models/event.dart';
import 'package:date_app/models/event_type.dart';
import 'package:date_app/models/gift.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/event_controller.dart';
import '../controllers/gift_controller.dart';
import '../controllers/type_controller.dart';
import '../providers/user_provider.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  CreateEventPageState createState() => CreateEventPageState();
}

class CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();

  EventType dropdownvalue = EventType(id: 4, label: 'Item 5');
  Event event = Event(
    id: 0,
    label: "",
    description: "",
    date: DateTime.now(),
  );

  Gift giftIdea = Gift(
    id: 0,
    name: "",
  );

  bool isTypeSet = false;
  bool isTypeSelected = false;

  static const _storage = FlutterSecureStorage();
  void _checkLogged() async {
    String? token = await _storage.read(key: 'token') as String?;
    if (token == null) {
      Navigator.pushNamed(context, '/sign-in');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLogged();
  }

  void _setType(value) {
    setState(() {
      event.typeId = value;
    });
  }

  void _setLabel(value) {
    setState(() {
      event.typeId = dropdownvalue.id;
      event.label = value;
    });
  }

  void _setDescription(value) {
    setState(() {
      event.description = value;
    });
  }

  void _setDate(value) {
    setState(() {
      event.date = value;
    });
  }

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _ideaController = TextEditingController();
  final TextEditingController _editGiftIdeaController = TextEditingController();

  void _setGiftIdea(value) {
    setState(() {
      giftIdea.name = value;
    });
  }

  int? editId;
  void _setEditId(value) {
    setState(() {
      editId = value;
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

  late List<Gift> giftIdeaList = [];
  void _setGiftIdeaList(value) {
    setState(() {
      giftIdeaList = value;
    });
  }

  void _createEvent() async {
    Event createdEvent = await EventController.createEvent(
        context.read<UserProvider>().user!.id, event);
    if (giftIdeaList != [] && giftIdeaList.isNotEmpty) {
      await GiftController.createGifts(createdEvent.id, giftIdeaList);
    }
    Navigator.pushNamed(context, '/event-detail', arguments: createdEvent.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                iconSize: 50.0,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/home');
                                },
                                icon: const Icon(Icons.close),
                                color: const Color.fromARGB(255, 106, 231, 146),
                              )
                            ],
                          ),
                          if (!isTypeSet) ...[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Flexible(
                                          child: Text(
                                            "Quel type d'événement souhaitez vous ajouter ?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Color.fromARGB(
                                                    255, 106, 231, 146),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ]),
                                  Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.70,
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                color: Color.fromARGB(
                                                    255, 44, 44, 44),
                                              ),
                                              child: Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    canvasColor:
                                                        const Color.fromARGB(
                                                            255, 44, 44, 44),
                                                  ),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                          child: ButtonTheme(
                                                              alignedDropdown:
                                                                  true,
                                                              child: FutureBuilder<
                                                                      List<
                                                                          EventType>>(
                                                                  future: TypeController
                                                                      .getAllTypes(),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    return DropdownButton<
                                                                        EventType>(
                                                                      isExpanded:
                                                                          true,
                                                                      hint: Padding(
                                                                          padding: const EdgeInsets.all(
                                                                              0),
                                                                          child: Text(
                                                                              isTypeSelected ? dropdownvalue.label : "choisissez le type d'événement",
                                                                              style: const TextStyle(color: Color.fromARGB(255, 166, 166, 166)))),
                                                                      icon: const Padding(
                                                                          padding: EdgeInsets.only(
                                                                              right:
                                                                                  10),
                                                                          child: Icon(
                                                                              Icons.keyboard_arrow_down_rounded,
                                                                              color: Color.fromARGB(255, 106, 231, 146))),
                                                                      style: const TextStyle(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              166,
                                                                              166,
                                                                              166)),
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          dropdownvalue =
                                                                              value!;
                                                                          isTypeSelected =
                                                                              true;
                                                                        });
                                                                      },
                                                                      items: snapshot
                                                                          .data
                                                                          ?.map((EventType
                                                                              eventType) {
                                                                        return DropdownMenuItem<
                                                                                EventType>(
                                                                            value:
                                                                                eventType,
                                                                            child:
                                                                                Center(
                                                                              child: Text(eventType.label, textAlign: TextAlign.center),
                                                                            ));
                                                                      }).toList(),
                                                                    );
                                                                  })))))
                                        ]),
                                  ),
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
                                                  BorderRadius.circular(20.0),
                                            )),
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
                                          child: const Text('Suivant',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          onPressed: () {
                                            setState(() {
                                              isTypeSet =
                                                  isTypeSelected ? true : false;
                                            });
                                          },
                                        ),
                                      ]))
                                ])
                          ] else ...[
                            Column(children: [
                              const Text(
                                "Détails de l'événement",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 106, 231, 146)),
                              ),
                              Column(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(20.0),
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          hintText: "Nom de l'événement",
                                          hintStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          filled: true,
                                          fillColor:
                                              Color.fromARGB(255, 44, 44, 44),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 106, 231, 146),
                                                width: 1.0),
                                          ),
                                        ),
                                        onChanged: (value) => {
                                          _setLabel(value),
                                        },
                                      ))
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(20.0),
                                      child: TextFormField(
                                        maxLines: null,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          hintText:
                                              "Description de l'événement",
                                          hintStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          filled: true,
                                          fillColor:
                                              Color.fromARGB(255, 44, 44, 44),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 106, 231, 146),
                                                width: 1.0),
                                          ),
                                        ),
                                        onChanged: (value) => {
                                          _setDescription(value),
                                        },
                                      ))
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(20.0),
                                      child: TextFormField(
                                        controller: _dateController,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                          suffixIcon: Icon(Icons.calendar_today,
                                              color: Color.fromARGB(
                                                  255, 106, 231, 146)),
                                          hintText: "Date de l'événement",
                                          hintStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          filled: true,
                                          fillColor:
                                              Color.fromARGB(255, 44, 44, 44),
                                          focusedBorder: OutlineInputBorder(
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
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2023),
                                                  lastDate: DateTime(2100));

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
                                      ))
                                ],
                              ),
                              if (dropdownvalue.id != 3) ...[
                                Column(children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width,
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
                                      width: MediaQuery.of(context).size.width,
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
                                                          child: TextFormField(
                                                        maxLines: null,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        decoration:
                                                            InputDecoration(
                                                          suffixIcon:
                                                              IconButton(
                                                            onPressed: () {
                                                              if (hasGiftIdeaChanged ==
                                                                  false) {
                                                                giftIdeaList
                                                                    .elementAt(
                                                                        editId!)
                                                                    .name = giftIdeaList[
                                                                        index]
                                                                    .name;
                                                              } else {
                                                                giftIdeaList
                                                                        .elementAt(
                                                                            editId!)
                                                                        .name =
                                                                    giftIdea
                                                                        .name;
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
                                                              255, 44, 44, 44),
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
                                                        onChanged: (value) => {
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
                                                    icon:
                                                        const Icon(Icons.edit),
                                                    color: const Color.fromARGB(
                                                        255, 106, 231, 146),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      giftIdeaList
                                                          .removeWhere((idea) {
                                                        return idea.id ==
                                                            giftIdeaList[index]
                                                                .id;
                                                      });
                                                      _setGiftIdeaList(
                                                          giftIdeaList);
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    color: const Color.fromARGB(
                                                        255, 106, 231, 146),
                                                  )
                                                ]
                                              ],
                                            );
                                          })),
                                ]),
                              ],
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
                                              BorderRadius.circular(20.0),
                                        )),
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
                                        _createEvent();
                                      },
                                    ),
                                  ]))
                            ])
                          ],
                        ]),
                  )))),
    );
  }
}
