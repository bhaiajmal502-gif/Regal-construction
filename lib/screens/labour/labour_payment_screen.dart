import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_spacing.dart';
import '../../widgets/cards/summary_card.dart';
import '../../widgets/inputs/premium_text_field.dart';
import '../../widgets/buttons/premium_button.dart';
import '../../widgets/headers/app_header.dart';

class LabourPaymentScreen extends StatefulWidget {
  const LabourPaymentScreen({Key? key}) : super(key: key);

  @override
  State<LabourPaymentScreen> createState() => _LabourPaymentScreenState();
}

class _LabourPaymentScreenState extends State<LabourPaymentScreen> {
  late TextEditingController _workerNameController;
  late TextEditingController _hoursWorkedController;
  late TextEditingController _ratePerHourController;
  late TextEditingController _advanceController;
  late TextEditingController _notesController;

  String _selectedPaymentMethod = 'Cash';
  bool _isLoading = false;

  final List<String> paymentMethods = ['Cash', 'Bank Transfer', 'Cheque', 'Online'];

  final List<Map<String, dynamic>> recentPayments = [
    {
      'name': 'Rajesh Kumar',
      'amount': '₹3,200',
      'date': '19 Jul 2026',
      'status': 'Completed',
      'icon': Icons.check_circle_rounded,
      'statusColor': AppColors.success,
    },
    {
      'name': 'Amit Singh',
      'amount': '₹2,800',
      'date': '18 Jul 2026',
      'status': 'Completed',
      'icon': Icons.check_circle_rounded,
      'statusColor': AppColors.success,
    },
    {
      'name': 'Priya Sharma',
      'amount': '₹2,500',
      'date': '17 Jul 2026',
      'status': 'Pending',
      'icon': Icons.schedule_rounded,
      'statusColor': AppColors.warning,
    },
  ];

  @override
  void initState() {
    super.initState();
    _workerNameController = TextEditingController();
    _hoursWorkedController = TextEditingController();
    _ratePerHourController = TextEditingController();
    _advanceController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _workerNameController.dispose();
    _hoursWorkedController.dispose();
    _ratePerHourController.dispose();
    _advanceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handlePayment() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment processed successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _clearForm();
    });
  }

  void _clearForm() {
    _workerNameController.clear();
    _hoursWorkedController.clear();
    _ratePerHourController.clear();
    _advanceController.clear();
    _notesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeader(
              companyName: 'Labour Payment',
              greeting: 'Manage worker payments',
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Payment Summary Cards
                  Text(
                    'Payment Summary',
                    style: AppTypography.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildPaymentSummary(),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // New Payment Section
                  Text(
                    'Record New Payment',
                    style: AppTypography.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildPaymentForm(),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // Recent Payments
                  Text(
                    'Recent Payments',
                    style: AppTypography.headlineSmall,
                  ),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildRecentPayments(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppSpacing.marginMedium,
      mainAxisSpacing: AppSpacing.marginMedium,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SummaryCard(
          label: 'Today\'s Payment',
          value: '₹12,500',
          icon: Icons.trending_up_rounded,
          iconColor: AppColors.success,
          backgroundColor: AppColors.success,
          trend: '+8%',
          isTrendPositive: false,
        ),
        SummaryCard(
          label: 'Month Total',
          value: '₹145,250',
          icon: Icons.calendar_month_rounded,
          iconColor: AppColors.primary,
          backgroundColor: AppColors.primary,
          trend: '+12%',
          isTrendPositive: false,
        ),
        SummaryCard(
          label: 'Active Workers',
          value: '45',
          icon: Icons.groups_rounded,
          iconColor: AppColors.info,
          backgroundColor: AppColors.info,
          trend: '+5',
          isTrendPositive: false,
        ),
        SummaryCard(
          label: 'Avg Daily Rate',
          value: '₹1,280',
          icon: Icons.rate_review_rounded,
          iconColor: AppColors.accent,
          backgroundColor: AppColors.accent,
          trend: 'No change',
          isTrendPositive: true,
        ),
      ],
    );
  }

  Widget _buildPaymentForm() {
    final hours = double.tryParse(_hoursWorkedController.text) ?? 0;
    final rate = double.tryParse(_ratePerHourController.text) ?? 0;
    final advance = double.tryParse(_advanceController.text) ?? 0;
    final totalPayment = (hours * rate) - advance;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Worker Name
          PremiumTextField(
            label: 'Worker Name',
            hint: 'e.g., Rajesh Kumar',
            prefixIcon: Icons.person_outline_rounded,
            controller: _workerNameController,
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Hours and Rate Row
          Row(
            children: [
              Expanded(
                flex: 1,
                child: PremiumTextField(
                  label: 'Hours Worked',
                  hint: '0',
                  controller: _hoursWorkedController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: AppSpacing.marginMedium),
              Expanded(
                flex: 1,
                child: PremiumTextField(
                  label: 'Rate/Hour (₹)',
                  hint: '0',
                  controller: _ratePerHourController,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Advance Amount
          PremiumTextField(
            label: 'Advance Given (₹)',
            hint: '0',
            prefixIcon: Icons.currency_rupee_rounded,
            controller: _advanceController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Net Payment Display
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(AppSpacing.paddingMedium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gross Amount',
                      style: AppTypography.bodySmall,
                    ),
                    Text(
                      '₹${(hours * rate).toStringAsFixed(2)}',
                      style: AppTypography.titleLarge,
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.primary,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Net Payment',
                      style: AppTypography.bodySmall,
                    ),
                    Text(
                      '₹${totalPayment.toStringAsFixed(2)}',
                      style: AppTypography.titleLarge.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Payment Method
          Text(
            'Payment Method',
            style: AppTypography.labelMedium,
          ),
          const SizedBox(height: AppSpacing.marginSmall),
          _buildPaymentMethodSelector(),
          const SizedBox(height: AppSpacing.marginLarge),

          // Notes
          PremiumTextField(
            label: 'Notes (Optional)',
            hint: 'Add remarks or reference number',
            prefixIcon: Icons.note_outlined,
            controller: _notesController,
            maxLines: 2,
            minLines: 2,
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Payment Button
          SizedBox(
            width: double.infinity,
            child: PremiumButton(
              text: 'Process Payment',
              onPressed: _handlePayment,
              isLoading: _isLoading,
              icon: Icons.payment_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: paymentMethods.map((method) {
          final isSelected = _selectedPaymentMethod == method;
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.marginSmall),
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedPaymentMethod = method);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMedium,
                  vertical: AppSpacing.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.textLight,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Text(
                  method,
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

  Widget _buildRecentPayments() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recentPayments.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final payment = recentPayments[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(AppSpacing.paddingMedium),
          margin: EdgeInsets.only(
            bottom: index == recentPayments.length - 1 ? 0 : AppSpacing.marginSmall,
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (payment['statusColor'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                ),
                child: Center(
                  child: Icon(
                    payment['icon'] as IconData,
                    color: payment['statusColor'] as Color,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.marginMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payment['name'] as String,
                      style: AppTypography.titleMedium,
                    ),
                    Text(
                      payment['date'] as String,
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    payment['amount'] as String,
                    style: AppTypography.titleMedium,
                  ),
                  Text(
                    payment['status'] as String,
                    style: AppTypography.labelSmall.copyWith(
                      color: payment['statusColor'] as Color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
