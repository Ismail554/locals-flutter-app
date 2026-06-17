import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locals/shared/components/bottom_nav_bar.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  static const _tabPaths = ['/map', '/explore', '/missions', '/rank', '/profile'];

  static bool _showsBottomBar(String location) {
    final path = Uri.parse(location).path;
    return _tabPaths.contains(path);
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _indexFromLocation(location);
    final showBottomBar = _showsBottomBar(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: showBottomBar
          ? BottomNavBar(
              selectedIndex: index,
              onSelected: (i) => _onTap(context, i),
            )
          : null,
    );
  }

  static int _indexFromLocation(String location) {
    final path = Uri.parse(location).path;
    if (path == '/explore') return 1;
    if (path == '/missions') return 2;
    if (path == '/rank') return 3;
    if (path == '/profile') return 4;
    return 0;
  }

  static void _onTap(BuildContext context, int index) {
    if (index >= 0 && index < _tabPaths.length) {
      context.go(_tabPaths[index]);
    }
  }
}
