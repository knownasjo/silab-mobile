import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silab/core/common/entities/bottom_navbar/bottom_navbar_entity.dart';
import 'package:silab/core/common/widgets/custom_bottom_navbar.dart';

void useSmallPhone(WidgetTester tester) {
  tester.view.physicalSize = const Size(360, 640) * 3;
  tester.view.devicePixelRatio = 3;
  tester.view.padding = const FakeViewPadding(top: 24 * 3, bottom: 16 * 3);
  addTearDown(tester.view.reset);
}

Widget shellWithNavbar({
  required String title,
  required ScrollController controller,
  required Widget child,
  bool withAppBar = true,
}) =>
    Scaffold(
      backgroundColor: Colors.white,
      appBar: withAppBar ? AppBar(title: Text(title)) : null,
      body: SafeArea(
        child: SingleChildScrollView(controller: controller, child: child),
      ),
      extendBody: true,
      floatingActionButton: CustomBottomNavbar(
        isVisible: true,
        currentIndex: 0,
        items: [
          for (final (icon, label) in [
            ('home', 'Beranda'),
            ('schedule', 'Jadwal'),
            ('profile', 'Profil'),
          ])
            BottomNavbarEntity(
              icon: SvgPicture.asset('assets/image/$icon.svg'),
              iconActive: SvgPicture.asset('assets/image/${icon}_active.svg'),
              label: label,
            ),
        ],
        scrollController: controller,
        onTap: (_) {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

Future<void> scrollEverythingToEnd(WidgetTester tester) async {
  for (var round = 0; round < 2; round++) {
    for (final element in find.byType(Scrollable).evaluate()) {
      final scrollable = (element as StatefulElement).state as ScrollableState;
      if (scrollable.position.axis == Axis.vertical) {
        scrollable.position.jumpTo(scrollable.position.maxScrollExtent);
      }
    }
    await tester.pump();
  }
}

double navbarTop(WidgetTester tester) => tester
    .getRect(find
        .descendant(
            of: find.byType(CustomBottomNavbar),
            matching: find.byType(Container))
        .first)
    .top;
