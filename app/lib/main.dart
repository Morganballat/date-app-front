import 'package:date_app/pages/edit_event.dart';
import 'package:date_app/pages/home_page.dart';
import 'package:date_app/pages/event_detail.dart';
import 'package:date_app/pages/edit_event.dart';
import 'package:date_app/pages/create_event.dart';
import 'package:date_app/pages/sign_in.dart';
import 'package:date_app/pages/register.dart';
import 'package:date_app/pages/account.dart';
import 'package:flutter/material.dart';
import 'package:date_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
              create: (context) => UserProvider())
        ],
        child: MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
              textTheme: const TextTheme(
                  bodyText2:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            ),
            initialRoute: SignInPage.routeName,
            routes: {
              '/home': (context) => const HomePage(),
              '/event-detail': (context) => EventDetailPage(
                  eventId: ModalRoute.of(context)!.settings.arguments as int),
              '/edit-event': (context) => EditEventPage(
                  eventId: ModalRoute.of(context)!.settings.arguments as int),
              '/create-event': (context) => const CreateEventPage(),
              '/sign-in': (context) => const SignInPage(),
              '/register': (context) => const RegisterPage(),
              '/account': (context) => const AccountPage()
            }));
  }
}
