import 'package:flutter/material.dart';
import 'package:date_app/models/user.dart';
import '../controllers/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  User user = User(
      id: 0, firstName: "", lastName: "", email: "", password: "", role: 0);

  void _setFirstName(value) {
    setState(() {
      user.firstName = value;
    });
  }

  void _setLastName(value) {
    setState(() {
      user.lastName = value;
    });
  }

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

  String confirmPassword = "";
  void _setConfirmPassword(value) {
    setState(() {
      confirmPassword = value;
    });
  }

  void signin() {
    AuthController.signin(
            user.firstName, user.lastName, user.email, user.password)
        .then((success) async {
      if (success) {
        Navigator.pushNamed(context, '/sign-in');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vore compte à bien été créé')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Votre création de compte à échoué')),
        );
      }
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.cake,
                                size: 100.0,
                                color: Color.fromARGB(255, 106, 231, 146),
                              ),
                            ],
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Flexible(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Créez un compte",
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
                                            hintText: "prénom",
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
                                            _setFirstName(value),
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
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            hintText: "nom",
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
                                            _setLastName(value),
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
                                            hintText:
                                                "confirmation du mot de passe",
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
                                            _setConfirmPassword(value),
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
                                        child: const Text('Valider',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0))),
                                        onPressed: () {
                                          if (user.password !=
                                              confirmPassword) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Votre mot de passe et sa confirmation ne correspondent pas')),
                                            );
                                          } else {
                                            signin();
                                            Navigator.pushNamed(
                                                context, '/sign-in');
                                          }
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
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  "Vous avez déjà un compte ?",
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
                                                  "Connectez-vous",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Color.fromARGB(
                                                          255, 106, 231, 146))),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/sign-in');
                                              })
                                        ]))
                              ])
                        ]))))));
  }
}
