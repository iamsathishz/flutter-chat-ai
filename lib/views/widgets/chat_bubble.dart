import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:clipboard/clipboard.dart';
import '../../models/message.dart';

class ChatBubble extends StatefulWidget {
  final Message message;
  const ChatBubble({super.key, required this.message});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _opacityAnimation;

  bool get isUser => widget.message.isUser;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // 🌙 Bubble color logic
    final bgColor =
        isUser
            ? (isDark
                ? const Color(0xFF10A37F).withOpacity(0.15)
                : const Color(0xFF10A37F).withOpacity(0.08))
            : (isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.grey.shade100.withOpacity(0.95));

    final borderColor =
        isUser
            ? const Color(0xFF10A37F)
            : (isDark ? Colors.white10 : Colors.grey.withOpacity(0.3));

    final textColor =
        isUser
            ? (isDark ? Colors.white : Colors.black87)
            : (isDark ? Colors.white70 : Colors.black87);

    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Align(
          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: GestureDetector(
            onLongPress: () => _showMenu(context),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              padding: const EdgeInsets.all(16),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.82,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: borderColor.withOpacity(0.3)),
                color: bgColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                // borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                  child: MarkdownBody(
                    data: widget.message.text,
                    selectable: true,
                    styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                      p: TextStyle(fontSize: 15, height: 1.5, color: textColor),
                      codeblockDecoration: BoxDecoration(
                        color:
                            isDark
                                ? Colors.white10
                                : Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      code: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        color:
                            isDark
                                ? Colors.lightGreenAccent.shade100
                                : Colors.deepPurple,
                      ),
                      blockSpacing: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (_) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.copy,
                    iconColor: Colors.blue,
                    label: '📋 Copy',
                    onTap: () async {
                      await FlutterClipboard.copy(widget.message.text);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Copied')));
                    },
                  ),
                  const Divider(),
                  _buildMenuItem(
                    context,
                    icon: Icons.edit,
                    iconColor: Colors.amber,
                    label: '✏️ Edit (coming soon)',
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.thumb_up,
                    iconColor: Colors.green,
                    label: '👍 Like',
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.thumb_down,
                    iconColor: Colors.redAccent,
                    label: '👎 Dislike',
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}
