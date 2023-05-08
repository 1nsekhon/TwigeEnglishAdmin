class AdminUser {
  final String? uid;
  String? email = "";
  bool approved = true;
  AdminUser({required this.uid});
}

class StudentUser {
  final String? uid;
  String? name = "";
  String? phoneNumber = "";
  int points = 0;
  StudentUser({required this.uid});
}
