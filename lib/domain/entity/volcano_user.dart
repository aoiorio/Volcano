class VolcanoUser {
  VolcanoUser({
    this.id,
    this.userId,
    this.username,
    this.hashedPassword,
    this.email,
    this.icon,
    this.createdAt,
    this.updatedAt,
  });
  final int? id;
  final String? userId;
  final String? username;
  final String? hashedPassword;
  final String? email;
  final String? icon;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
