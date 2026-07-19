import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_spacing.dart';
import '../../widgets/cards/summary_card.dart';
import '../../widgets/headers/app_header.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedPeriod = 'This Month';
  final List<String> periods = ['This Week', 'This Month', 'Last Month', 'Custom'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeader(
              companyName: 'Reports & Analytics',
              greeting: 'Project Overview',
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Period Selector
                  _buildPeriodSelector(),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // Summary Cards
                  Text(
                    'Material Breakdown',
                    style: AppTypography.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildMaterialSummary(),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // Labour Summary
                  Text(
                    'Labour Overview',
                    style: AppTypography.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildLabourSummary(),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // Top Materials Table
                  Text(
                    'Top Materials by Cost',
                    style: AppTypography.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildMaterialsTable(),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // Grand Total
                  _buildGrandTotalCard(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: periods.map((period) {
          final isSelected = _selectedPeriod == period;
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.marginSmall),
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedPeriod = period);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMedium,
                  vertical: AppSpacing.paddingSmall,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected ? AppColors.premiumGradient : null,
                  color: isSelected ? null : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textLight,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Text(
                  period,
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMaterialSummary() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppSpacing.marginMedium,
      mainAxisSpacing: AppSpacing.marginMedium,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SummaryCard(
          label: 'Cement',
          value: '₹18,500',
          icon: Icons.category_rounded,
          iconColor: Colors.orange,
          backgroundColor: Colors.orange,
          trend: '+12%',
          isTrendPositive: false,
        ),
        SummaryCard(
          label: 'Steel',
          value: '₹22,800',
          icon: Icons.construction_rounded,
          iconColor: Colors.grey,
          backgroundColor: Colors.grey,
          trend: '+8%',
          isTrendPositive: false,
        ),
        SummaryCard(
          label: 'Sand',
          value: '₹3,950',
          icon: Icons.grain_rounded,
          iconColor: Colors.amber,
          backgroundColor: Colors.amber,
          trend: '-2%',
          isTrendPositive: true,
        ),
        SummaryCard(
          label: 'Labour',
          value: '₹32,000',
          icon: Icons.groups_rounded,
          iconColor: AppColors.primary,
          backgroundColor: AppColors.primary,
          trend: '+5%',
          isTrendPositive: false,
        ),
      ],
    );
  }

  Widget _buildLabourSummary() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingMedium),
      child: Column(
        children: [
          _buildLabourRow('Total Workers', '45', 'workers'),
          const Divider(),
          _buildLabourRow('Total Hours', '1,240', 'hours'),
          const Divider(),
          _buildLabourRow('Average Daily Cost', '₹1,280', 'per day'),
        ],
      ),
    );
  }

  Widget _buildLabourRow(String label, String value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.marginSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTypography.labelMedium),
              Text(unit, style: AppTypography.bodySmall),
            ],
          ),
          Text(value, style: AppTypography.titleLarge),
        ],
      ),
    );
  }

  Widget _buildMaterialsTable() {
    final materials = [
      {'name': 'Steel Rods', 'quantity': '2.5 Ton', 'cost': '₹22,500'},
      {'name': 'Cement Bags', 'quantity': '150 Bags', 'cost': '₹18,500'},
      {'name': 'Sand', 'quantity': '50 Cu.m', 'cost': '₹3,950'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.paddingMedium),
            decoration: BoxDecoration(
              color: AppColors.bgLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSpacing.radiusMedium),
                topRight: Radius.circular(AppSpacing.radiusMedium),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('Material', style: AppTypography.labelMedium),
                ),
                Expanded(
                  flex: 2,
                  child: Text('Quantity', style: AppTypography.labelMedium),
                ),
                Expanded(
                  flex: 1,
                  child: Text('Cost', style: AppTypography.labelMedium, textAlign: TextAlign.end),
                ),
              ],
            ),
          ),
          ...materials.asMap().entries.map(
            (entry) => _buildTableRow(
              entry.value['name'] ?? '',
              entry.value['quantity'] ?? '',
              entry.value['cost'] ?? '',
              isLast: entry.key == materials.length - 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(String name, String quantity, String cost, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingMedium),
      decoration: BoxDecoration(
        border: !isLast
            ? Border(
                bottom: BorderSide(
                  color: AppColors.bgLight,
                  width: 1,
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(name, style: AppTypography.bodyMedium),
          ),
          Expanded(
            flex: 2,
            child: Text(quantity, style: AppTypography.bodySmall),
          ),
          Expanded(
            flex: 1,
            child: Text(
              cost,
              style: AppTypography.titleMedium,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrandTotalCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Grand Total',
                style: AppTypography.titleMedium.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '₹77,250',
                style: AppTypography.displaySmall.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            ),
            child: Icon(
              Icons.assessment_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}
