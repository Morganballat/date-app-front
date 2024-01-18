import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_controller.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class DeleteAccountModal extends StatefulWidget {
  const DeleteAccountModal({Key? key}) : super(key: key);

  @override
  DeleteAccountModalState createState() => DeleteAccountModalState();
}

class DeleteAccountModalState extends State<DeleteAccountModal> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  User user = User(
      id: 0, firstName: "", lastName: "", email: "", password: "", role: 0);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: 
          Container(
            width: MediaQuery.of(context).size.width -50,
            padding: const EdgeInsets.only(top: 50.0, bottom: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 42, 42, 42),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Color.fromARGB(255, 0, 0, 0))
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Flexible(
                      child: Text(
                        "Êtes-vous sûr de vouloir supprimer votre compte ?",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 106, 231, 146),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ]
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )
                      ),
                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 106, 231, 146)),
                      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10)),
                    ),
                    child: const Text(
                      'Annuler',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 0, 0, 0)
                      )
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/account');
                    },
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )
                      ),
                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 245, 57, 63)),
                      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10)),
                    ),
                    child: const Text(
                      'Valider',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 0, 0, 0)
                      )
                    ),
                    onPressed: () {
                      UserController.deleteUser(context.read<UserProvider>().user!.id);
                      Navigator.pushNamed(context, '/sign-in');
                    },
                  ),
                )
              ],
            )
          )
        
      
    );
  }
}
