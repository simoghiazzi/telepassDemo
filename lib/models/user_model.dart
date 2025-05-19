class UserModel {
  int id;
  String createdAt;
  String? updatedAt;
  String? deletedAt;
  String? email;
  String username;
  int age;
  String? refreshToken;
  String? refreshTokenExpDate;
  PersonalData personalData;

  UserModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.email,
    required this.username,
    required this.age,
    this.refreshToken,
    this.refreshTokenExpDate,
    required this.personalData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    deletedAt: json['deletedAt'],
    email: json['email'],
    username: json['username'],
    age: json['age'],
    refreshToken: json['refreshToken'],
    refreshTokenExpDate: json['refreshTokenExpDate'],
    personalData: PersonalData.fromJson(json['personalData']),
  );
}

class PersonalData {
  int id;
  String createdAt;
  String? updatedAt;
  String? deletedAt;
  String lastName;
  String firstName;
  String birthDate;
  String gender;

  PersonalData({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.lastName,
    required this.firstName,
    required this.birthDate,
    required this.gender,
  });

  factory PersonalData.fromJson(Map<String, dynamic> json) => PersonalData(
    id: json['id'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    deletedAt: json['deletedAt'],
    lastName: json['lastName'],
    firstName: json['firstName'],
    birthDate: json['birthDate'],
    gender: json['gender'],
  );
}
