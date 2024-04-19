class User {
  final String id;
  final String name;
  final String email;
  final int phone;
  final String password;
  final String profileImage;
  // final String jwtToken;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.profileImage,
    // required this.jwtToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      profileImage: json['profileImage'],
      // jwtToken: json['jwtToken']
    );
  }
}
