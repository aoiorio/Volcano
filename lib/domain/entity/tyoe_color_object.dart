class TypeColorObject {
  TypeColorObject({
    this.id,
    this.colorId,
    this.type,
    this.startColorCode = '0xFFAEADB9',
    this.endColorCode = '0xffB1B1B1',
    this.createdAt,
    this.updatedAt,
  });
  final int? id;
  final String? colorId;
  final String? type;
  final String startColorCode;
  final String endColorCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
