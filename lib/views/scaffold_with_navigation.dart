import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigation extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final GoRouterState state;

  const ScaffoldWithNavigation({
    super.key,
    required this.navigationShell,
    required this.state,
  });

  @override
  State<ScaffoldWithNavigation> createState() => _ScaffoldWithNavigationState();
}

class _ScaffoldWithNavigationState extends State<ScaffoldWithNavigation> {
  int _selectedIndex = 0;

  // Navigation labels/icons
  final List<_NavItem> navItems = [
    _NavItem("Home", Icons.home),
    _NavItem("Corsi", Icons.menu_book),
    _NavItem("Knowledge", Icons.book),
    _NavItem("Profilo", Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth >= 800;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: !isWide,
            leading: isWide ? Image.asset('assets/images/logo.png') : null,
            title:
                isWide
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          navItems
                              .asMap()
                              .entries
                              .map(
                                (entry) => IconButton(
                                  icon: Icon(
                                    entry.value.icon,
                                    color:
                                        _selectedIndex == entry.key
                                            ? Colors.blue[900]
                                            : Colors.grey,
                                  ),
                                  tooltip: entry.value.label,
                                  onPressed: () => _onTap(entry.key),
                                ),
                              )
                              .toList(),
                    )
                    : Text(
                      "Telepass",
                      style: TextStyle(color: Colors.blue[900]),
                    ),
            centerTitle: isWide,
            actions: [
              IconButton(
                icon: const Icon(Icons.info_outline),
                color: Colors.grey,
                onPressed: () {
                  // Info
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none),
                color: Colors.grey,
                onPressed: () {
                  // Notifications
                },
              ),
            ],
            iconTheme: const IconThemeData(color: Colors.grey),
          ),
          drawer:
              isWide
                  ? null
                  : Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                          decoration: const BoxDecoration(
                            color: Color(0xFF08155E),
                          ),
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        ...navItems.asMap().entries.map((entry) {
                          return ListTile(
                            leading: Icon(entry.value.icon),
                            title: Text(entry.value.label),
                            onTap: () => _onTap(entry.key),
                          );
                        }),
                      ],
                    ),
                  ),
          body: SafeArea(bottom: false, child: widget.navigationShell),
          extendBody: true,
        );
      },
    );
  }

  void _onTap(index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
    setState(() {
      _selectedIndex = index;
    });
  }
}

class _NavItem {
  final String label;
  final IconData icon;

  _NavItem(this.label, this.icon);
}
