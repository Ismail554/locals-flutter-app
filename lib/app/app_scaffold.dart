import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/shared/components/bottom_nav_bar.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  static const _tabPaths = ['/map', '/explore', '/missions', '/rank', '/profile'];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _indexFromLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: index,
        onSelected: (i) => _onTap(context, i),
      ),
    );
  }

  static int _indexFromLocation(String location) {
    if (location.startsWith('/explore')) return 1;
    if (location.startsWith('/missions')) return 2;
    if (location.startsWith('/rank')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  static void _onTap(BuildContext context, int index) {
    if (index >= 0 && index < _tabPaths.length) {
      context.go(_tabPaths[index]);
    }
  }
}
