final RegExp _campusEmail = RegExp(r'^[a-z]+(\d{10})@webmail\.uad\.ac\.id$');

String normalizeEmail(String email) => email.trim().toLowerCase();

String? nimFromCampusEmail(String email) =>
    _campusEmail.firstMatch(normalizeEmail(email))?.group(1);

final RegExp _emailFormat = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

bool isEmailFormat(String email) =>
    _emailFormat.hasMatch(normalizeEmail(email));
