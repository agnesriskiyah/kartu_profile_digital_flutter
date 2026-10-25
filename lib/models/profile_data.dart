class ProfileData {
  const ProfileData({
    required this.name,
    required this.email,
    required this.phone,
    required this.bio,
  });

  final String name;
  final String email;
  final String phone;
  final String bio;

  /// Membuat salinan baru dengan sebagian data diganti.
  ProfileData copyWith({
    String? name,
    String? email,
    String? phone,
    String? bio,
  }) {
    return ProfileData(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
    );
  }
}