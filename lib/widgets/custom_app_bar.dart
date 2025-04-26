import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/login_screen.dart';
import '../screens/member_login_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSmallScreen;
  final VoidCallback? onMenuPressed;
  final bool showLoginButton;
  final String? title;

  const CustomAppBar({
    super.key,
    required this.isSmallScreen,
    this.onMenuPressed,
    this.showLoginButton = true,
    this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  void _showLoginOptions(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero);
    
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + button.size.height,
        offset.dx + button.size.width,
        offset.dy + button.size.height,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 8,
      color: Colors.white,
      items: [
        PopupMenuItem<String>(
          value: 'member',
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(Icons.person, color: AppTheme.primaryColor),
              const SizedBox(width: 12),
              Text(
                'تسجيل الدخول كعضو',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'management',
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(Icons.admin_panel_settings, color: AppTheme.primaryColor),
              const SizedBox(width: 12),
              Text(
                'تسجيل الدخول كفريق إدارة',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'member') {
        Navigator.pushNamed(context, '/member-login');
      } else if (value == 'management') {
        Navigator.pushNamed(context, '/login');
      }
    });
  }

  Widget _buildNavItem(BuildContext context, String title, IconData icon) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;
        
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: InkWell(
            onTap: () {
              if (title == 'الرئيسية') {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              }
            },
            hoverColor: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: isHovered ? 1 : 0),
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: 1.0 + (0.1 * value),
                            child: Icon(
                              icon,
                              size: 18,
                              color: isHovered ? AppTheme.primaryColor : Colors.black87,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          color: isHovered ? AppTheme.primaryColor : Colors.black87,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: isHovered ? 1 : 0),
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Container(
                        height: 2,
                        width: 24 * value,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final navItems = [
      _buildNavItem(context, 'الرئيسية', Icons.home),
      _buildNavItem(context, 'الخدمات', Icons.business_center),
      _buildNavItem(context, 'نبذة عنا', Icons.info),
      _buildNavItem(context, 'تواصل معنا', Icons.contact_support),
    ];

    final loginButton = Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElevatedButton.icon(
          onPressed: () => _showLoginOptions(context),
          icon: const Icon(Icons.login, size: 18),
          label: const Text(
            'تسجيل الدخول',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
        ),
      ),
    );

    return Container(
      height: preferredSize.height + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Right side - Logo and menu button
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSmallScreen && onMenuPressed != null)
                    IconButton(
                      icon: Icon(Icons.menu, color: AppTheme.primaryColor),
                      onPressed: onMenuPressed,
                    ),
                  Image.asset(
                    'assets/icons/IMG_7405.JPG',
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 12),
                  if (title != null)
                    Text(
                      title!,
                      style: const TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                ],
              ),
              
              // Center - Navigation items
              if (!isSmallScreen)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: navItems,
                  ),
                ),
              
              // Left side - Login button only
              if (!isSmallScreen && showLoginButton) loginButton,
            ],
          ),
        ),
      ),
    );
  }
} 