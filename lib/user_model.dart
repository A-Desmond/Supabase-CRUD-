class UserModel {
  final String id;
  final String name;
  final String age;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      age: json['age'].toString(),
    );
  }
}
