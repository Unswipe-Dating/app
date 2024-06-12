class Profile {
  final String id;
  final String userName;
  final int userAge;
  final String userDescription;
  final String profileImageSrc;
  final bool isVerified;
  final String pronouns;

  Profile({
    required this.id,
    required this.userName,
    required this.userAge,
    required this.userDescription,
    required this.profileImageSrc,
    required this.isVerified,
    required this.pronouns,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      userName: json['userName'],
      userAge: json['userAge'],
      userDescription: json['userDescription'],
      profileImageSrc: json['profileImageSrc'],
      isVerified: json['isVerified'],
      pronouns: json['pronouns'],
    );
  }
}