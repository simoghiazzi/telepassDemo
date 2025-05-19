import 'package:flutter/material.dart';
import 'package:ghiazzi/components/custom_search_bar.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';
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
  // Navigation labels/icons
  final List<_NavItem> navItems = [
    _NavItem(0, "Home", Icons.home_outlined),
    _NavItem(1, "Corsi", Icons.menu_book_outlined),
    _NavItem(2, "Knowledge", Icons.book_outlined),
    _NavItem(3, "Profilo", Icons.person_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<CustomPalette>()!;
    final appTextStyles =
        Theme.of(context).extension<AppThemeExtension>()!.textStyles;

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth >= 800;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBar(
              backgroundColor: palette.grey100,
              elevation: 0,
              title:
                  isWide
                      ? Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: 36,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ...navItems.asMap().entries.map(
                                    (entry) => IconButton(
                                      icon: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            entry.value.icon,
                                            color:
                                                widget
                                                            .navigationShell
                                                            .currentIndex ==
                                                        entry.key
                                                    ? palette.primary800
                                                    : palette.grey300,
                                          ),
                                          Text(
                                            entry.value.label,
                                            style: appTextStyles.headingS.copyWith(
                                              color:
                                                  widget
                                                              .navigationShell
                                                              .currentIndex ==
                                                          entry.key
                                                      ? palette.primary800
                                                      : palette.grey300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      tooltip: entry.value.label,
                                      onPressed: () => _onTap(entry.value.id),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                          ],
                        ),
                      )
                      : Text(
                        "Telepass",
                        style: TextStyle(color: Colors.blue[900]),
                      ),
              centerTitle: isWide,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: isWide ? 120 : 0, top: 16),
                  child: Row(
                    children: [
                      if (isWide)
                        VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: palette.grey0,
                        ),
                      if (isWide) SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        color: palette.grey1000,
                        onPressed: () {
                          // Info
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_none),
                        color: palette.grey1000,
                        onPressed: () {
                          // Notifications
                        },
                      ),
                    ],
                  ),
                ),
              ],
              iconTheme: const IconThemeData(color: Colors.grey),
            ),
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
                            selected:
                                widget.navigationShell.currentIndex ==
                                entry.key,
                            onTap: () => _onTap(entry.key),
                          );
                        }),
                      ],
                    ),
                  ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (widget.navigationShell.currentIndex < 2)
                  CustomSearchBar(
                    label: _getSearchBarLabel(
                      widget.navigationShell.currentIndex,
                    ),
                  ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(child: widget.navigationShell),
                  ),
                ),
                Container(
                  color: palette.primary1000,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/logo.png', height: 32),
                      const SizedBox(height: 8),
                      Text(
                        'Sede legale: Via Laurentina, 449 - 00142 Roma (RM)\nP.IVA 09771701001 - Certificato ISO9001 e ISO27001',
                        style: appTextStyles.paragraphS.copyWith(
                          color: palette.grey400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          extendBody: true,
        );
      },
    );
  }

  String _getSearchBarLabel(int index) {
    switch (index) {
      case 0:
        return 'Benvenuto!'; // Home page label
      case 1:
        return 'Corsi'; // Courses page label
      // Add more cases for other pages if needed
      default:
        return 'Cerca';
    }
  }

  void _onTap(index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}

class _NavItem {
  final int id;
  final String label;
  final IconData icon;

  _NavItem(this.id, this.label, this.icon);
}
