import 'gift.dart';

class Event {
  late int id;
  late String label;
  late String description;
  late int typeId;
  late DateTime date;
  late List<dynamic> giftList;

  @override
  Event(
      {this.id = 0,
      required this.label,
      required this.description,
      // required this.typeId,
      required this.date,
      this.giftList = const <Gift>[],
      this.typeId = 0});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        label: json["label"],
        description: json["description"],
        // typeId: json["type"],
        date: DateTime.parse(json["date"]),
        giftList: json["gifts"] != null && json["gifts"].length > 0
            ? json["gifts"].map((gift) => Gift.fromJson(gift)).toList()
            : []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['label'] = label;
    data['description'] = description;
    // data['typeId'] = typeId;
    data['date'] = date.toString();
    data['giftList'] = giftList;
    return data;
  }
}
