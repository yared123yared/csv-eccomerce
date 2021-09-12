class ClientProfileData {
  final String name;
  final String credit;
  final String level;
  final String email;
  final String phone;
  final String creditLimitStartDate;
  final String creditLimitEndDate;
  String? photoPath;
  ClientProfileData({
    required this.name,
    required this.credit,
    required this.level,
    required this.email,
    required this.phone,
    required this.creditLimitEndDate,
    required this.creditLimitStartDate,
    this.photoPath,
  });
}
