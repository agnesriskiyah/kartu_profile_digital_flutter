enum ProfileStatus {
  student('Mahasiswa'),
  freelancer('Freelancer'),
  intern('Magang'),
  employee('Karyawan');

  const ProfileStatus(this.label);
  final String label;
}

class Project {
  final String id;
  final String title;
  final String description;
  final List<String> techStack;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.techStack,
  });
}

class Profile {
  final String name;
  final String bio;
  final ProfileStatus status;
  final bool openToWork;
  final Set<String> skills;

  const Profile({
    required this.name,
    required this.bio,
    required this.status,
    required this.openToWork,
    required this.skills,
  });

  Profile copyWith({
    String? name,
    String? bio,
    ProfileStatus? status,
    bool? openToWork,
    Set<String>? skills,
  }) =>
      Profile(
        name: name ?? this.name,
        bio: bio ?? this.bio,
        status: status ?? this.status,
        openToWork: openToWork ?? this.openToWork,
        skills: skills ?? this.skills,
      );
}