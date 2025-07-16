// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../controllers/chat_controller.dart';
// import '../../controllers/theme_controller.dart';

// class AppDrawer extends StatelessWidget {
//   const AppDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;
//     final chatController = context.read<ChatController>();
//     final themeController = context.read<ThemeController>();

//     return Drawer(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           const _DrawerHeader(),
//           ListTile(
//             leading: const Icon(Icons.chat_bubble_outline),
//             title: const Text('New Chat'),
//             onTap: () {
//               chatController.clearChat();
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.delete_outline),
//             title: const Text('Clear History'),
//             onTap: () async {
//               await chatController.clearChat();
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(const SnackBar(content: Text('History cleared')));
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
//             title: Text(isDark ? 'Light Mode' : 'Dark Mode'),
//             onTap: () {
//               themeController.toggleTheme();
//               Navigator.pop(context);
//             },
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.info_outline),
//             title: const Text('About'),
//             onTap: () {
//               showAboutDialog(
//                 context: context,
//                 applicationName: 'Flutter ChatGPT Clone',
//                 applicationVersion: '1.0.0',
//                 applicationLegalese:
//                     'Open-source demo using OpenRouter & Flutter.',
//               );
//             },
//           ),
//           const SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Text(
//               'Made with ❤️ in Flutter',
//               textAlign: TextAlign.center,
//               style: theme.textTheme.bodySmall?.copyWith(
//                 color: theme.hintColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DrawerHeader extends StatelessWidget {
//   const _DrawerHeader();

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return DrawerHeader(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Color(0xFF10A37F), Color(0xFF0E8E6F)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Align(
//         alignment: Alignment.bottomLeft,
//         child: Text(
//           '🤖 Chat AI',
//           style: theme.textTheme.headlineSmall?.copyWith(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
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
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors:
      //         isDark
      //             ? [Color(0xFF0E1630), Color(0xFF13293D)]
      //             : [Color(0xFF10A37F), Color(0xFF0E8E6F)],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //   ),
      // ),
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
