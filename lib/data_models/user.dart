import 'dart:convert';

class UserModel {
  String id;
  String? phone_number;
  UserModel({
    required this.id,
    this.phone_number,
  });

  UserModel copyWith({
    String? id,
    String? phone_number,
  }) {
    return UserModel(
      id: id ?? this.id,
      phone_number: phone_number ?? this.phone_number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'phone_number': phone_number,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['sub'] as String,
      phone_number:
          map['phone_number'] != null ? map['phone_number'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(id: $id, phone_number: $phone_number)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.phone_number == phone_number;
  }

  @override
  int get hashCode => id.hashCode ^ phone_number.hashCode;
}
