class UserManagement {
  late int id;
  late String username;
  late String name;
  late String role;

  UserManagement.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    username = jsonMap['username'];
    name = jsonMap['name'];
    role = jsonMap['role'];
  }
}
