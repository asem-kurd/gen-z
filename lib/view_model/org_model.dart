class Firestoreorg {
  late String userid;
  late String email;
  late String name;
  late String password;
  late double phone;
  late String address;
  String? avatar; // اجعل الصورة اختيارية باستخدام String
  late String role ;
  late String url;
  //late String eventsIds;

  Firestoreorg({
    required this.userid,
    required this.email,
    required this.name,
    required this.password,
    required this.phone,
    this.address = "",
    required this.url,
    this.avatar, // اجعلها اختيارية
    this.role = "org",

    //this eventsIds
  });

  Firestoreorg.fromJson(Map<String, dynamic> map) {
    userid = map['userId'];
    email = map['email'];
    name = map['name'];
    password = map['password'];
    phone = map['phone'];
    address = map['address'] ?? "";
    avatar = map['avatar']; // قد تكون null
    url = map['url'];
    role=map['role'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userid,
      'email': email,
      'name': name,
      'password': password,
      'phone': phone,
      'address': address,
      'avatar': avatar, // قد تكون null عند الإرسال
      'role': role,
      'url': url
    };
  }
}
