import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/login_screen.dart';
import '../screens/member_login_screen.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSmallScreen;
  final VoidCallback? onMenuPressed;
  final String? title;

  const SharedAppBar({
    super.key,
    required this.isSmallScreen,
    this.onMenuPressed,
    this.title,
  });

  void _showLoginOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تسجيل الدخول'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('تسجيل الدخول كعضو'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MemberLoginScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('تسجيل الدخول كفريق إدارة'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
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
                  if (isSmallScreen)
                    IconButton(
                      icon: Icon(Icons.menu, color: AppTheme.primaryColor),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
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
              
              // Left side - Actions and Login button
              if (!isSmallScreen) ...[
                IconButton(
                  icon: const Icon(Icons.search, color: Color(0xFF1E1E1E)),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.mail_outline, color: Color(0xFF1E1E1E)),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: Color(0xFF1E1E1E)),
                  onPressed: () {},
                ),
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFFF0F0F0),
                  child: Icon(Icons.person_outline, color: Color(0xFF1E1E1E), size: 20),
                ),
                loginButton,
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
} 