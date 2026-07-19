import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../../constants/app_spacing.dart';
import '../../widgets/headers/app_header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricEnabled = true;
  bool _autoSyncEnabled = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppHeader(
              companyName: 'Settings',
              greeting: 'Manage your preferences',
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account Section
                  _buildSectionTitle('Account'),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildAccountSection(),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // Display Section
                  _buildSectionTitle('Display'),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildDisplaySection(),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // Notifications Section
                  _buildSectionTitle('Notifications'),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildNotificationsSection(),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // Security Section
                  _buildSectionTitle('Security'),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildSecuritySection(),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // Data Section
                  _buildSectionTitle('Data'),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildDataSection(),
                  const SizedBox(height: AppSpacing.marginXLarge),

                  // About Section
                  _buildSectionTitle('About'),
                  const SizedBox(height: AppSpacing.marginMedium),
                  _buildAboutSection(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTypography.headlineSmall,
    );
  }

  Widget _buildAccountSection() {
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
          _buildSettingsItem(
            icon: Icons.person_outline_rounded,
            title: 'Profile',
            subtitle: 'Edit your profile information',
            onTap: () => _showSnackBar('Profile settings'),
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.business_outlined,
            title: 'Company Details',
            subtitle: 'Update company information',
            onTap: () => _showSnackBar('Company settings'),
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.email_outlined,
            title: 'Email Address',
            subtitle: 'bhaiajmal502@gmail.com',
            onTap: () => _showSnackBar('Email settings'),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplaySection() {
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
          _buildSettingsItem(
            icon: Icons.brightness_4_outlined,
            title: 'Dark Mode',
            subtitle: 'Enable dark theme',
            isToggle: true,
            toggleValue: _darkModeEnabled,
            onToggle: (value) {
              setState(() => _darkModeEnabled = value);
              _showSnackBar('Dark mode ${value ? 'enabled' : 'disabled'}');
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: _selectedLanguage,
            onTap: () => _showLanguageDialog(),
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.text_fields_outlined,
            title: 'Font Size',
            subtitle: 'Medium',
            onTap: () => _showSnackBar('Font size settings'),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsSection() {
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
          _buildSettingsItem(
            icon: Icons.notifications_outlined,
            title: 'Push Notifications',
            subtitle: 'Receive app notifications',
            isToggle: true,
            toggleValue: _notificationsEnabled,
            onToggle: (value) {
              setState(() => _notificationsEnabled = value);
              _showSnackBar('Notifications ${value ? 'enabled' : 'disabled'}');
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.email_outlined,
            title: 'Email Alerts',
            subtitle: 'Get email notifications',
            isToggle: true,
            toggleValue: true,
            onToggle: (value) => _showSnackBar('Email alerts ${value ? 'enabled' : 'disabled'}'),
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.schedule_outlined,
            title: 'Daily Summary',
            subtitle: 'Receive daily work summary',
            isToggle: true,
            toggleValue: true,
            onToggle: (value) => _showSnackBar('Daily summary ${value ? 'enabled' : 'disabled'}'),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection() {
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
          _buildSettingsItem(
            icon: Icons.lock_outline_rounded,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () => _showSnackBar('Change password'),
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.fingerprint_outlined,
            title: 'Biometric Login',
            subtitle: 'Enable fingerprint authentication',
            isToggle: true,
            toggleValue: _biometricEnabled,
            onToggle: (value) {
              setState(() => _biometricEnabled = value);
              _showSnackBar('Biometric ${value ? 'enabled' : 'disabled'}');
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.security_outlined,
            title: 'Two-Factor Auth',
            subtitle: 'Add extra security layer',
            isToggle: true,
            toggleValue: false,
            onToggle: (value) => _showSnackBar('2FA ${value ? 'enabled' : 'disabled'}'),
          ),
        ],
      ),
    );
  }

  Widget _buildDataSection() {
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
          _buildSettingsItem(
            icon: Icons.sync_outlined,
            title: 'Auto Sync',
            subtitle: 'Automatically sync data',
            isToggle: true,
            toggleValue: _autoSyncEnabled,
            onToggle: (value) {
              setState(() => _autoSyncEnabled = value);
              _showSnackBar('Auto sync ${value ? 'enabled' : 'disabled'}');
            },
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.backup_outlined,
            title: 'Backup Data',
            subtitle: 'Backup your project data',
            onTap: () => _showSnackBar('Creating backup...'),
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.download_outlined,
            title: 'Export Reports',
            subtitle: 'Export data as PDF/Excel',
            onTap: () => _showSnackBar('Export options'),
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.delete_outline_rounded,
            title: 'Clear Cache',
            subtitle: '45 MB',
            onTap: () => _showSnackBar('Cache cleared'),
            iconColor: AppColors.warning,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
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
          _buildSettingsItem(
            icon: Icons.info_outline_rounded,
            title: 'App Version',
            subtitle: 'v1.0.0',
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.help_outline_rounded,
            title: 'Help & Support',
            subtitle: 'Get help and report issues',
            onTap: () => _showSnackBar('Opening help center'),
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.description_outlined,
            title: 'Terms & Conditions',
            subtitle: 'Read our terms',
            onTap: () => _showSnackBar('Opening terms'),
          ),
          const Divider(height: 1),
          _buildSettingsItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            onTap: () => _showSnackBar('Opening privacy policy'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    bool isToggle = false,
    bool toggleValue = false,
    ValueChanged<bool>? onToggle,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: isToggle ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingMedium,
          vertical: AppSpacing.paddingMedium,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.primary).withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
              ),
              child: Icon(
                icon,
                color: iconColor ?? AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.marginMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleMedium,
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
            ),
            if (isToggle)
              Switch(
                value: toggleValue,
                onChanged: onToggle,
                activeColor: AppColors.primary,
              )
            else
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
              ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Select Language',
          style: AppTypography.headlineSmall,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['English', 'Hindi', 'Marathi', 'Gujarati'].map(
            (language) => RadioListTile(
              title: Text(language),
              value: language,
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() => _selectedLanguage = value as String);
                Navigator.pop(context);
                _showSnackBar('Language changed to $language');
              },
            ),
          ).toList(),
        ),
      ),
    );
  }
}
