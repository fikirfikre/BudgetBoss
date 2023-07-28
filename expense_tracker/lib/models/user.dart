import 'dart:typed_data';

class User {
  int? id;
  String user_name;
  bool? isLoggedIn;
  String password;
  String email;
  Uint8List? image;
  User({this.id, required this.user_name,required this.email, required this.password, this.image, this.isLoggedIn = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_name': user_name,
      'password': password,
      'email':email,
      'image': image != null ? image!.toList() : null,
      'isLoggedIn': isLoggedIn == true ? 1 : 0
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        user_name = map['user_name'],
        email = map['email'],
        image = map['image'] != null ? Uint8List.fromList(map['image']) : null,
        password = map['password'],
        isLoggedIn = map['isLoggedIn'] == 1  ? true : false;

}
