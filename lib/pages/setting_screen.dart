import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_app/riverpod/language_provider.dart';
import 'package:invoice_app/riverpod/theme_provider.dart';
import 'package:invoice_app/utils/extensions.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.i18n.settingPageName),
        centerTitle: true,
        elevation: 2,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _buildSettingTile(
            context,
            icon: Icons.person,
            iconColor: Colors.blue,
            bgColor: Colors.blue.shade100,
            title: context.i18n.settingAccountTile,
            subtitle: context.i18n.settingAccountTileDescription,
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingTile(
            context,
            icon: Icons.notifications,
            iconColor: Colors.orange,
            bgColor: Colors.orange.shade100,
            title: context.i18n.settingNotificationTile,
            subtitle: context.i18n.settingNotificationTileDescription,
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingTile(
            context,
            icon: Icons.lock,
            iconColor: Colors.green,
            bgColor: Colors.green.shade100,
            title: context.i18n.settingPrivacyTile,
            subtitle: context.i18n.settingPrivacyTileDescription,
            onTap: () {},
          ),
          _buildDivider(),
          Consumer(
            builder: (context, ref, child) {
              return _buildSettingTile(
                context,
                icon: Icons.palette,
                iconColor: Colors.purple,
                bgColor: Colors.purple.shade100,
                title: context.i18n.settingThemeTile,
                subtitle: context.i18n.settingThemeTileDescription,
                onTap: () {},
                trailing: Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (bool value) {
                    ref.read(themeProvider.notifier).changeTheme();
                  },
                  activeColor: Colors.purple,
                ),
              );
            },
          ),
          _buildDivider(),
          Consumer(
            builder: (context, ref, child) {
              return _buildSettingTile(
                context,
                icon: Icons.language,
                iconColor: Colors.indigo,
                bgColor: Colors.indigo.shade100,
                title: context.i18n.settingLanguageTile,
                subtitle: context.i18n.settingLanguageTileDescription,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.i18n.settingLanguageTileChooseLanguage,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ListTile(
                              leading: const Icon(Icons.language),
                              title: Text(
                                context.i18n.settingLanguageTileChooseEnglish,
                              ),
                              onTap: () {
                                ref
                                    .read(languageProvider.notifier)
                                    .setLanguage("en");
                                // Add logic to change language to English
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.language),
                              title: Text(
                                context.i18n.settingLanguageTileChooseHindi,
                              ),
                              onTap: () {
                                ref
                                    .read(languageProvider.notifier)
                                    .setLanguage("hi");
                                // Add logic to change language to Hindi
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          _buildDivider(),

          _buildSettingTile(
            context,
            icon: Icons.info,
            iconColor: Colors.teal,
            bgColor: Colors.teal.shade100,
            title: context.i18n.settingAboutTile,
            subtitle: context.i18n.settingAboutTileDescription,
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingTile(
            context,
            icon: Icons.logout,
            iconColor: Colors.red,
            bgColor: Colors.red.shade100,
            title: context.i18n.settingLogoutTile,
            subtitle: context.i18n.settingLogoutTileDescription,
            onTap: () {
              // Add your logout logic here
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Logged out')));
            },
            trailing: const Icon(Icons.exit_to_app, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: bgColor,
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Theme.of(context).hintColor),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: Theme.of(context).colorScheme.primary.withValues(),
    );
  }

  Widget _buildDivider() {
    return const Divider(indent: 72, endIndent: 16, thickness: 0.8, height: 0);
  }
}
