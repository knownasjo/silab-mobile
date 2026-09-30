import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/features/announcement/domain/entities/announcement/announcement_entity.dart';
import 'package:silab/features/announcement/presentation/blocs/get_all_announcements/get_all_announcements_bloc.dart';
import 'package:silab/features/announcement/presentation/widgets/announcement_banner.dart';
import 'package:silab/features/announcement/presentation/widgets/build_announcement_success.dart';

const cases = [
  ('BASIC', 'Pengumuman', Color(0xffFE2F60), 'Pelajari lebih lanjut'),
  ('PRACTICUM', 'Pendaftaran Praktikum', Color(0xff3272CA), 'Daftar'),
  ('INHALL', 'Pendaftaran Inhal', Color(0xff7239EA), 'Pelajari lebih lanjut'),
  (
    'ASSISTANT',
    'Pendaftaran Asisten Praktikum',
    Color(0xff27A149),
    'Pelajari lebih lanjut'
  ),
  ('JENIS_BARU', 'Pengumuman', Color(0xffFE2F60), 'Pelajari lebih lanjut'),
];

const longTitle = 'Judul pengumuman yang sangat panjang sekali sekali sekali';

Future<void> pumpCarousel(
  WidgetTester tester,
  String type, {
  String title = longTitle,
  Size size = const Size(360, 640),
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final announcement = AnnouncementEntity(
    id: 'a1',
    title: title,
    type: type,
    body: 'Isi ${'kata ' * 190}',
    created_at: DateTime.now().toIso8601String(),
    author: 'Laboran',
  );

  final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Scaffold(
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
    ),
    GoRoute(
      path: '/daftar',
      name: 'daftar-praktikum',
      builder: (context, state) => const Text('Halaman Pendaftaran Praktikum'),
    ),
    GoRoute(
      path: '/pengumuman/:id',
      name: 'pengumuman',
      builder: (context, state) =>
          Text('Halaman detail ${state.pathParameters['id']}'),
    ),
  ]);
  addTearDown(router.dispose);

  await tester.pumpWidget(MaterialApp.router(routerConfig: router));
  await tester.pumpAndSettle();
}

Text bodyText(WidgetTester tester) => tester
    .widgetList<Text>(find.descendant(
      of: find.byType(AnnouncementBanner),
      matching: find.byType(Text),
    ))
    .firstWhere((t) => t.data!.startsWith('Isi'));

void expectBodyNotCut(WidgetTester tester) {
  final body = bodyText(tester);
  final rect = tester.getRect(find.byWidget(body));
  final painter = TextPainter(
    text: TextSpan(
      text: body.data,
      style: DefaultTextStyle.of(tester.element(find.byWidget(body)))
          .style
          .merge(body.style),
    ),
    textDirection: TextDirection.ltr,
    maxLines: body.maxLines,
    ellipsis: '…',
  )..layout(maxWidth: rect.width);

  expect(painter.height, lessThanOrEqualTo(rect.height + 0.5),
      reason: 'baris terakhir isi terpotong setengah');
  painter.dispose();
}

Rect pillRect(WidgetTester tester, String label) {
  const yellow = Color(0xffFFBF01);
  final pill = find.ancestor(
    of: find.text(label),
    matching: find.byWidgetPredicate((w) =>
        (w is Material && w.color == yellow) ||
        (w is Container &&
            w.decoration is BoxDecoration &&
            (w.decoration! as BoxDecoration).color == yellow)),
  );
  return tester.getRect(pill.first);
}

void main() {
  for (final (type, label, color, button) in cases) {
    testWidgets('$type: warna kartu, label "$label", tombol "$button"',
        (tester) async {
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
      final buttonRect = tester.getRect(find.text(button));
      expect(chipRect.top - bannerRect.top, inInclusiveRange(0, 20));
      expect(chipRect.left - bannerRect.left, inInclusiveRange(0, 24));
      expect(buttonRect.bottom, lessThanOrEqualTo(bannerRect.bottom));
      expect(
        find.text(button == 'Daftar' ? 'Pelajari lebih lanjut' : 'Daftar'),
        findsNothing,
      );
    });
  }

  testWidgets(
      'judul 2 baris: isi dipotong dengan elipsis di baris utuh terakhir, tidak terpotong setengah',
      (tester) async {
    for (final size in [const Size(360, 640), const Size(393, 851)]) {
      await pumpCarousel(tester, 'BASIC', size: size);

      expect(tester.takeException(), isNull);

      final title = tester.widget<Text>(find.text(longTitle));
      final body = bodyText(tester);
      expect(title.maxLines, 2);
      expect(title.overflow, TextOverflow.ellipsis);
      expect(body.maxLines, inInclusiveRange(1, 3));
      expect(body.overflow, TextOverflow.ellipsis);
      expectBodyNotCut(tester);

      final bannerRect = tester.getRect(find.byType(AnnouncementBanner));
      final bodyRect = tester.getRect(find.byWidget(body));
      final buttonRect = tester.getRect(find.text('Pelajari lebih lanjut'));
      expect(bodyRect.bottom, lessThanOrEqualTo(buttonRect.top));
      expect(buttonRect.bottom, lessThanOrEqualTo(bannerRect.bottom));
    }
  });

  testWidgets(
      'judul pendek: isi mendapat baris lebih banyak, tetap tidak terpotong',
      (tester) async {
    await pumpCarousel(tester, 'BASIC');
    final withLongTitle = bodyText(tester).maxLines!;

    await pumpCarousel(tester, 'BASIC', title: 'Libur');

    expect(bodyText(tester).maxLines, greaterThan(withLongTitle));
    expect(bodyText(tester).maxLines, lessThanOrEqualTo(3));
    expectBodyNotCut(tester);
  });

  testWidgets(
      'seluruh tombol kuning bisa ditekan: Daftar membuka Pendaftaran Praktikum',
      (tester) async {
    await pumpCarousel(tester, 'PRACTICUM');

    final rect = pillRect(tester, 'Daftar');
    await tester.tapAt(Offset(rect.right - 6, rect.center.dy));
    await tester.pumpAndSettle();

    expect(find.text('Halaman Pendaftaran Praktikum'), findsOneWidget);
  });

  testWidgets(
      'seluruh tombol kuning bisa ditekan: Pelajari lebih lanjut membuka detail',
      (tester) async {
    await pumpCarousel(tester, 'BASIC');

    final rect = pillRect(tester, 'Pelajari lebih lanjut');
    await tester.tapAt(Offset(rect.left + 6, rect.center.dy));
    await tester.pumpAndSettle();

    expect(find.text('Halaman detail a1'), findsOneWidget);
  });
}
