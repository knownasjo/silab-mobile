import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silab/core/common/widgets/custom_form_field.dart';
import 'package:silab/core/helpers/ios_keyboard.dart';

const iPhoneAndAndroid = TargetPlatformVariant({
  TargetPlatform.iOS,
  TargetPlatform.android,
});

bool get onIPhone => defaultTargetPlatform == TargetPlatform.iOS;

void main() {
  late TextEditingController controller;

  setUp(() => controller = TextEditingController());
  tearDown(() => controller.dispose());

  Future<void> openField(WidgetTester tester, {bool isObscure = false}) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 200),
            child: CustomFormField(
              hintText: 'Password',
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text,
              isObscure: isObscure,
              validator: null,
              suffixIcon: null,
              controller: controller,
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byType(TextFormField));
    await tester.pump();
  }

  bool fieldFocused(WidgetTester tester) => tester
      .state<EditableTextState>(find.byType(EditableText))
      .widget
      .focusNode
      .hasFocus;

  int hideCount(WidgetTester tester) => tester.testTextInput.log
      .where((call) => call.method == 'TextInput.hide')
      .length;

  testWidgets(
    'ketuk di luar kolom: papan ketik tertutup di iPhone, Android tetap',
    (tester) async {
      await openField(tester);
      expect(fieldFocused(tester), isTrue);
      expect(tester.testTextInput.isVisible, isTrue);

      await tester.tapAt(const Offset(20, 60));
      await tester.pump();

      expect(fieldFocused(tester), !onIPhone);
      expect(tester.testTextInput.isVisible, !onIPhone);
    },
    variant: iPhoneAndAndroid,
  );

  testWidgets('ketuk ikon mata kolom password: papan ketik tetap terbuka', (
    tester,
  ) async {
    await openField(tester, isObscure: true);
    const show = ExactAssetImage('assets/image/show-password.png', scale: 2);
    const hide = ExactAssetImage('assets/image/hide-password.png', scale: 2);
    await tester.runAsync(
      () => precacheImage(show, tester.element(find.byType(TextFormField))),
    );
    await tester.pump();

    await tester.tap(find.image(show));
    await tester.pump();

    expect(find.image(hide), findsOneWidget);
    expect(fieldFocused(tester), isTrue);
    expect(tester.testTextInput.isVisible, isTrue);
  }, variant: iPhoneAndAndroid);

  testWidgets(
    'papan ketik yang dikembalikan iOS ditutup oleh hideIosKeyboard',
    (tester) async {
      await openField(tester);
      tester.testTextInput.closeConnection();
      await tester.pump();
      expect(fieldFocused(tester), isFalse);
      tester.testTextInput.log.clear();

      hideIosKeyboard();
      await tester.pump();

      expect(hideCount(tester), onIPhone ? 1 : 0);
    },
    variant: iPhoneAndAndroid,
  );
}
