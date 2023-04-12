class User {
  final String name;
  final String description;
  final bool gender;
  DateTime birthday;
  final String avatar;

  User({
    required this.name,
    required this.gender,
    required this.description,
    required this.avatar,
    required this.birthday,
  });
}

final users = [
  User(
      name: 'name 1',
      gender: true,
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1)),
  User(
      name: 'name 2',
      gender: true,
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1)),
  User(
      name: 'name 3',
      gender: true,
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1)),
  User(
      name: 'name 4',
      gender: true,
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1)),
  User(
      name: 'name 5',
      gender: true,
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1)),
  User(
      name: 'name 6',
      gender: true,
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1)),
  User(
      name: 'name 7',
      gender: true,
      description: 'he the man',
      avatar: "assets/images/avatar.jpg",
      birthday: DateTime(1)),
];
