class User {
  int code;
  String message;
  UserClass user;
  String accessToken;

  User({
    required this.code,
    required this.message,
    required this.user,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        code: json["code"],
        message: json["message"],
        user: UserClass.fromJson(json["user"]),
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "user": user.toJson(),
        "access_token": accessToken,
      };
}

class UserClass {
  int id;
  String username;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  UserClass({
    required this.id,
    required this.username,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        username: json["username"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
