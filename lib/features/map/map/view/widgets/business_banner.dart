import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locals/core/localization/l10n_extensions.dart';

enum BannerType { businessOfTheMonth, sponsored }

class BusinessBanner extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final BannerType type;
  final VoidCallback onTap;
  final VoidCallback? onClose;

  const BusinessBanner({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.type = BannerType.businessOfTheMonth,
    required this.onTap,
    this.onClose,
  });

  @override
  State<BusinessBanner> createState() => _BusinessBannerState();
}

class _BusinessBannerState extends State<BusinessBanner>
    with SingleTickerProviderStateMixin {
  Timer? _collapseTimer;
  late AnimationController _controller;
  late Animation<double> _expandProgress;

  // Measured content width — filled after first layout
  double? _measuredTextWidth;
  final GlobalKey _textKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000), // expand: 1 s
      reverseDuration: const Duration(milliseconds: 2000), // collapse: 2 s
      vsync: this,
    );

    _expandProgress = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    // Measure text widget width after first frame, then animate in
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _textKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null && mounted) {
        setState(() => _measuredTextWidth = box.size.width);
      }
      _expand();
    });
  }

  @override
  void dispose() {
    _collapseTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _expand() {
    if (!mounted) return;
    _collapseTimer?.cancel();
    _controller.forward();

    // 5 s hold after the 1 s open = 6 s total from call
    _collapseTimer = Timer(const Duration(seconds: 6), () {
      if (mounted) _collapse();
    });
  }

  void _collapse() {
    if (!mounted) return;
    _collapseTimer?.cancel();
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final bool isBusinessOfMonth = widget.type == BannerType.businessOfTheMonth;
    const double iconSize = 56.0;
    const double hPad = 16.0; // horizontal padding inside text area

    // Full expanded width = icon + left padding + text + right padding
    final double expandedW =
        iconSize.w +
        hPad.w +
        (_measuredTextWidth ?? 180.w) + // fallback until measured
        hPad.w;
    final double collapsedW = iconSize.w;

    return Stack(
      children: [
        // ── Off-screen text measurer ──────────────────────────────────────
        // Rendered at opacity 0 so we can measure its natural width
        Positioned(
          left: -9999,
          child: Opacity(
            opacity: 0,
            child: Padding(
              key: _textKey,
              padding: EdgeInsets.symmetric(horizontal: hPad.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isBusinessOfMonth
                        ? context.l10n.busniessOfTheMonth
                        : context.l10n.sponsored,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── The actual visible banner ─────────────────────────────────────
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (_controller.isDismissed) _expand();
              widget.onTap();
            },
            borderRadius: BorderRadius.circular(28.r),
            child: AnimatedBuilder(
              animation: _expandProgress,
              builder: (context, _) {
                final double t = _expandProgress.value; // 0 → 1
                final double currentW =
                    collapsedW + (expandedW - collapsedW) * t;

                return Container(
                  height: iconSize.h,
                  width: currentW,
                  decoration: BoxDecoration(
                    color: const Color(0x66F83E5A),
                    borderRadius: BorderRadius.circular(28.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28.r),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // ── Icon circle ───────────────────────────────────
                        Container(
                          width: iconSize.w,
                          height: iconSize.h,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEA4D70),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x99EA4D70),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              isBusinessOfMonth
                                  ? Icons.emoji_events_rounded
                                  : Icons.workspace_premium_outlined,
                              color: Colors.white,
                              size: 28.sp,
                            ),
                          ),
                        ),
                        ClipRect(
  child: SizedBox(
    width: (expandedW - collapsedW) * t,
    height: iconSize.h, // important
    child: Opacity(
      opacity: ((t - 0.4) / 0.6).clamp(0.0, 1.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPad.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isBusinessOfMonth
                    ? context.l10n.busniessOfTheMonth
                    : context.l10n.sponsored,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
              ),

              SizedBox(height: 1.h),

              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ),
  ),
),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
