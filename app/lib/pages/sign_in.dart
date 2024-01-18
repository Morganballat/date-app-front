import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_app/models/user.dart';
import 'package:date_app/controllers/auth_controller.dart';
import 'package:date_app/controllers/user_controller.dart';
import 'package:date_app/providers/user_provider.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = "/sign-in";

  const SignInPage({Key? key}) : super(key: key);

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  User user = User(
      id: 0, firstName: "", lastName: "", email: "", password: "", role: 0);

  void _setEmail(value) {
    setState(() {
      user.email = value;
    });
  }

  void _setPassword(value) {
    setState(() {
      user.password = value;
    });
  }

  void login() {
    AuthController.login(user.email, user.password).then((success) async {
      if (success) {
        User userLogged =
            await UserController.getUser(user.email, user.password);
        // ignore: use_build_context_synchronously
        context.read<UserProvider>().setUser(userLogged);
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/home');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vous êtes connecté(e)')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Connexion échouée')),
        );
      }
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Connexion échouée, verifiez vos identifiants')),
      );
    });
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
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                size: 100.0,
                                Icons.cake,
                                color: Color.fromARGB(255, 106, 231, 146),
                              ),
                            ],
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Connexion à votre compte",
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(20.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            hintText: "email",
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
                                            _setEmail(value),
                                          },
                                        ))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.all(20.0),
                                        child: TextFormField(
                                          obscureText: true,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            hintText: "mot de passe",
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
                                            _setPassword(value),
                                          },
                                        ))
                                  ],
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
                                        child: const Text('Se connecter',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0))),
                                        onPressed: () {
                                          login();
                                        },
                                      ),
                                    ])),
                                Container(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Vous n'avez pas encore de compte ?",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ]),
                                          TextButton(
                                              style: ButtonStyle(
                                                padding: MaterialStateProperty
                                                    .all<EdgeInsets>(
                                                        const EdgeInsets.only(
                                                            top: 15,
                                                            bottom: 15,
                                                            left: 10,
                                                            right: 10)),
                                              ),
                                              child: const Text(
                                                  "Inscrivez-vous",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color.fromARGB(
                                                          255, 106, 231, 146))),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/register');
                                              })
                                        ]))
                              ])
                        ]))))));
  }
}
