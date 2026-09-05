import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/controllers/bottom_nav_controller.dart';
import '../../home/screens/home_screen.dart';
import '../../plan/screens/plan_screen.dart';
import '../../recipes/screens/my_recipes_screen.dart';
import '../../explore/screens/explore_screen.dart';
import '../../profile/screens/profile_screen.dart';

// main shell — persistent bottom nav + IndexedStack keeps tab state alive
// IndexedStack is preferred over PageView here because tabs should not reset
// their scroll position when switching between them
class MainShellScreen extends StatelessWidget {
  const MainShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController navCtrl = Get.find<BottomNavController>();

    // all tab screens declared here — indexed to match nav items below
    const List<Widget> pages = [
      HomeScreen(),
      PlanScreen(),
      MyRecipesScreen(),
      ExploreScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Obx(
        () => IndexedStack(
          index: navCtrl.currentIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: _AppBottomNav(navCtrl: navCtrl),
    );
  }
}

// custom bottom navigation bar matching figma design
class _AppBottomNav extends StatelessWidget {
  final BottomNavController navCtrl;

  const _AppBottomNav({required this.navCtrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navBar,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        child: Obx(
          () => Row(
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                index: 0,
                currentIndex: navCtrl.currentIndex.value,
                onTap: () => navCtrl.changeTo(0),
              ),
              _NavItem(
                icon: Icons.calendar_today_outlined,
                activeIcon: Icons.calendar_today,
                label: 'Plan',
                index: 1,
                currentIndex: navCtrl.currentIndex.value,
                onTap: () => navCtrl.changeTo(1),
              ),
              _NavItem(
                icon: Icons.menu_book_outlined,
                activeIcon: Icons.menu_book,
                label: 'Recipes',
                index: 2,
                currentIndex: navCtrl.currentIndex.value,
                onTap: () => navCtrl.changeTo(2),
              ),
              _NavItem(
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore,
                label: 'Explore',
                index: 3,
                currentIndex: navCtrl.currentIndex.value,
                onTap: () => navCtrl.changeTo(3),
              ),
              _NavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                index: 4,
                currentIndex: navCtrl.currentIndex.value,
                onTap: () => navCtrl.changeTo(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// individual nav item — active state changes icon and label color
class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                color: isActive ? AppColors.navActive : AppColors.navInactive,
                size: 24,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: AppTextStyles.navLabel.copyWith(
                  color: isActive ? AppColors.navActive : AppColors.navInactive,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
