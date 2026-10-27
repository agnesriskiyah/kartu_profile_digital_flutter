class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const profile = '/profile';
  static const editProfile = '/profile/edit';

  /// Path berparameter untuk Detail Proyek (anak dari Profil)
  static String projectDetail(String id) => '/profile/projects/$id';
}   