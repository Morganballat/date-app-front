import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  final String title;

  TopBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 44, 44, 44),
      centerTitle: true,
      toolbarHeight: 400,
      title: Text(title),
      leading: GestureDetector(
        child: IconButton(
          iconSize: 50.0,
          onPressed: () {
            Navigator.pushNamed(context, '/create-event');
          },
          icon: const Icon(Icons.add),
          color: const Color.fromARGB(255, 106, 231, 146),
        ),
      ),
      actions: <Widget>[
        Container(
          child: Row(children: [
            IconButton(
              iconSize: 50.0,
              onPressed: () {
                Navigator.pushNamed(context, '/account');
              },
              icon: const Icon(Icons.account_circle),
              color: const Color.fromARGB(255, 106, 231, 146),
            ),
          ]),
        )
      ],
    );
  }
}
