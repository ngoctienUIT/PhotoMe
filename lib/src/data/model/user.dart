import 'package:intl/intl.dart';

class User {
  final String name;
  final String description;
  final String gender;
  DateTime birthday;
  String avatar;
  final String job;

  User({
    required this.name,
    required this.gender,
    required this.description,
    required this.avatar,
    required this.birthday,
    required this.job,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "gender": gender,
      "birthday": DateFormat("dd/MM/yyyy").format(birthday),
      "avatar": avatar,
      "description": description,
      "job": job,
    };
  }
}

final users = [
  User(
      name: 'name 1',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
  User(
      name: 'name 2',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
  User(
      name: 'name 3',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
  User(
      name: 'name 4',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
  User(
      name: 'name 5',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
  User(
      name: 'name 6',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
  User(
      name: 'name 7',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
  User(
      name: 'name 7',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
  User(
      name: 'name 7',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
  User(
      name: 'name 7',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
  User(
      name: 'name 7',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
  User(
      name: 'name 7',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
  User(
      name: 'name 7',
      gender: "male",
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1),
      job: "IT"),
];
