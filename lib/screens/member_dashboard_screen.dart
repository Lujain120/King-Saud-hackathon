import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/request_card_grid.dart';
import '../widgets/shared_app_bar.dart';

class MemberDashboardScreen extends StatefulWidget {
  const MemberDashboardScreen({super.key});

  @override
  State<MemberDashboardScreen> createState() => _MemberDashboardScreenState();
}

class _MemberDashboardScreenState extends State<MemberDashboardScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final _rejectionController = TextEditingController();
  Map<String, dynamic>? _requestToReject;
  late TabController _tabController;
  bool _isDrawerOpen = false;
  String _selectedFilter = 'الكل';
  
  // Animation controllers for hover effects
  final Map<int, AnimationController> _hoverControllers = {};
  final Map<int, bool> _isHovering = {};

  // Assigned requests from management
  final List<Map<String, dynamic>> _assignedRequests = [
    {
      "id": "ASG-001",
      "clientName": "سارة الحامد",
      "requestedService": "تطوير استراتيجية مبيعات",
      "notes": "تطوير استراتيجية مبيعات للشركة وتدريب فريق المبيعات",
      "email": "sarah@example.com",
      "phone": "0501234555",
      "date": "2025-06-01",
      "assignedBy": "مدير القسم",
      "priority": "عالية",
      "deadline": "2025-06-15"
    },
    {
      "id": "ASG-002",
      "clientName": "محمد عبدالله",
      "requestedService": "استشارة قانونية",
      "notes": "استشارة قانونية حول عقود الموظفين",
      "email": "mohamed@example.com",
      "phone": "0509876123",
      "date": "2025-06-03",
      "assignedBy": "مدير القسم",
      "priority": "متوسطة",
      "deadline": "2025-06-10"
    },
    {
      "id": "ASG-003",
      "clientName": "فهد السالم",
      "requestedService": "دراسة جدوى",
      "notes": "دراسة جدوى لمشروع تجاري جديد",
      "email": "fahad@example.com",
      "phone": "0504567890",
      "date": "2025-06-05",
      "assignedBy": "مدير القسم",
      "priority": "عالية",
      "deadline": "2025-06-25"
    },
    {
      "id": "ASG-004",
      "clientName": "نورة القحطاني",
      "requestedService": "تحليل مالي",
      "notes": "تحليل مالي للربع الأخير من السنة",
      "email": "noura@example.com",
      "phone": "0507891234",
      "date": "2025-06-07",
      "assignedBy": "مدير القسم",
      "priority": "منخفضة",
      "deadline": "2025-06-30"
    }
  ];

  final List<Map<String, dynamic>> _newRequests = [
    {
      "clientName": "أحمد الجهني",
      "requestedService": "دراسة جدوى",
      "notes": "أحتاج دراسة جدوى لمشروع تطبيق تقني",
      "email": "ahmad.juhani@email.com",
      "phone": "0501234567",
      "date": "2025-05-15",
      "id": "REQ-001",
      "status": "جديد"
    },
    {
      "clientName": "ريم الحربي",
      "requestedService": "تخطيط",
      "notes": "أحتاج مساعدة في تخطيط مشروع تجاري",
      "email": "reem.alharbi@email.com",
      "phone": "0509876543",
      "date": "2025-05-18",
      "id": "REQ-002",
      "status": "قيد التنفيذ"
    },
    {
      "clientName": "فهد القحطاني",
      "requestedService": "استشارة مالية",
      "notes": "استشارة حول تمويل مشروع ناشئ",
      "email": "fahad.q@email.com",
      "phone": "0507654321",
      "date": "2025-05-20",
      "id": "REQ-003",
      "status": "جاهز للتنفيذ"
    }
  ];

  final List<Map<String, dynamic>> _acceptedRequests = [];

  final List<Map<String, dynamic>> _rejectedRequests = [];

  final Map<String, dynamic> _profile = {
    "name": "د. محمد الغامدي",
    "specialization": "متخصص في الدراسات الاقتصادية",
    "bio": "خبير استشاري في مجال إدارة المشاريع والتخطيط الاستراتيجي مع خبرة تزيد عن 10 سنوات في العمل مع شركات محلية ودولية",
    "email": "member@example.com",
    "phone": "+966 50 123 4567",
    "experience": "10 سنوات",
    "rating": "4.8",
    "completedRequests": "45",
    "image": "https://randomuser.me/api/portraits/men/32.jpg"
  };
  
  // Tab definitions
  final List<String> _tabs = ['المهام المسندة', 'الطلبات الجديدة', 'المقبولة', 'المرفوضة'];
  final List<String> _filters = ['الكل', 'استشارية', 'دورات تدريبية', 'شهادات مهنية', 'أبحاث'];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    
    // Initialize hover controllers for each request
    _initializeHoverControllers();
  }
  
  void _initializeHoverControllers() {
    // Clear existing controllers
    for (final controller in _hoverControllers.values) {
      controller.dispose();
    }
    _hoverControllers.clear();
    _isHovering.clear();
    
    // Add controllers for all request types
    List<Map<String, dynamic>> allRequests = [
      ..._assignedRequests,
      ..._newRequests,
      ..._acceptedRequests,
      ..._rejectedRequests
    ];
    
    for (int i = 0; i < allRequests.length; i++) {
      _hoverControllers[i] = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        value: 0,
      );
      _isHovering[i] = false;
    }
  }

  @override
  void dispose() {
    _rejectionController.dispose();
    _tabController.dispose();
    
    // Dispose all animation controllers
    for (final controller in _hoverControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleAcceptRequest(Map<String, dynamic> request) {
    setState(() {
      _newRequests.remove(request);
      _acceptedRequests.add(request);
      _initializeHoverControllers();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'تم قبول الطلب، سيتم التواصل معك من خلال فريق الإدارة.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );

    // Switch to accepted requests tab
    setState(() {
      _selectedIndex = 2;
      _tabController.animateTo(2);
    });
  }

  void _handleRejectRequest(Map<String, dynamic> request) {
    setState(() {
      _requestToReject = request;
    });
  }

  void _confirmRejection() {
    if (_requestToReject != null) {
      setState(() {
        _newRequests.remove(_requestToReject);
        
        // Add rejection reason if provided
        if (_rejectionController.text.isNotEmpty) {
          _requestToReject!["rejectionReason"] = _rejectionController.text;
        }
        
        _rejectedRequests.add(_requestToReject!);
        _requestToReject = null;
        _rejectionController.clear();
        _initializeHoverControllers();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'تم رفض الطلب.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );

      // Switch to rejected requests tab
      setState(() {
        _selectedIndex = 3;
        _tabController.animateTo(3);
      });
    }
  }

  void _cancelRejection() {
    setState(() {
      _requestToReject = null;
      _rejectionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final isMediumScreen = MediaQuery.of(context).size.width < 900 && MediaQuery.of(context).size.width >= 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
        appBar: _buildAppBar(context, isSmallScreen),
        drawer: isSmallScreen ? _buildDrawer(context) : null,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (isSmallScreen) {
                      // Single column layout for small screens
                      return Column(
                        children: [
                          _buildResponsiveStatCard(
                            'طلبات جديدة',
                            '18',
                            Icons.assignment_outlined,
                            const Color(0xFF5F218E),
                            constraints.maxWidth,
                          ),
                          const SizedBox(height: 16),
                          _buildResponsiveStatCard(
                            'قيد التنفيذ',
                            '2',
                            Icons.pending_actions,
                            const Color(0xFFFFA000),
                            constraints.maxWidth,
                          ),
                          const SizedBox(height: 16),
                          _buildResponsiveStatCard(
                            'جاهز للتنفيذ',
                            '7',
                            Icons.check_circle_outline,
                            const Color(0xFF4CAF50),
                            constraints.maxWidth,
                          ),
                          const SizedBox(height: 16),
                          _buildResponsiveStatCard(
                            'ملغي',
                            '3',
                            Icons.cancel_outlined,
                            const Color(0xFFE53935),
                            constraints.maxWidth,
                          ),
                        ],
                      );
                    } else if (isMediumScreen) {
                      // Two columns layout for medium screens
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          SizedBox(
                            width: (constraints.maxWidth - 16) / 2,
                            child: _buildResponsiveStatCard(
                              'طلبات جديدة',
                              '18',
                              Icons.assignment_outlined,
                              const Color(0xFF5F218E),
                              (constraints.maxWidth - 16) / 2,
                            ),
                          ),
                          SizedBox(
                            width: (constraints.maxWidth - 16) / 2,
                            child: _buildResponsiveStatCard(
                              'قيد التنفيذ',
                              '2',
                              Icons.pending_actions,
                              const Color(0xFFFFA000),
                              (constraints.maxWidth - 16) / 2,
                            ),
                          ),
                          SizedBox(
                            width: (constraints.maxWidth - 16) / 2,
                            child: _buildResponsiveStatCard(
                              'جاهز للتنفيذ',
                              '7',
                              Icons.check_circle_outline,
                              const Color(0xFF4CAF50),
                              (constraints.maxWidth - 16) / 2,
                            ),
                          ),
                          SizedBox(
                            width: (constraints.maxWidth - 16) / 2,
                            child: _buildResponsiveStatCard(
                              'ملغي',
                              '3',
                              Icons.cancel_outlined,
                              const Color(0xFFE53935),
                              (constraints.maxWidth - 16) / 2,
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Four columns layout for large screens
                      return Row(
                        children: [
                          Expanded(
                            child: _buildResponsiveStatCard(
                              'طلبات جديدة',
                              '18',
                              Icons.assignment_outlined,
                              const Color(0xFF5F218E),
                              constraints.maxWidth / 4 - 16,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildResponsiveStatCard(
                              'قيد التنفيذ',
                              '2',
                              Icons.pending_actions,
                              const Color(0xFFFFA000),
                              constraints.maxWidth / 4 - 16,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildResponsiveStatCard(
                              'جاهز للتنفيذ',
                              '7',
                              Icons.check_circle_outline,
                              const Color(0xFF4CAF50),
                              constraints.maxWidth / 4 - 16,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildResponsiveStatCard(
                              'ملغي',
                              '3',
                              Icons.cancel_outlined,
                              const Color(0xFFE53935),
                              constraints.maxWidth / 4 - 16,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _newRequests.length,
                  itemBuilder: (context, index) {
                    final request = _newRequests[index];
                    return _buildRequestCard(request);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isSmallScreen) {
    final appBarHeight = 70.0;
    
    final logoutButton = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushReplacementNamed(context, '/'),
        icon: const Icon(Icons.logout, size: 18),
        label: const Text(
          'تسجيل الخروج',
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
                // Right side - Logo and menu button
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
                
                // Center - Navigation items
                if (!isSmallScreen)
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildNavItem(context, 'الرئيسية', Icons.home, () {
                                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                                }),
                                const SizedBox(width: 8),
                                _buildNavItem(context, 'طلباتي', Icons.assignment, () {}),
                                const SizedBox(width: 8),
                                _buildNavItem(context, 'الملف الشخصي', Icons.person, () {}),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                
                // Left side - Logout button
                if (!isSmallScreen) logoutButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveStatCard(String title, String count, IconData icon, Color color, double width) {
    return Container(
      padding: EdgeInsets.all(width < 200 ? 16 : 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(width < 200 ? 8 : 10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: width < 200 ? 20 : 24,
            ),
          ),
          SizedBox(width: width < 200 ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count,
                  style: TextStyle(
                    fontSize: width < 200 ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: width < 200 ? 12 : 14,
                    color: const Color(0xFF1E1E1E),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
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
                      Icons.person,
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
            _buildDrawerItem(context, 'طلباتي', Icons.assignment),
            _buildDrawerItem(context, 'الملف الشخصي', Icons.person),
            _buildDrawerItem(context, 'الإعدادات', Icons.settings),
            const Divider(color: Colors.white24),
            _buildDrawerItem(context, 'تسجيل الخروج', Icons.logout),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        if (title == 'تسجيل الخروج') {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        } else {
          Navigator.pop(context);
        }
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    Color statusColor;
    switch (request['status']) {
      case 'جديد':
        statusColor = const Color(0xFF5F218E);
        break;
      case 'قيد التنفيذ':
        statusColor = const Color(0xFFFFA000);
        break;
      case 'جاهز للتنفيذ':
        statusColor = const Color(0xFF4CAF50);
        break;
      default:
        statusColor = const Color(0xFFE53935);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFF0F0F0),
                child: Text(
                  request['clientName'][0],
                  style: const TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['clientName'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    Text(
                      'طلب #${request['id']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  request['status'],
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.business, size: 20, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                request['requestedService'],
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF1E1E1E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.description_outlined, size: 20, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  request['notes'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text(
                  'تفاصيل الطلب',
                  style: TextStyle(
                    color: Color(0xFF5F218E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;
        
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: InkWell(
            onTap: onTap,
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
} 