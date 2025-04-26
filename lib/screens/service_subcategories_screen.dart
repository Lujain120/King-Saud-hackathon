import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_app_bar.dart';
import 'request_form_screen.dart';

class ServiceSubcategoriesScreen extends StatefulWidget {
  final String categoryName;
  final String subcategoryName;
  final IconData subcategoryIcon;

  const ServiceSubcategoriesScreen({
    super.key,
    required this.categoryName,
    required this.subcategoryName,
    required this.subcategoryIcon,
  });

  @override
  State<ServiceSubcategoriesScreen> createState() => _ServiceSubcategoriesScreenState();
}

class _ServiceSubcategoriesScreenState extends State<ServiceSubcategoriesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<String> getSubcategories() {
    switch (widget.subcategoryName) {
      case 'استشارية':
        return [
          'دراسة جدوى',
          'تخطيط استراتيجي',
          'تمويل و استثمار',
          'الحوكمة و الامتثال',
          'الهياكل التنظيمية',
          'خطط تسويقية',
          'تطوير الأفكار',
          'إدارة العمليات و سلاسة الإمداد',
        ];
      case 'دورات تدريبية':
        return [
          'إدارة الوقت',
          'مهارات التواصل',
          'مهارات التفاوض',
          'الإلقاء وتقديم العروض',
        ];
      case 'شهادات مهنية':
        return [
          'PMP مدير مشاريع محترف',
          'CIA شهادة المدقق الداخلي المعتمد',
          'CCMP محترف إدارة التغيير',
        ];
      case 'أبحاث':
        return [
          'علمية',
          'السوق',
        ];
      default:
        return [];
    }
  }

  Color getHeaderColor() {
    switch (widget.subcategoryName) {
      case 'استشارية':
      case 'شهادات مهنية':
        return AppTheme.primaryColor; // Purple
      case 'دورات تدريبية':
      case 'أبحاث':
        return AppTheme.secondaryColor; // Blue
      default:
        return AppTheme.primaryColor;
    }
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color(0xFF3A0A64),  // Dark purple
              const Color(0xFF5F218E),  // Primary purple
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppTheme.primaryColor,
                    AppTheme.secondaryColor.withOpacity(0.8),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.secondaryColor.withOpacity(0.5),
                          blurRadius: 12,
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.business,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'منصة الخدمات',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'المهنية',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildDrawerItem(context, 'الرئيسية', Icons.home),
            _buildDrawerItem(context, 'الخدمات', Icons.business_center),
            _buildDrawerItem(context, 'نبذة عنا', Icons.info),
            _buildDrawerItem(context, 'تواصل معنا', Icons.contact_support),
            const Divider(color: Colors.white24),
            _buildDrawerItem(context, 'تسجيل الدخول', Icons.login, onTap: () {
              Navigator.pop(context);
              _showLoginOptions(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap ?? () {
        Navigator.pop(context);
        if (title == 'الرئيسية') {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }

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
                Navigator.pushNamed(context, '/member-login');
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('تسجيل الدخول كفريق إدارة'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final services = getSubcategories();
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Builder(
            builder: (BuildContext context) => CustomAppBar(
              isSmallScreen: isSmallScreen,
              showLoginButton: true,
              onMenuPressed: isSmallScreen ? () {
                Scaffold.of(context).openDrawer();
              } : null,
            ),
          ),
        ),
        drawer: isSmallScreen ? _buildDrawer(context) : null,
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16.0 : 40.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subcategory header
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            getHeaderColor(),
                            getHeaderColor() == AppTheme.primaryColor 
                              ? AppTheme.secondaryColor 
                              : AppTheme.primaryColor,
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: getHeaderColor().withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              widget.subcategoryIcon,
                              size: 32,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'خدمات ${widget.subcategoryName}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'اختر الخدمة المناسبة لك',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Service list
                    Expanded(
                      child: ListView.builder(
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          return _buildServiceCard(
                            context,
                            services[index],
                            'وصف مختصر للخدمة وما تقدمه للعميل من قيمة مضافة',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, String description) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: getHeaderColor().withOpacity(0.1),
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RequestFormScreen(
                categoryName: widget.categoryName,
                subcategoryName: widget.subcategoryName,
                serviceName: title,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 