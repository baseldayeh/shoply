class ResponseLogin {
  final String? uid;
  final String? email;
  final String? address;
  final String? fullName;
  final String? userName;
  final String? profileImage;

  ResponseLogin({
    required this.uid,
    required this.email,
    required this.address,
    required this.fullName,
    required this.userName,
    required this.profileImage,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) {
    return ResponseLogin(
      uid: json['uid'],
      email: json['email'],
      address: json['address'],
      fullName: json['fullName'],
      userName: json['userName'],
      profileImage: json['profileImage'],
    );
  }
}
