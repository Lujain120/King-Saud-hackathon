import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'service_category_screen.dart';
import 'login_screen.dart';
import 'member_login_screen.dart';

class ServiceCategory {
  final String title;
  final IconData icon;
  final bool isActive;
  final String comingSoonText;

  const ServiceCategory({
    required this.title,
    required this.icon,
    this.isActive = false,
    this.comingSoonText = 'قريباً',
  });
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {
  final categoriesKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  
  // Animation controller for dropdown
  late AnimationController _dropdownAnimationController;
  late Animation<double> _dropdownAnimation;
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    
    // Initialize animation controller for dropdown
    _dropdownAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    
    _dropdownAnimation = CurvedAnimation(
      parent: _dropdownAnimationController,
      curve: Curves.easeOutCubic,
    );
  }
  
  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _dropdownAnimationController.dispose();
    super.dispose();
  }
  
  void _scrollListener() {
    if (_scrollController.offset > 20 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 20 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  static const List<ServiceCategory> categories = [
    ServiceCategory(
      title: 'إدارية',
      icon: Icons.business_center,
      isActive: true,
    ),
    ServiceCategory(
      title: 'تقنية',
      icon: Icons.computer,
      isActive: false,
    ),
    ServiceCategory(
      title: 'هندسية',
      icon: Icons.architecture,
      isActive: false,
    ),
    ServiceCategory(
      title: 'قانونيه',
      icon: Icons.gavel,
      isActive: false,
    ),
    ServiceCategory(
      title: 'اجتماعيه',
      icon: Icons.brush,
      isActive: false,
    ),
    ServiceCategory(
      title: 'صحية',
      icon: Icons.health_and_safety,
      isActive: false,
    ),
  ];

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isSmallScreen) {
    final appBarHeight = 70.0;
    
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

    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: Container(
        height: appBarHeight + MediaQuery.of(context).padding.top,
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
                // Right side - Logo only
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSmallScreen)
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.menu, color: AppTheme.primaryColor),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),
                    Image.asset(
                      'assets/icons/IMG_7405.JPG',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                
                // Center - Navigation items with underline hover effect
                if (!isSmallScreen)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: navItems,
                    ),
                  ),
                
                // Left side - Login button (pill-shaped)
                if (!isSmallScreen) loginButton,
              ],
            ),
          ),
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
            onTap: () {},
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
                  // Animated underline with TweenAnimationBuilder for smoother animation
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

  void _showLoginOptions(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero);
    
    // Reset and start animation when showing dropdown
    _dropdownAnimationController.reset();
    _dropdownAnimationController.forward();
    
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
        _buildAnimatedMenuItem('member', Icons.person, 'تسجيل الدخول كعضو', 0),
        _buildAnimatedMenuItem('management', Icons.admin_panel_settings, 'تسجيل الدخول كفريق إدارة', 1),
      ],
    ).then((value) {
      if (value == 'member') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MemberLoginScreen()),
        );
      } else if (value == 'management') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }
  
  PopupMenuItem<String> _buildAnimatedMenuItem(String value, IconData icon, String text, int index) {
    // Delayed animation for staggered effect
    final delay = Duration(milliseconds: 50 * index);
    
    return PopupMenuItem<String>(
      value: value,
      child: AnimatedBuilder(
        animation: _dropdownAnimation,
        builder: (context, child) {
          // Apply a slight delay to each item for staggered effect
          final delayedAnimation = _dropdownAnimation.value > 0
              ? Curves.easeOutCubic.transform(
                  (_dropdownAnimation.value - (delay.inMilliseconds / 250)).clamp(0.0, 1.0))
              : 0.0;
          
          return Transform.translate(
            offset: Offset(20 * (1 - delayedAnimation), 0),
            child: Opacity(
              opacity: delayedAnimation,
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Icon(icon, color: AppTheme.primaryColor),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
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
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 800;
    final isMediumScreen = MediaQuery.of(context).size.width < 1200 && MediaQuery.of(context).size.width >= 800;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(context, isSmallScreen),
        drawer: isSmallScreen ? _buildDrawer(context) : null,
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Section with padding for fixed navbar
              Container(
                height: 500, // Taller hero section
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                  ),
                ),
                child: Stack(
                  children: [
                    // Add a subtle pattern overlay for visual interest
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.purple.withOpacity(0.1),
                              Colors.blue.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Dark overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                    // Content
                    SafeArea(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'منصة الخدمات المهنية',
                                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'اختر الخدمة التي تناسب احتياجاتك بسهولة وسرعة',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 40),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // Scroll to service categories
                                  Scrollable.ensureVisible(
                                    categoriesKey.currentContext!,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                icon: const Icon(Icons.arrow_downward),
                                label: const Text('استكشف الخدمات'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppTheme.primaryColor,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Redesigned Service Categories Section - Clean White-based Layout
              Container(
                key: categoriesKey,
                color: Colors.white,
                padding: const EdgeInsets.only(top: 80, bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section title with elegant styling
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader(context, 'فئات الخدمات'),
                          const SizedBox(height: 16),
                          Text(
                            'اختر من بين مجموعة واسعة من الخدمات المهنية لتلبية احتياجاتك',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 48),
                        ],
                      ),
                    ),
                    
                    // Clean, elegant category grid
                    _buildServiceCategoriesGrid(context, isSmallScreen, isMediumScreen),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 6,
          width: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.2,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'اختر من خدماتنا الرئيسية للاستكشاف',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCategoriesGrid(BuildContext context, bool isSmallScreen, bool isMediumScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16, right: 24),
          child: Text(
            "اختر نوع الخدمة التي تبحث عنها:",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isSmallScreen ? 2 : (isMediumScreen ? 3 : 4),
              childAspectRatio: 0.95,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return _buildMinimalCategoryTile(context, category);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMinimalCategoryTile(BuildContext context, ServiceCategory category) {
    final primaryColor = AppTheme.primaryColor; // #5F218E
    final secondaryColor = AppTheme.secondaryColor; // #2196F3
    
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;
        
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          cursor: category.isActive ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transform: isHovered && category.isActive
                ? Matrix4.translationValues(0, -4, 0)
                : Matrix4.translationValues(0, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: category.isActive ? 
                  (isHovered ? primaryColor.withOpacity(0.3) : Colors.grey.shade200) : 
                  Colors.grey.shade200,
                width: 1,
              ),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ] 
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      )
                    ],
            ),
            child: InkWell(
              onTap: category.isActive 
                  ? () => Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => ServiceCategoryScreen(
                          categoryName: category.title,
                        ),
                      )
                    )
                  : null,
              borderRadius: BorderRadius.circular(12),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Stack(
                children: [
                  // Accent Indicator at top
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: category.isActive ? primaryColor : Colors.grey.shade300,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12)
                        ),
                      ),
                    ),
                  ),
                  
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Icon
                        Icon(
                          category.icon,
                          size: 48,
                          color: category.isActive ? primaryColor : Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        
                        // Title
                        Text(
                          category.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const Spacer(),
                        
                        // Status indicator
                        if (!category.isActive)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.hourglass_empty,
                                  size: 12,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  category.comingSoonText,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: secondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.touch_app,
                                  size: 12,
                                  color: secondaryColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'استكشف',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  
                  // "Coming Soon" overlay badge for non-active categories
                  if (!category.isActive)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'قريباً',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 