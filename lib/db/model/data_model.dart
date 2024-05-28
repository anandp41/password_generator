class PasswordModel {
  final String key;
  final String password;

  PasswordModel({required this.key, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'password': password,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      key: map['key'] as String,
      password: map['password'] as String,
    );
  }
}
