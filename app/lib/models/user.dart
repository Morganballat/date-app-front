class User {
  late int id;
  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late int role;

  @override
  User({required this.id, 
  required this.firstName, 
  required this.lastName, 
  required this.email, 
  this.password = "", 
  required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], 
    firstName: json["firstname"], 
    lastName: json["lastname"],
    email: json["email"],
    role: json["role"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}
