import 'package:task_wise/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map["_id"] ?? "",
      email: map["email"],
      firstName: map["firstName"] ?? "",
      lastName: map["lastName"] ?? "",
      phoneNumber: map["mobile"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{"id": id, "email": email, "name": firstName};
  }
}
