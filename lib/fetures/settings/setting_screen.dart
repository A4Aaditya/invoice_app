import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:invoice_app/core/params/no_params.dart';
import 'package:invoice_app/fetures/auth/login_screen.dart';
import 'package:invoice_app/fetures/auth/widget/setting_tile.dart';
import 'package:invoice_app/fetures/settings/riverpod/language_provider.dart';
import 'package:invoice_app/fetures/settings/riverpod/theme_provider.dart';
import 'package:invoice_app/fetures/auth/service/auth_service.dart';
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
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SettingTile(
            icon: Icons.person,
            iconColor: Colors.blue,
            bgColor: Colors.blue.shade100,
            title: context.i18n.settings,
            subtitle: context.i18n.settingAccountTileDescription,
            onTap: () {},
          ),
          const Divider(indent: 72, endIndent: 16, thickness: 0.8, height: 0),
          SettingTile(
            icon: Icons.notifications,
            iconColor: Colors.orange,
            bgColor: Colors.orange.shade100,
            title: context.i18n.notifications,
            subtitle: context.i18n.notificationPreferences,
            onTap: () {},
          ),
          const Divider(indent: 72, endIndent: 16, thickness: 0.8, height: 0),
          SettingTile(
            icon: Icons.lock,
            iconColor: Colors.green,
            bgColor: Colors.green.shade100,
            title: context.i18n.privacy,
            subtitle: context.i18n.privacySettings,
            onTap: () {},
          ),
          const Divider(indent: 72, endIndent: 16, thickness: 0.8, height: 0),
          Consumer(
            builder: (context, ref, child) {
              return SettingTile(
                icon: Icons.palette,
                iconColor: Colors.purple,
                bgColor: Colors.purple.shade100,
                title: context.i18n.theme,
                subtitle: context.i18n.lightAndDarkMode,
                onTap: () {
                  ref.read(themeProvider.notifier).changeTheme();
                },
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
          const Divider(indent: 72, endIndent: 16, thickness: 0.8, height: 0),
          Consumer(
            builder: (context, ref, child) {
              return SettingTile(
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
          const Divider(indent: 72, endIndent: 16, thickness: 0.8, height: 0),
          SettingTile(
            icon: Icons.info,
            iconColor: Colors.teal,
            bgColor: Colors.teal.shade100,
            title: context.i18n.about,
            subtitle: context.i18n.settingAboutTileDescription,
            onTap: () {},
          ),
          const Divider(indent: 72, endIndent: 16, thickness: 0.8, height: 0),
          SettingTile(
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
}
