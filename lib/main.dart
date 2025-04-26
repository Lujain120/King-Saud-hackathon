import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/landing_page.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/member_login_screen.dart';
import 'screens/admin_dashboard_screen.dart';
import 'screens/member_dashboard_screen.dart';
import 'screens/managing_team_dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'منصة الخدمات المهنية',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primaryColor),
        useMaterial3: true,
        fontFamily: 'Cairo',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => const LoginScreen(),
        '/member-login': (context) => const MemberLoginScreen(),
        '/admin-dashboard': (context) => const AdminDashboardScreen(),
        '/member-dashboard': (context) => const MemberDashboardScreen(),
        '/managing-team-dashboard': (context) => const ManagingTeamDashboardScreen(),
      },
      locale: const Locale('ar', 'SA'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SA'),
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}
