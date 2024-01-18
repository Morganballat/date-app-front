import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../controllers/user_controller.dart';
import '../providers/user_provider.dart';

class ChangePasswordModal extends StatefulWidget {
  const ChangePasswordModal({Key? key}) : super(key: key);

  @override
  ChangePasswordModalState createState() => ChangePasswordModalState();
}

class ChangePasswordModalState extends State<ChangePasswordModal> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  User user = User(
      id: 0, firstName: "", lastName: "", email: "", password: "", role: 0);

  void _setOldPassword(value) {
    setState(() {
      user.password = value;
    });
  }

  String newPassword = "";
  void _setNewPassword(value) {
    setState(() {
      newPassword = value;
    });
  }

  String confirmNewPassword = "";
  void _setConfirmNewPassword(value) {
    setState(() {
      confirmNewPassword = value;
    });
  }

  void _changePassword() {
    if (newPassword != confirmNewPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Votre nouveau mot de passe et sa confirmation ne correspondent pas')),
      );
    } else {
      UserController.changePassword(context.read<UserProvider>().user!.id, newPassword);
      Navigator.pushNamed(context, '/sign-in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: Container(
                width: MediaQuery.of(context).size.width - 50,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 42, 42, 42),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            iconSize: 50.0,
                            onPressed: () {
                              Navigator.pushNamed(context, '/account');
                            },
                            icon: const Icon(Icons.close),
                            color: const Color.fromARGB(255, 106, 231, 146),
                          )
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Flexible(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "Modifier votre mot de passe",
                                      style: TextStyle(
                                          fontSize: 35,
                                          color: Color.fromARGB(
                                              255, 106, 231, 146),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ]),
                            Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.only(
                                        top: 50.0, bottom: 20),
                                    child: TextFormField(
                                      obscureText: true,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText: "ancien mot de passe",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        filled: true,
                                        fillColor: Color.fromARGB(255, 0, 0, 0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 106, 231, 146),
                                              width: 1.0),
                                        ),
                                      ),
                                      onChanged: (value) => {
                                        _setOldPassword(value),
                                      },
                                    ))
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    child: TextFormField(
                                      obscureText: true,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText: "nouveau mot de passe",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        filled: true,
                                        fillColor: Color.fromARGB(255, 0, 0, 0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 106, 231, 146),
                                              width: 1.0),
                                        ),
                                      ),
                                      onChanged: (value) => {
                                        _setNewPassword(value),
                                      },
                                    ))
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    child: TextFormField(
                                      obscureText: true,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        hintText:
                                            "confirmation du nouveau mot de passe",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                        filled: true,
                                        fillColor: Color.fromARGB(255, 0, 0, 0),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 106, 231, 146),
                                              width: 1.0),
                                        ),
                                      ),
                                      onChanged: (value) => {
                                        _setConfirmNewPassword(value),
                                      },
                                    ))
                              ],
                            ),
                            Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                          _changePassword();
                                        },
                                      ),
                                    ]))
                          ])
                    ]))));
  }
}
