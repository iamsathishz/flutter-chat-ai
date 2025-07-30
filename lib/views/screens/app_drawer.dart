import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/theme_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final chatController = context.read<ChatController>();
    final themeController = context.read<ThemeController>();

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),
          ListTile(
            leading: Icon(
              Icons.chat_bubble_outline,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            title: Text(
              'New Chat',
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            onTap: () {
              chatController.clearChat();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.delete_outline,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            title: Text(
              'Clear History',
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            onTap: () async {
              await chatController.clearChat();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('History cleared')));
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: isDark ? Colors.yellow[600] : Colors.black87,
            ),
            title: Text(
              isDark ? 'Light Mode' : 'Dark Mode',
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            onTap: () {
              themeController.toggleTheme();
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            title: Text(
              'About',
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Flutter ChatGPT Clone',
                applicationVersion: '1.0.0',
                applicationLegalese:
                    'Open-source demo using OpenRouter & Flutter.',
              );
            },
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Made with ❤️ in Flutter',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDark ? Colors.white54 : Colors.black54,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DrawerHeader(
      decoration: BoxDecoration(
        gradient:
            isDark
                ? const LinearGradient(
                  colors: [
                    Color(0xFF0E1630),
                    Color(0xFF1A243A),
                    Color(0xFF13293D),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                : const LinearGradient(
                  colors: [
                    Color(0xFFE0F7FA),
                    Color(0xFFB2EBF2),
                    Color(0xFF80DEEA),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          '🤖 AI Chat',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
