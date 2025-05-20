import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghiazzi/constants/colors.dart';
import 'package:ghiazzi/constants/themes.dart';
import 'package:ghiazzi/models/notification_model.dart';
import 'package:ghiazzi/views/faq_drawer.dart';
import 'package:ghiazzi/models/faq_model.dart';
import 'package:ghiazzi/viewmodels/faq_view_model.dart';
import 'package:ghiazzi/viewmodels/notifications_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:ghiazzi/viewmodels/user_session.dart';

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

class _NavItem {
  final int id;
  final String label;
  final IconData icon;

  _NavItem(this.id, this.label, this.icon);
}

class _ScaffoldWithNavigationState extends State<ScaffoldWithNavigation> {
  // Navigation labels/icons
  final List<_NavItem> navItems = [
    _NavItem(0, "Home", Icons.home_outlined),
    _NavItem(1, "Corsi", Icons.menu_book_outlined),
    _NavItem(2, "Knowledge", Icons.book_outlined),
    _NavItem(3, "Profilo", Icons.person_outlined),
  ];

  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await UserSession().restoreSession();
      if (UserSession().currentUser == null && mounted) {
        GoRouter.of(context).go('/login');
      }
    });
    context.read<FaqViewModel>().getFaq();
    context.read<NotificationsViewModel>().getNotifications();
  }

  void showFaqDrawer(BuildContext context, List<FaqModel> faqs) {
    showGeneralDialog(
      context: context,
      barrierLabel: "FAQ",
      barrierDismissible: true,
      barrierColor: Theme.of(
        context,
      ).extension<CustomPalette>()!.grey500.withAlpha(100),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
              width: 500,
              height: double.infinity,
              child: FaqDrawer(
                faqs: faqs,
                onClose: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

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
                      : Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 24,
                        ),
                      ),
              centerTitle: isWide,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: isWide ? 100 : 0, top: 16),
                  child: Row(
                    children: [
                      if (isWide)
                        VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: palette.grey0,
                        ),
                      if (isWide) SizedBox(width: 16),
                      BlocBuilder<FaqViewModel, FaqState>(
                        bloc: context.read<FaqViewModel>(),
                        builder: (context, state) {
                          return IconButton(
                            icon: const Icon(Icons.info_outline),
                            color: palette.grey1000,
                            onPressed: () {
                              if (state is FaqSuccess) {
                                showFaqDrawer(context, state.faqs);
                              }
                            },
                          );
                        },
                      ),
                      BlocBuilder<NotificationsViewModel, NotificationsState>(
                        bloc: context.read<NotificationsViewModel>(),
                        builder: (context, state) {
                          if (state is NotificationsSuccess) {
                            final List<NotificationModel> notifications =
                                state.notifications;
                            return Stack(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.notifications_none),
                                  color: palette.grey1000,
                                  onPressed: () {
                                    // Notifications
                                  },
                                ),
                                if (notifications.isNotEmpty)
                                  Positioned(
                                    right: 10,
                                    top: 12,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 8,
                                        minHeight: 8,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          } else {
                            return IconButton(
                              icon: const Icon(Icons.notifications_none),
                              color: palette.grey1000,
                              onPressed: () {
                                // Notifications
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
              iconTheme: const IconThemeData(color: Colors.grey),
              leading:
                  isWide
                      ? null
                      : Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Builder(
                          builder:
                              (context) => IconButton(
                                icon: const Icon(Icons.menu),
                                onPressed:
                                    () => Scaffold.of(context).openDrawer(),
                              ),
                        ),
                      ),
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

    // (moved _onTap and _NavItem above)
  }
}
