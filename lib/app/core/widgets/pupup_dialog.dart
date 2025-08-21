import 'package:flutter/material.dart';

enum AppPopupType { success, error, warning, info }

class AppPopup {
  static Future<void> show(
    BuildContext context, {
    required AppPopupType type,
    required String title,
    required String message,
    String primaryText = 'OK',
    VoidCallback? onPrimary,
    String? secondaryText,
    VoidCallback? onSecondary,
    bool barrierDismissible = true,
  }) {
    return showGeneralDialog(
      context: context,
      barrierLabel: 'AppPopup',
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black.withOpacity(0.35),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, __, ___) {
        return const SizedBox.shrink(); // handled in transitionBuilder
      },
      transitionBuilder: (context, anim, _, __) {
        final curved =
            CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
        return Transform.scale(
          scale: Tween<double>(begin: .95, end: 1).animate(curved).value,
          child: Opacity(
            opacity: Tween<double>(begin: 0, end: 1).animate(curved).value,
            child: _PopupCard(
              type: type,
              title: title,
              message: message,
              primaryText: primaryText,
              onPrimary: onPrimary ?? () => Navigator.of(context).pop(),
              secondaryText: secondaryText,
              onSecondary: onSecondary,
            ),
          ),
        );
      },
    );
  }
}

class _PopupCard extends StatelessWidget {
  const _PopupCard({
    required this.type,
    required this.title,
    required this.message,
    required this.primaryText,
    required this.onPrimary,
    this.secondaryText,
    this.onSecondary,
  });

  final AppPopupType type;
  final String title;
  final String message;
  final String primaryText;
  final VoidCallback onPrimary;
  final String? secondaryText;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(type);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.86,
          constraints: const BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.08),
                  blurRadius: 24,
                  offset: const Offset(0, 10))
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with gradient + icon
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [style.headerStart, style.headerEnd],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: style.iconBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(style.icon, color: style.iconColor, size: 22),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Body
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Actions
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                child: Row(
                  children: [
                    if (secondaryText != null) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onSecondary,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(color: style.accent),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(
                            secondaryText!,
                            style: TextStyle(
                              color: style.accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onPrimary,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: style.accent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _PopupStyle _styleFor(AppPopupType t) {
    switch (t) {
      case AppPopupType.success:
        return _PopupStyle(
          icon: Icons.check_circle_rounded,
          iconColor: const Color(0xFF10B981),
          iconBg: const Color(0x3310B981),
          headerStart: const Color(0xFF22C55E),
          headerEnd: const Color(0xFF16A34A),
          accent: const Color(0xFF16A34A),
        );
      case AppPopupType.error:
        return _PopupStyle(
          icon: Icons.error_rounded,
          iconColor: const Color(0xFFEF4444),
          iconBg: const Color(0x33EF4444).withOpacity(.4),
          headerStart: const Color(0xFFEF4444).withOpacity(.2),
          headerEnd: const Color(0xFFDC2626).withOpacity(.8),
          accent: const Color(0xFFDC2626),
        );
      case AppPopupType.warning:
        return _PopupStyle(
          icon: Icons.warning_amber_rounded,
          iconColor: const Color(0xFFF59E0B),
          iconBg: const Color(0x33F59E0B),
          headerStart: const Color(0xFFF59E0B),
          headerEnd: const Color(0xFFD97706),
          accent: const Color(0xFFD97706),
        );
      case AppPopupType.info:
      return _PopupStyle(
          icon: Icons.info_rounded,
          iconColor: const Color(0xFF3B82F6),
          iconBg: const Color(0x333B82F6),
          headerStart: const Color(0xFF3B82F6),
          headerEnd: const Color(0xFF2563EB),
          accent: const Color(0xFF2563EB),
        );
    }
  }
}

class _PopupStyle {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final Color headerStart;
  final Color headerEnd;
  final Color accent;

  _PopupStyle({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.headerStart,
    required this.headerEnd,
    required this.accent,
  });
}
