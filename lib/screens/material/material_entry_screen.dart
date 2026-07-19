import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_spacing.dart';
import '../../widgets/inputs/premium_text_field.dart';
import '../../widgets/buttons/premium_button.dart';
import '../../widgets/headers/app_header.dart';

class MaterialEntryScreen extends StatefulWidget {
  const MaterialEntryScreen({Key? key}) : super(key: key);

  @override
  State<MaterialEntryScreen> createState() => _MaterialEntryScreenState();
}

class _MaterialEntryScreenState extends State<MaterialEntryScreen> {
  late TextEditingController _materialNameController;
  late TextEditingController _quantityController;
  late TextEditingController _unitPriceController;
  late TextEditingController _notesController;

  String _selectedCategory = 'Cement';
  String _selectedUnit = 'Bag';
  bool _isLoading = false;

  final List<String> categories = ['Cement', 'Steel', 'Sand', 'Bricks', 'Water'];
  final List<String> units = ['Bag', 'kg', 'Ton', 'Liter', 'Piece'];

  @override
  void initState() {
    super.initState();
    _materialNameController = TextEditingController();
    _quantityController = TextEditingController();
    _unitPriceController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _materialNameController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Material entry saved successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _clearForm();
    });
  }

  void _clearForm() {
    _materialNameController.clear();
    _quantityController.clear();
    _unitPriceController.clear();
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
              companyName: 'Material Entry',
              greeting: 'Add new material',
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Selection
                  Text(
                    'Category',
                    style: AppTypography.labelMedium,
                  ),
                  const SizedBox(height: AppSpacing.marginSmall),
                  _buildCategorySelector(),
                  const SizedBox(height: AppSpacing.marginLarge),

                  // Material Name
                  PremiumTextField(
                    label: 'Material Name',
                    hint: 'e.g., Cement Bag',
                    prefixIcon: Icons.category_rounded,
                    controller: _materialNameController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: AppSpacing.marginLarge),

                  // Quantity and Unit Row
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: PremiumTextField(
                          label: 'Quantity',
                          hint: '0',
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.marginMedium),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Unit',
                              style: AppTypography.labelMedium,
                            ),
                            const SizedBox(height: AppSpacing.marginSmall),
                            _buildUnitDropdown(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.marginLarge),

                  // Unit Price
                  PremiumTextField(
                    label: 'Unit Price (₹)',
                    hint: '0.00',
                    prefixIcon: Icons.currency_rupee_rounded,
                    controller: _unitPriceController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: AppSpacing.marginLarge),

                  // Total Price Display
                  _buildTotalPriceCard(),
                  const SizedBox(height: AppSpacing.marginLarge),

                  // Notes
                  PremiumTextField(
                    label: 'Notes (Optional)',
                    hint: 'Add any additional notes',
                    prefixIcon: Icons.note_outlined,
                    controller: _notesController,
                    maxLines: 3,
                    minLines: 3,
                  ),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: PremiumButton(
                      text: 'Save Material Entry',
                      onPressed: _handleSubmit,
                      isLoading: _isLoading,
                      icon: Icons.check_rounded,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.marginLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.marginSmall),
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedCategory = category);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMedium,
                  vertical: AppSpacing.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textLight,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Text(
                  category,
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

  Widget _buildUnitDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(
          color: Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: DropdownButton<String>(
        value: _selectedUnit,
        isExpanded: true,
        underline: SizedBox(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingSmall,
          vertical: AppSpacing.paddingSmall,
        ),
        items: units.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() => _selectedUnit = newValue);
          }
        },
      ),
    );
  }

  Widget _buildTotalPriceCard() {
    final quantity = double.tryParse(_quantityController.text) ?? 0;
    final unitPrice = double.tryParse(_unitPriceController.text) ?? 0;
    final total = quantity * unitPrice;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Price',
            style: AppTypography.titleMedium,
          ),
          Text(
            '₹${total.toStringAsFixed(2)}',
            style: AppTypography.headlineSmall.copyWith(
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
