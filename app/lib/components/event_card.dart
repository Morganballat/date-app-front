import 'package:flutter/material.dart';
import 'package:date_app/models/event.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, '/event-detail', arguments: event.id),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 106, 231, 146),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.cake,
                  color: Color.fromARGB(255, 106, 231, 146),
                ),
                Text(
                  event.label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(event.date),
                  style: const TextStyle(),
                ),
              ],
            ),
            const Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      calculateDifference(event.date) < 0
                          ? "J+${calculateDifference(event.date).round().abs()}"
                          : (calculateDifference(event.date) == 0
                              ? "Aujourd'hui"
                              : "J-${calculateDifference(event.date).round()}"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: calculateDifference(event.date) < 0
                              ? Color.fromARGB(255, 255, 255, 255)
                              : (calculateDifference(event.date) == 0
                                  ? Color.fromARGB(255, 232, 78, 78)
                                  : Color.fromARGB(255, 106, 231, 146)))),
                ],
              )
            ])
          ],
        ),
      ),
    );
  }
}
