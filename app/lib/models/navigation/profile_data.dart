class ClientProfileData {
  final String name;
  final String credit;
  final String level;
  final String email;
  final String phone;
  String? photoPath;
  ClientProfileData({
    required this.name,
    required this.credit,
    required this.level,
    required this.email,
    required this.phone,
    this.photoPath,
  });
}
