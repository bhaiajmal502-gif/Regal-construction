import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_spacing.dart';
import '../../widgets/cards/premium_card.dart';
import '../../widgets/cards/summary_card.dart';
import '../../widgets/headers/app_header.dart';
import '../../widgets/navigation/bottom_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedNavIndex = 0;

  final List<BottomNavItem> navItems = [
    BottomNavItem(icon: Icons.dashboard_rounded, label: 'Dashboard'),
    BottomNavItem(icon: Icons.category_rounded, label: 'Material'),
    BottomNavItem(icon: Icons.groups_rounded, label: 'Labour'),
    BottomNavItem(icon: Icons.assessment_rounded, label: 'Reports'),
    BottomNavItem(icon: Icons.settings_rounded, label: 'Settings'),
  ];

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Premium Header
            AppHeader(
              companyName: 'Regal Company',
              greeting: _getGreeting(),
              date: _getCurrentDate(),
              onProfileTap: () {
                // Handle profile tap
              },
            ),
            // Main Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Monthly Summary Section
                  Text(
                    'Monthly Summary',
                    style: AppTypography.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildMonthlySummary(),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // Action Cards Section
                  Text(
                    'Quick Access',
                    style: AppTypography.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildActionCards(),
                  const SizedBox(height: 100), // Space for bottom nav
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedNavIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedNavIndex = index;
          });
          // Handle navigation
          switch (index) {
            case 0:
              // Dashboard already selected
              break;
            case 1:
              // Navigate to Material
              break;
            case 2:
              // Navigate to Labour
              break;
            case 3:
              // Navigate to Reports
              break;
            case 4:
              // Navigate to Settings
              break;
          }
        },
        items: navItems,
      ),
    );
  }

  Widget _buildMonthlySummary() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.premiumGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Month',
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: AppSpacing.marginLarge),
          GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: AppSpacing.marginMedium,
            mainAxisSpacing: AppSpacing.marginMedium,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildSummaryItem(
                label: 'Material',
                value: '₹45,250',
                icon: Icons.category_rounded,
              ),
              _buildSummaryItem(
                label: 'Labour',
                value: '₹32,000',
                icon: Icons.groups_rounded,
              ),
              _buildSummaryItem(
                label: 'Total',
                value: '₹77,250',
                icon: Icons.trending_up_rounded,
                isTotal: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required String label,
    required String value,
    required IconData icon,
    bool isTotal = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingSmall),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(height: AppSpacing.marginSmall),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: isTotal ? 16 : 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionCards() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppSpacing.marginMedium,
      mainAxisSpacing: AppSpacing.marginMedium,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        PremiumCard(
          title: 'Daily Work',
          subtitle: 'Log today\'s work',
          icon: Icons.work_outline_rounded,
          iconColor: AppColors.primary,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Daily Work tapped')),
            );
          },
        ),
        PremiumCard(
          title: 'Material Entry',
          subtitle: 'Add materials',
          icon: Icons.inventory_2_outlined,
          iconColor: AppColors.accent,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Material Entry tapped')),
            );
          },
        ),
        PremiumCard(
          title: 'Labour Payment',
          subtitle: 'Manage payments',
          icon: Icons.payments_outlined,
          iconColor: AppColors.success,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Labour Payment tapped')),
            );
          },
        ),
        PremiumCard(
          title: 'Reports',
          subtitle: 'View analytics',
          icon: Icons.assessment_outlined,
          iconColor: AppColors.info,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reports tapped')),
            );
          },
        ),
      ],
    );
  }
}
