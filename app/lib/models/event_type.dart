class EventType {
  final int id;
  final String label;

  @override
  EventType({required this.id, required this.label});

  factory EventType.fromJson(Map<String, dynamic> json) {
    return EventType(id: json['id'], label: json["name"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['label'] = label;
    return data;
  }
}
