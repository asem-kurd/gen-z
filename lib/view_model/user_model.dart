class UserModel {
  late String userId;
  late String email;
  late String name;
  late String password;
  late double phone;
  late String address;
  String? avatar; // اجعل الصورة اختيارية باستخدام String
  late double age;
  late String role;
  late Map? events;

  UserModel({
    required this.userId,
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
    this.address = "",
    this.avatar, // اجعلها اختيارية
    required this.age,  
    this.role = "user",
    this.events,
  });

  UserModel.fromJson(Map<String, dynamic> map) {
    userId = map['userId'];
    email = map['email'];
    name = map['name'];
    password = map['password'];
    phone = map['phone'];
    address = map['address'] ?? "";
    avatar = map['avatar']; // قد تكون null
    age = map['age'] != null ? map['age'].toDouble() : 0.0;
    role = map['role'] ?? "user";
    events = map['events'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'password': password,
      'phone': phone,
      'address': address,
      'avatar': avatar, // قد تكون null عند الإرسال
      'age': age,
      'role': role,
      'events': events,
    };
  }
}
