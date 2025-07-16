import 'package:flutter/material.dart';
import 'package:flutter_chat_ai/controllers/chat_controller.dart';
import 'package:flutter_chat_ai/controllers/theme_controller.dart';
import 'package:flutter_chat_ai/locator.dart';
import 'package:flutter_chat_ai/views/screens/app_drawer.dart';
import 'package:flutter_chat_ai/views/widgets/quick_quize.dart';
import 'package:flutter_chat_ai/views/widgets/chat_bubble.dart';
import 'package:flutter_chat_ai/views/widgets/typing_indicator.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final darkGradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF0E1630), Color(0xFF1A243A), Color(0xFF13293D)],
    );
    final lightGradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2), Color(0xFF80DEEA)],
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const AppDrawer(),
        backgroundColor: Colors.transparent,

        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: isDark ? darkGradient : lightGradient,
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            onPressed:
                                () => _scaffoldKey.currentState?.openDrawer(),
                          ),
                          const Icon(
                            Icons.bubble_chart,
                            color: Color(0xFF19C37D),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'AI Chat',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Tooltip(
                        message:
                            isDark
                                ? 'Switch to Light Mode'
                                : 'Switch to Dark Mode',
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () => locator<ThemeController>().toggleTheme(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:
                                  isDark
                                      ? Colors.white.withOpacity(0.1)
                                      : Colors.black.withOpacity(0.05),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isDark ? Icons.light_mode : Icons.dark_mode,
                              color:
                                  isDark
                                      ? Colors.yellow[600]
                                      : Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Flexible(
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    itemCount: chat.messages.length,
                    itemBuilder: (_, i) {
                      final m = chat.messages[chat.messages.length - 1 - i];
                      if (m.text == '...') return const TypingIndicator();
                      return ChatBubble(message: m);
                    },
                  ),
                ),

                if (chat.messages.isEmpty) ...[
                  const SizedBox(height: 12),
                  QuickQuiz(
                    prompts: const [
                      "🤔 What is Flutter?",
                      "🎯 Productivity tip",
                      "😂 Tell me a joke",
                      "🤖 Explain AI",
                    ],
                    onSelected:
                        (prompt) =>
                            context.read<ChatController>().sendMessage(prompt),
                  ),
                ],

                // Input bar
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Ask me anything...',
                            hintStyle: TextStyle(
                              color: isDark ? Colors.white54 : Colors.black,
                            ),
                          ),
                          onSubmitted: (_) => _send(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _send,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF19C37D),
                          ),
                          child: const Icon(Icons.send, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _send() {
    final txt = _controller.text.trim();
    if (txt.isEmpty) return;
    context.read<ChatController>().sendMessage(txt);
    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
