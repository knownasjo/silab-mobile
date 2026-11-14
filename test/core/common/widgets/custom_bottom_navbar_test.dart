import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:silab/core/common/entities/bottom_navbar/bottom_navbar_entity.dart';
import 'package:silab/core/common/widgets/custom_bottom_navbar.dart';

const iPhoneAndAndroid = TargetPlatformVariant({
  TargetPlatform.iOS,
  TargetPlatform.android,
});

bool get onIPhone => defaultTargetPlatform == TargetPlatform.iOS;

void main() {
  late ScrollController controller;

  setUp(() => controller = ScrollController());
  tearDown(() => controller.dispose());

  Future<void> openNavbar(WidgetTester tester, {bool isVisible = true}) async {
    const insets = FakeViewPadding(top: 44 * 3, bottom: 34 * 3);
    tester.view.physicalSize = const Size(375, 812) * 3;
    tester.view.devicePixelRatio = 3;
    tester.view.padding = insets;
    tester.view.viewPadding = insets;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              controller: controller,
              child: const SizedBox(height: 2000),
            ),
          ),
          extendBody: true,
          floatingActionButton: CustomBottomNavbar(
            isVisible: isVisible,
            currentIndex: 0,
            items: [
              for (final (icon, label) in [
                ('home', 'Beranda'),
                ('schedule', 'Jadwal'),
                ('profile', 'Profil'),
              ])
                BottomNavbarEntity(
                  icon: SvgPicture.asset('assets/image/$icon.svg'),
                  iconActive: SvgPicture.asset(
                    'assets/image/${icon}_active.svg',
                  ),
                  label: label,
                ),
            ],
            scrollController: controller,
            onTap: (_) {},
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Rect bar(WidgetTester tester) => tester.getRect(
    find
        .descendant(
          of: find.byType(CustomBottomNavbar),
          matching: find.byType(DecoratedBox),
        )
        .first,
  );

  double fontSizeOf(WidgetTester tester, String label) => tester
      .widget<AnimatedDefaultTextStyle>(
        find.descendant(
          of: find.byType(CustomBottomNavbar),
          matching: find.ancestor(
            of: find.text(label),
            matching: find.byType(AnimatedDefaultTextStyle),
          ),
        ),
      )
      .style
      .fontSize!;

  testWidgets(
    'bilah menu bawah di iPhone lebih kecil dan lebih dekat ke garis home, di Android tetap',
    (tester) async {
      await openNavbar(tester);

      final shown = bar(tester);
      expect(shown.width, moreOrLessEquals(345));
      expect(shown.height, moreOrLessEquals(onIPhone ? 52 : 70));
      expect(812 - shown.bottom, moreOrLessEquals(onIPhone ? 42 : 50));
      expect(
        tester.getSize(find.byType(SvgPicture).first).height,
        onIPhone ? 20 : 24,
      );
      expect(fontSizeOf(tester, 'Beranda'), onIPhone ? 11 : 14);
      expect(fontSizeOf(tester, 'Jadwal'), onIPhone ? 10 : 12);
    },
    variant: iPhoneAndAndroid,
  );

  testWidgets(
    'bilah menu bawah di iPhone hilang penuh dari layar saat disembunyikan',
    (tester) async {
      await openNavbar(tester, isVisible: false);

      expect(bar(tester).top, greaterThanOrEqualTo(812));
    },
    variant: TargetPlatformVariant.only(TargetPlatform.iOS),
  );
}
