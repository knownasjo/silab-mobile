import 'package:material_ui/material_ui.dart';

enum AlertType { info, success, error }

SnackBar snackBar({
  String? message,
  AlertType? type,
  String? actionLabel,
  void Function()? action,
}) {
  late Color backgroundColor;
  late Color textColor;

  if (type == AlertType.error) {
    textColor = const Color(0xffFE2f60);
    backgroundColor = const Color(0xffFfD9D9);
  } else if (type == AlertType.info) {
    textColor = const Color(0xff1d1d1d);
    backgroundColor = const Color(0xffFAC730);
  } else {
    textColor = const Color(0xff50cd89);
    backgroundColor = const Color(0xffE8fff3);
  }

  return SnackBar(
    duration: const Duration(seconds: 3),
    persist:
        action != null &&
        actionLabel != null &&
        WidgetsBinding.instance.accessibilityFeatures.accessibleNavigation,
    content: Text(message!, style: TextStyle(color: textColor)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    action: (action != null && actionLabel != null)
        ? SnackBarAction(
            label: actionLabel,
            onPressed: action,
            textColor: Colors.white,
          )
        : null,
  );
}

class SnackBarWidth extends StatelessWidget {
  final Widget child;

  const SnackBarWidth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final padding = MediaQuery.paddingOf(context);
    final side = (size.width - (size.shortestSide - 30)) / 2;
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
        snackBarTheme: theme.snackBarTheme.copyWith(
          insetPadding: EdgeInsets.fromLTRB(
            (side - padding.left).clamp(0.0, double.infinity),
            0,
            (side - padding.right).clamp(0.0, double.infinity),
            16,
          ),
        ),
      ),
      child: child,
    );
  }
}
