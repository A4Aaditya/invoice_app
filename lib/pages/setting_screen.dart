import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:invoice_app/entities/auth_params/no_params.dart';
import 'package:invoice_app/pages/auth/login_screen.dart';
import 'package:invoice_app/riverpod/language_provider.dart';
import 'package:invoice_app/riverpod/theme_provider.dart';
import 'package:invoice_app/service/auth_service.dart';
import 'package:invoice_app/utils/extensions.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.i18n.settings),
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
            title: context.i18n.settings,
            subtitle: context.i18n.settingAccountTileDescription,
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingTile(
            context,
            icon: Icons.notifications,
            iconColor: Colors.orange,
            bgColor: Colors.orange.shade100,
            title: context.i18n.notifications,
            subtitle: context.i18n.notificationPreferences,
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingTile(
            context,
            icon: Icons.lock,
            iconColor: Colors.green,
            bgColor: Colors.green.shade100,
            title: context.i18n.privacy,
            subtitle: context.i18n.privacySettings,
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
                title: context.i18n.theme,
                subtitle: context.i18n.lightAndDarkMode,
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
                title: context.i18n.language,
                subtitle: context.i18n.selectAppLanguage,
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
                              context.i18n.chooseLanguage,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ListTile(
                              leading: const Icon(Icons.language),
                              title: Text(context.i18n.english),
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
                              title: Text(context.i18n.hindi),
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
            title: context.i18n.about,
            subtitle: context.i18n.settingAboutTileDescription,
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingTile(
            context,
            icon: Icons.logout,
            iconColor: Colors.red,
            bgColor: Colors.red.shade100,
            title: context.i18n.logout,
            subtitle: context.i18n.settingLogoutTileDescription,
            onTap: () async {
              // Add your logout logic here
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          context.i18n.settingCofirmLogout, // "Logout"
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          context.i18n.settingConfirmText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  context.i18n.cancel,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Perform logout
                                  await GetIt.instance
                                      .get<AuthService>()
                                      .signOut(NoParams());
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Logged out')),
                                  );
                                  final route = MaterialPageRoute(
                                    builder: (context) {
                                      return const LoginScreen();
                                    },
                                  );
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    route,
                                    (route) => false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  context.i18n.logout,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
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
