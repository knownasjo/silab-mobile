import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/app_config.dart';
import 'package:silab/core/common/widgets/custom_snackbar.dart';
import 'package:silab/features/authentication/presentation/pages/authentication_page.dart';
import 'package:silab/injector.dart';
import 'package:silab/main.dart' as prod;
import 'package:silab/main_dev.dart' as dev;
import 'package:skeletonizer/skeletonizer.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    AppConfig.create(
      appName: 'SILAB',
      baseUrl: 'http://localhost:3000',
      flavor: Flavor.prod,
    );
    await initializeDependencies();
  });

  const loginTexts = [
    'Masuk',
    'Lupa password?',
    'Belum punya akun?',
    'Daftar',
    'Password',
  ];
  const phoneSettings = [
    (1.3, false),
    (2.0, false),
    (3.12, false),
    (1.0, true),
    (3.12, true),
  ];

  Future<void> openLogin(WidgetTester tester, Widget app) async {
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await tester.pumpWidget(app);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.byType(AuthenticationPage), findsOneWidget);
  }

  Future<void> setPhoneText(
    WidgetTester tester,
    double scale, {
    required bool bold,
  }) async {
    tester.platformDispatcher.textScaleFactorTestValue = scale;
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        FakeAccessibilityFeatures(boldText: bold);
    await tester.pumpAndSettle();
  }

  (Size, FontWeight?, TextScaler) look(WidgetTester tester, String text) {
    final paragraph = tester.renderObject<RenderParagraph>(find.text(text));
    return (
      tester.getSize(find.text(text)),
      paragraph.text.style?.fontWeight,
      paragraph.textScaler,
    );
  }

  for (final (file, app) in [
    ('lib/main.dart', const prod.MainApp()),
    ('lib/main_dev.dart', const dev.MainApp()),
  ]) {
    testWidgets(
      '$file: huruf HP 1,3×, 2×, 3,12× dan Teks Tebal, juga saat diubah selagi aplikasi terbuka, tidak mengubah ukuran dan ketebalan tulisan di halaman Masuk',
      (tester) async {
        await openLogin(tester, app);

        final page = tester.element(find.byType(AuthenticationPage));
        final root = tester.element(find.byType(SkeletonizerConfig));
        expect(MediaQuery.textScalerOf(page), TextScaler.noScaling);
        expect(
          MediaQuery.of(page)
              .copyWith(textScaler: MediaQuery.textScalerOf(root)),
          MediaQuery.of(root),
        );
        final normal = {
          for (final text in loginTexts) text: look(tester, text),
        };

        for (final (scale, bold) in phoneSettings) {
          await setPhoneText(tester, scale, bold: bold);

          expect(tester.takeException(), isNull);
          expect(
            MediaQuery.textScalerOf(root).scale(10),
            closeTo(10 * scale, 1e-9),
          );
          expect(MediaQuery.boldTextOf(root), bold);
          expect(MediaQuery.boldTextOf(page), isFalse);
          for (final text in loginTexts) {
            expect(
              look(tester, text),
              normal[text],
              reason: '"$text" dengan huruf HP $scale× dan Teks Tebal $bold',
            );
          }
        }
      },
    );
  }

  for (final (file, app) in [
    ('lib/main.dart', const prod.MainApp()),
    ('lib/main_dev.dart', const dev.MainApp()),
  ]) {
    testWidgets(
      '$file: SnackBar selebar sisi pendek layar dikurangi 30 di tengah layar, juga dengan jarak aman kiri-kanan, dan tetap 16 dari batas bawah layar',
      (tester) async {
        final ratio = tester.view.devicePixelRatio;
        final inset = FakeViewPadding(
          left: 44 * ratio,
          right: 44 * ratio,
          bottom: 34 * ratio,
        );
        tester.view.padding = inset;
        tester.view.viewPadding = inset;
        addTearDown(tester.view.reset);
        await openLogin(tester, app);
        final screen = tester.view.physicalSize / ratio;

        ScaffoldMessenger.of(
          tester.element(find.byType(AuthenticationPage)),
        ).showSnackBar(snackBar(message: 'Uji pesan', type: AlertType.error));
        await tester.pumpAndSettle();

        final message = tester.getRect(
          find
              .descendant(
                of: find.byType(SnackBar),
                matching: find.byType(Material),
              )
              .first,
        );
        expect(message.width, moreOrLessEquals(screen.shortestSide - 30));
        expect(message.center.dx, moreOrLessEquals(screen.width / 2));
        expect(message.bottom, moreOrLessEquals(screen.height - 34 - 16));
      },
    );
  }

  testWidgets(
    'dialog dan SnackBar juga tidak mengikuti huruf HP 3,12× dan Teks Tebal',
    (tester) async {
      await openLogin(tester, const prod.MainApp());
      final page = tester.element(find.byType(AuthenticationPage));

      Future<(Size, FontWeight?, TextScaler)> dialogText() async {
        showDialog<void>(
          context: page,
          builder: (_) => const AlertDialog(content: Text('Uji dialog')),
        );
        await tester.pumpAndSettle();
        final result = look(tester, 'Uji dialog');
        Navigator.of(tester.element(find.text('Uji dialog'))).pop();
        await tester.pumpAndSettle();
        return result;
      }

      Future<(Size, FontWeight?, TextScaler)> snackBarText() async {
        ScaffoldMessenger.of(
          page,
        ).showSnackBar(snackBar(message: 'Uji pesan', type: AlertType.error));
        await tester.pumpAndSettle();
        final result = look(tester, 'Uji pesan');
        ScaffoldMessenger.of(page).hideCurrentSnackBar();
        await tester.pumpAndSettle();
        return result;
      }

      final dialogNormal = await dialogText();
      final snackBarNormal = await snackBarText();

      await setPhoneText(tester, 3.12, bold: true);

      expect(await dialogText(), dialogNormal);
      expect(await snackBarText(), snackBarNormal);
      expect(tester.takeException(), isNull);
    },
  );
}
