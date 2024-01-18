import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:date_app/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../components/change_password_modal.dart';
import '../components/delete_account_modal.dart';
import 'package:date_app/controllers/auth_controller.dart';
import 'package:date_app/providers/user_provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  AccountPageState createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
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

  User user = User(
      id: 0, firstName: "", lastName: "", email: "", password: "", role: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Container(
                    color: Color.fromARGB(255, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  iconSize: 50.0,
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/home');
                                  },
                                  icon: const Icon(Icons.close),
                                  color:
                                      const Color.fromARGB(255, 106, 231, 146),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(
                                  size: 100.0,
                                  Icons.account_circle,
                                  color: Color.fromARGB(255, 137, 137, 137),
                                ),
                              ],
                            ),
                            Container(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: TextButton(
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
                                          child: const Text(
                                              'Modifier votre mot de passe',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return const Dialog(
                                                    backgroundColor:
                                                        Colors.black,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30))),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child:
                                                        ChangePasswordModal(),
                                                  );
                                                });
                                          },
                                        ),
                                      ),
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
                                                      255, 245, 57, 63)),
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsets>(
                                              const EdgeInsets.only(
                                                  top: 15,
                                                  bottom: 15,
                                                  left: 10,
                                                  right: 10)),
                                        ),
                                        child: const Text('Déconnexion',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0))),
                                        onPressed: () {
                                          AuthController.logout().then((value) {
                                            Navigator.pushReplacementNamed(
                                                context, '/sign-in');
                                            context
                                                .read<UserProvider>()
                                                .clearUser();

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Vous êtes déconnecté(e)'),
                                              ),
                                            );
                                          });
                                        },
                                      ),
                                    ]))
                          ]),
                          Column(children: [
                            Container(
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
                                                  255, 245, 57, 63)),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.only(
                                                  top: 15,
                                                  bottom: 15,
                                                  left: 10,
                                                  right: 10)),
                                    ),
                                    child: const Text('Supprimer votre compte',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0))),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: const <Widget>[
                                                    DeleteAccountModal()
                                                  ]),
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30))),
                                            );
                                          });
                                    },
                                  ),
                                ]))
                          ]),
                        ]))))));
  }
}
