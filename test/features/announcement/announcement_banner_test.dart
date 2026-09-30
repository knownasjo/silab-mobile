import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silab/features/announcement/domain/entities/announcement/announcement_entity.dart';
import 'package:silab/features/announcement/presentation/blocs/get_all_announcements/get_all_announcements_bloc.dart';
import 'package:silab/features/announcement/presentation/widgets/announcement_banner.dart';
import 'package:silab/features/announcement/presentation/widgets/build_announcement_success.dart';

const cases = [
  ('BASIC', 'Pengumuman', Color(0xffFE2F60)),
  ('PRACTICUM', 'Pendaftaran Praktikum', Color(0xff3272CA)),
  ('INHALL', 'Pendaftaran Inhal', Color(0xff7239EA)),
  ('ASSISTANT', 'Pendaftaran Asisten Praktikum', Color(0xff27A149)),
  ('JENIS_BARU', 'Pengumuman', Color(0xffFE2F60)),
];

Future<void> pumpCarousel(WidgetTester tester, String type) async {
  tester.view.physicalSize = const Size(360, 640);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final announcement = AnnouncementEntity(
    id: 'a1',
    title: 'Judul pengumuman yang sangat panjang ${'sekali ' * 10}',
    type: type,
    body: 'Isi ${'kata ' * 190}',
    created_at: DateTime.now().toIso8601String(),
    author: 'Laboran',
  );

  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: SizedBox(
        height: 210,
        width: double.infinity,
        child: BuildAnnouncementSuccess(
          announcements: [announcement],
          state: GetAllAnnouncementsLoaded(announcements: [announcement]),
          currentPage: 0,
          onPageChanged: (_) {},
        ),
      ),
    ),
  ));
  await tester.pumpAndSettle();
}

void main() {
  for (final (type, label, color) in cases) {
    testWidgets('$type: warna kartu dan label "$label"', (tester) async {
      await pumpCarousel(tester, type);

      expect(tester.takeException(), isNull);

      final banner = find.byType(AnnouncementBanner);
      final card = tester.widget<Container>(
        find.descendant(of: banner, matching: find.byType(Container)).first,
      );
      expect((card.decoration! as BoxDecoration).color, color);

      final chip = tester.widget<Text>(find.text(label));
      expect(chip.style!.color, color);

      final bannerRect = tester.getRect(banner);
      final chipRect = tester.getRect(find.text(label));
      final buttonRect = tester.getRect(find.text('Pelajari lebih lanjut'));
      expect(chipRect.top - bannerRect.top, inInclusiveRange(0, 20));
      expect(chipRect.left - bannerRect.left, inInclusiveRange(0, 24));
      expect(buttonRect.bottom, lessThanOrEqualTo(bannerRect.bottom));
    });
  }

  testWidgets('judul dan isi panjang dipotong dengan elipsis, tidak meluap',
      (tester) async {
    await pumpCarousel(tester, 'PRACTICUM');

    expect(tester.takeException(), isNull);

    final texts = tester
        .widgetList<Text>(find.descendant(
          of: find.byType(AnnouncementBanner),
          matching: find.byType(Text),
        ))
        .toList();
    final title = texts.firstWhere((t) => t.data!.startsWith('Judul'));
    final body = texts.firstWhere((t) => t.data!.startsWith('Isi'));
    expect(title.maxLines, 2);
    expect(title.overflow, TextOverflow.ellipsis);
    expect(body.maxLines, 3);
    expect(body.overflow, TextOverflow.ellipsis);

    final bannerRect = tester.getRect(find.byType(AnnouncementBanner));
    final bodyRect = tester.getRect(find.byWidget(body));
    final buttonRect = tester.getRect(find.text('Pelajari lebih lanjut'));
    expect(bodyRect.bottom, lessThanOrEqualTo(buttonRect.top));
    expect(buttonRect.bottom, lessThanOrEqualTo(bannerRect.bottom));
  });
}
