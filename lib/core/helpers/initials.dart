String nameInitials(String? name) {
  final words = (name ?? '')
      .trim()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .take(2);

  final initials = words.map((word) => word[0]).join().toUpperCase();

  return initials.isEmpty ? '?' : initials;
}
