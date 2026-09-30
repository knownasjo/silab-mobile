import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:silab/features/announcement/presentation/pages/pengumumman_page.dart';
import 'package:silab/features/announcement/presentation/widgets/announcement_type_style.dart';

class AnnouncementBanner extends StatefulWidget {
  final String title;
  final String body;
  final String type;
  final String author;
  final String createdAt;
  final String id;

  const AnnouncementBanner({
    super.key,
    required this.author,
    required this.body,
    required this.title,
    required this.type,
    required this.createdAt,
    required this.id,
  });

  @override
  State<AnnouncementBanner> createState() => _AnnouncementBannerState();
}

class _AnnouncementBannerState extends State<AnnouncementBanner> {
  static const int _maxBodyLines = 3;
  static const TextStyle _bodyStyle = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 14,
    color: Colors.white,
  );

  bool get _isPracticum => widget.type == 'PRACTICUM';

  int _bodyLinesThatFit(BuildContext context, double height) {
    if (!height.isFinite) return _maxBodyLines;

    final painter = TextPainter(
      text: TextSpan(
        text: widget.body,
        style: DefaultTextStyle.of(context).style.merge(_bodyStyle),
      ),
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
    );
    final lineHeight = painter.preferredLineHeight;
    painter.dispose();

    return ((height + 0.5) / lineHeight).floor().clamp(0, _maxBodyLines);
  }

  void _open() {
    if (_isPracticum) {
      context.goNamed('daftar-praktikum');
      return;
    }

    context.goNamed(
      'pengumuman',
      extra: PengumumanPageExtra(
        author: widget.author,
        body: widget.body,
        title: widget.title,
        type: widget.type,
        createdAt: widget.createdAt,
      ),
      pathParameters: {'id': widget.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    final typeStyle = AnnouncementTypeStyle.of(widget.type);

    return Container(
      width: double.infinity,
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: typeStyle.color,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    typeStyle.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: typeStyle.color,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final lines =
                          _bodyLinesThatFit(context, constraints.maxHeight);

                      if (lines == 0) return const SizedBox.shrink();

                      return SizedBox(
                        width: MediaQuery.of(context).size.width - 24,
                        child: Text(
                          widget.body,
                          style: _bodyStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: lines,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Material(
            color: const Color(0xffFFBF01),
            borderRadius: BorderRadius.circular(30),
            child: InkWell(
              onTap: _open,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 32,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  _isPracticum ? 'Daftar' : 'Pelajari lebih lanjut',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xff1d1d1d),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
