class UserModel {
  int id;
  String createdAt;
  String? updatedAt;
  String? deletedAt;
  String? email;
  String username;
  int position;
  String profileImage;
  int points;
  String? token;
  String? tokenExpDate;
  PersonalData personalData;

  UserModel({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.email,
    required this.username,
    required this.position,
    required this.profileImage,
    required this.points,
    this.token,
    this.tokenExpDate,
    required this.personalData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    deletedAt: json['deletedAt'],
    email: json['email'],
    username: json['username'],
    position: json['position'],
    profileImage: json['profileImage'],
    points: json['points'],
    token: json['token'],
    tokenExpDate: json['tokenExpDate'],
    personalData: PersonalData.fromJson(json['personalData']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'deletedAt': deletedAt,
    'email': email,
    'username': username,
    'position': position,
    'profileImage': profileImage,
    'points': points,
    'token': token,
    'tokenExpDate': tokenExpDate,
    'personalData': personalData.toJson(),
  };
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'deletedAt': deletedAt,
    'lastName': lastName,
    'firstName': firstName,
    'birthDate': birthDate,
    'gender': gender,
  };
}
