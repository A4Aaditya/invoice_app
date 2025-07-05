import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoice_app/riverpod/theme_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
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
            title: 'Account',
            subtitle: 'Manage your account',
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingTile(
            context,
            icon: Icons.notifications,
            iconColor: Colors.orange,
            bgColor: Colors.orange.shade100,
            title: 'Notifications',
            subtitle: 'Notification preferences',
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingTile(
            context,
            icon: Icons.lock,
            iconColor: Colors.green,
            bgColor: Colors.green.shade100,
            title: 'Privacy',
            subtitle: 'Privacy settings',
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
                title: 'Theme',
                subtitle: 'Light / Dark mode',
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

          _buildSettingTile(
            context,
            icon: Icons.info,
            iconColor: Colors.teal,
            bgColor: Colors.teal.shade100,
            title: 'About',
            subtitle: 'App information',
            onTap: () {},
          ),
          _buildDivider(),
          _buildSettingTile(
            context,
            icon: Icons.logout,
            iconColor: Colors.red,
            bgColor: Colors.red.shade100,
            title: 'Logout',
            subtitle: 'Sign out of your account',
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
      hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
    );
  }

  Widget _buildDivider() {
    return const Divider(indent: 72, endIndent: 16, thickness: 0.8, height: 0);
  }
}
