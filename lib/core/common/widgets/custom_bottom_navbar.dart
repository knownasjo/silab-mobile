import 'package:material_ui/material_ui.dart';
import 'package:silab/core/common/entities/bottom_navbar/bottom_navbar_entity.dart';

const double bottomNavbarSpace = 100;

double _lowerBy(TargetPlatform platform, double bottomInset) =>
    platform == TargetPlatform.iOS && bottomInset > 0 ? 8 : 0;

class BottomNavbarLocation extends StandardFabLocation
    with FabCenterOffsetX, FabFloatOffsetY {
  final TargetPlatform platform;

  const BottomNavbarLocation(this.platform);

  @override
  double getOffsetY(
    ScaffoldPrelayoutGeometry scaffoldGeometry,
    double adjustment,
  ) =>
      super.getOffsetY(scaffoldGeometry, adjustment) +
      _lowerBy(platform, scaffoldGeometry.minViewPadding.bottom);

  @override
  bool operator ==(Object other) =>
      other is BottomNavbarLocation && other.platform == platform;

  @override
  int get hashCode => platform.hashCode;
}

class CustomBottomNavbar extends StatefulWidget {
  final List<BottomNavbarEntity> items;
  final void Function(int) onTap;
  final int currentIndex;
  final ScrollController scrollController;
  final bool isVisible;

  const CustomBottomNavbar({
    super.key,
    this.currentIndex = 0,
    required this.items,
    required this.onTap,
    required this.scrollController,
    required this.isVisible,
  });

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slide = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateVisibility();
  }

  @override
  void didUpdateWidget(CustomBottomNavbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateVisibility();
  }

  void _updateVisibility() {
    final isKeyboardOpen = MediaQuery.viewInsetsOf(context).bottom > 0;

    if (widget.isVisible && !isKeyboardOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isIos = platform == TargetPlatform.iOS;
    final view = View.of(context);
    final bottomInset = view.viewPadding.bottom / view.devicePixelRatio;
    const barHeight = 52.0;
    final barWidth = (MediaQuery.sizeOf(context).shortestSide - 30).clamp(
      0.0,
      double.infinity,
    );
    final lowerBy = _lowerBy(platform, bottomInset);
    final slotHeight = barHeight + 12 + lowerBy;

    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: Offset(
          0,
          isIos
              ? (2 * (barHeight + 12) - lowerBy) / slotHeight
              : 1.2 + bottomInset / slotHeight,
        ),
      ).animate(_slide),
      child: Container(
        width: barWidth,
        height: barHeight,
        margin: EdgeInsets.only(right: 15, left: 15, top: 12 + lowerBy),
        decoration: BoxDecoration(
          color: const Color(0xff3272CA),
          borderRadius: BorderRadius.circular(90),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemsWidth = 80.0 * widget.items.length;
            final sideGap = ((constraints.maxWidth - itemsWidth) / 2).clamp(
              0.0,
              45.0,
            );
            final halfGap =
                ((constraints.maxWidth - 2 * sideGap - itemsWidth) /
                        (widget.items.length - 1) /
                        2)
                    .clamp(0.0, double.infinity);

            return Row(
              children: widget.items
                  .map(
                    (item) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        widget.onTap(widget.items.indexOf(item));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: item == widget.items.first ? sideGap : halfGap,
                          right: item == widget.items.last ? sideGap : halfGap,
                        ),
                        child: SizedBox(
                          width: 80,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                                child:
                                    widget.currentIndex ==
                                        widget.items.indexOf(item)
                                    ? item.iconActive
                                    : item.icon,
                              ),
                              const SizedBox(height: 2),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                style: TextStyle(
                                  fontSize:
                                      widget.currentIndex ==
                                          widget.items.indexOf(item)
                                      ? 11
                                      : 10,
                                  color:
                                      widget.currentIndex ==
                                          widget.items.indexOf(item)
                                      ? Colors.white
                                      : Colors.white70,
                                  fontWeight:
                                      widget.currentIndex ==
                                          widget.items.indexOf(item)
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                child: Text(item.label),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
