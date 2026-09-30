import 'package:flutter/material.dart';

class AnnouncementTypeStyle {
  final String title;
  final Color color;

  const AnnouncementTypeStyle(this.title, this.color);

  static const _basic = AnnouncementTypeStyle('Pengumuman', Color(0xffFE2F60));

  static const _styles = {
    'BASIC': _basic,
    'PRACTICUM': AnnouncementTypeStyle(
      'Pendaftaran Praktikum',
      Color(0xff3272CA),
    ),
    'INHALL': AnnouncementTypeStyle('Pendaftaran Inhal', Color(0xff7239EA)),
    'ASSISTANT': AnnouncementTypeStyle(
      'Pendaftaran Asisten Praktikum',
      Color(0xff27A149),
    ),
  };

  factory AnnouncementTypeStyle.of(String? type) => _styles[type] ?? _basic;
}
