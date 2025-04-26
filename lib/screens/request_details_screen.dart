import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/shared_app_bar.dart';

class RequestDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> request;

  const RequestDetailsScreen({
    super.key,
    required this.request,
  });

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  final TextEditingController _rejectionReasonController = TextEditingController();
  Map<String, dynamic>? _selectedCandidate;
  bool _isSubmitting = false;

  // Mock list of candidates - Updated with various academic levels from KSU
  final List<Map<String, dynamic>> _candidates = [
    {
      "id": "1",
      "name": "د. محمد العمري",
      "specialization": "أستاذ مشارك في الاقتصاد",
      "completedRequests": 45,
      "availability": "متاح",
      "image": "https://randomuser.me/api/portraits/men/32.jpg",
      "experience": "عضو هيئة تدريس في جامعة الملك سعود",
      "email": "dr.alamri@ksu.edu.sa",
      "phone": "+966 50 123 4567",
      "linkedin": "linkedin.com/in/dr-alamri",
      "bio": "دكتور في الاقتصاد مع خبرة 15 عاماً في مجال الدراسات الاقتصادية والمالية في جامعة الملك سعود. قمت بالإشراف على العديد من الأبحاث والدراسات الاقتصادية وتخريج العديد من طلاب الدراسات العليا.",
      "expertise": [
        "التحليل المالي",
        "دراسات الجدوى الاقتصادية",
        "البحث العلمي",
        "تحليل البيانات"
      ],
      "languages": ["العربية", "الإنجليزية"]
    },
    {
      "id": "2",
      "name": "سارة الدوسري",
      "specialization": "طالبة دكتوراه في إدارة الأعمال",
      "completedRequests": 12,
      "availability": "متاح",
      "image": "https://randomuser.me/api/portraits/women/44.jpg",
      "experience": "محاضر في كلية إدارة الأعمال - جامعة الملك سعود",
      "email": "s.aldosari@ksu.edu.sa",
      "phone": "+966 50 234 5678",
      "linkedin": "linkedin.com/in/saldosari",
      "bio": "طالبة دكتوراه في إدارة الأعمال بجامعة الملك سعود، ومحاضر في نفس الكلية. متخصصة في مجال الإدارة الاستراتيجية وريادة الأعمال. شاركت في العديد من المؤتمرات والأبحاث العلمية.",
      "expertise": [
        "الإدارة الاستراتيجية",
        "ريادة الأعمال",
        "إدارة المشاريع",
        "التخطيط الاستراتيجي"
      ],
      "languages": ["العربية", "الإنجليزية"]
    },
    {
      "id": "3",
      "name": "عبدالله القحطاني",
      "specialization": "طالب ماجستير في المحاسبة",
      "completedRequests": 8,
      "availability": "متاح",
      "image": "https://randomuser.me/api/portraits/men/45.jpg",
      "experience": "معيد في كلية إدارة الأعمال - جامعة الملك سعود",
      "email": "a.alqahtani@ksu.edu.sa",
      "phone": "+966 50 345 6789",
      "linkedin": "linkedin.com/in/aalqahtani",
      "bio": "معيد في قسم المحاسبة بجامعة الملك سعود وطالب ماجستير في نفس التخصص. مهتم بمجال المحاسبة المالية والتدقيق. شارك في عدة مشاريع بحثية في مجال المحاسبة.",
      "expertise": [
        "المحاسبة المالية",
        "التدقيق المالي",
        "إعداد التقارير المالية",
        "تحليل القوائم المالية"
      ],
      "languages": ["العربية", "الإنجليزية"]
    },
    {
      "id": "4",
      "name": "نورة السبيعي",
      "specialization": "طالبة دبلوم عالي في الإدارة العامة",
      "completedRequests": 5,
      "availability": "متاح",
      "image": "https://randomuser.me/api/portraits/women/46.jpg",
      "experience": "موظفة إدارية في جامعة الملك سعود",
      "email": "n.alsubaie@ksu.edu.sa",
      "phone": "+966 50 456 7890",
      "linkedin": "linkedin.com/in/nalsubaie",
      "bio": "طالبة دبلوم عالي في الإدارة العامة بجامعة الملك سعود. لدي خبرة 3 سنوات في العمل الإداري بالجامعة. مهتمة بتطوير الأنظمة الإدارية وتحسين إجراءات العمل.",
      "expertise": [
        "الإدارة العامة",
        "التطوير الإداري",
        "إدارة المكاتب",
        "التنظيم الإداري"
      ],
      "languages": ["العربية", "الإنجليزية"]
    },
    {
      "id": "5",
      "name": "فهد العتيبي",
      "specialization": "طالب بكالوريوس في الاقتصاد - السنة الأخيرة",
      "completedRequests": 3,
      "availability": "متاح",
      "image": "https://randomuser.me/api/portraits/men/47.jpg",
      "experience": "متدرب في وحدة الدراسات الاقتصادية - جامعة الملك سعود",
      "email": "f.alotaibi@ksu.edu.sa",
      "phone": "+966 50 567 8901",
      "linkedin": "linkedin.com/in/falotaibi",
      "bio": "طالب في السنة الأخيرة من بكالوريوس الاقتصاد بجامعة الملك سعود. متدرب في وحدة الدراسات الاقتصادية. شارك في عدة مشاريع بحثية طلابية وحاصل على جوائز في مسابقات البحث العلمي.",
      "expertise": [
        "التحليل الاقتصادي",
        "دراسات السوق",
        "البحث العلمي",
        "تحليل البيانات الأساسية"
      ],
      "languages": ["العربية", "الإنجليزية"]
    }
  ];

  @override
  void dispose() {
    _rejectionReasonController.dispose();
    super.dispose();
  }

  void _handleAcceptRequest() {
    if (_selectedCandidate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء اختيار عضو مناسب للطلب'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSubmitting = false;
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('تم قبول الطلب'),
          content: Text(
            'تم إسناد الطلب إلى ${_selectedCandidate!["name"]} وسيتم إشعار العميل.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Return to dashboard
              },
              child: const Text('حسناً'),
            ),
          ],
        ),
      );
    });
  }

  void _showRejectDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('رفض الطلب'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('الرجاء ذكر سبب الرفض:'),
            const SizedBox(height: 16),
            TextField(
              controller: _rejectionReasonController,
              decoration: const InputDecoration(
                hintText: 'سبب الرفض...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              if (_rejectionReasonController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('الرجاء إدخال سبب الرفض'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              Navigator.pop(context);
              _handleRejectRequest();
            },
            child: const Text('رفض', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _handleRejectRequest() {
    setState(() {
      _isSubmitting = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isSubmitting = false;
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('تم رفض الطلب'),
          content: const Text('سيتم إشعار العميل برفض الطلب مع ذكر السبب.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Return to dashboard
              },
              child: const Text('حسناً'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FC),
        appBar: _buildAppBar(context, isSmallScreen),
        drawer: isSmallScreen ? _buildDrawer(context) : null,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Request Details Card
              Container(
                padding: const EdgeInsets.all(24),
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
                          radius: 24,
                          backgroundColor: const Color(0xFFF0F0F0),
                          child: Text(
                            widget.request['clientName'][0],
                            style: const TextStyle(
                              color: Color(0xFF1E1E1E),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.request['clientName'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E1E1E),
                                ),
                              ),
                              Text(
                                'طلب #${widget.request['id']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.request['status'],
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildInfoRow('الخدمة المطلوبة:', widget.request['requestedService']),
                    _buildInfoRow('البريد الإلكتروني:', widget.request['email']),
                    _buildInfoRow('رقم الهاتف:', widget.request['phone']),
                    _buildInfoRow('تاريخ الطلب:', widget.request['date']),
                    _buildInfoRow('رقم الترخيص:', widget.request['licenseNumber'] ?? '-'),
                    const SizedBox(height: 16),
                    const Text(
                      'تفاصيل إضافية:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.request['notes'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Candidates Section
              Container(
                padding: const EdgeInsets.all(24),
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
                    const Text(
                      'اختر العضو المناسب',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _candidates.length,
                      itemBuilder: (context, index) {
                        final candidate = _candidates[index];
                        final isSelected = _selectedCandidate == candidate;
                        
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected 
                                    ? AppTheme.primaryColor 
                                    : Colors.grey.shade200,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  RadioListTile<Map<String, dynamic>>(
                                    value: candidate,
                                    groupValue: _selectedCandidate,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCandidate = value;
                                      });
                                    },
                                    title: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(candidate['image']),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                candidate['name'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                candidate['specialization'],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle, size: 16, color: Colors.green[700]),
                                          Text(' ${candidate['completedRequests']} طلب مكتمل'),
                                          const Text(' | '),
                                          Icon(Icons.work, size: 16, color: Colors.blue[700]),
                                          Text(' ${candidate['experience']}'),
                                        ],
                                      ),
                                    ),
                                    activeColor: AppTheme.primaryColor,
                                  ),
                                  if (isSelected)
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'معلومات التواصل',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E1E1E),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          _buildContactInfo(Icons.email, candidate['email']),
                                          _buildContactInfo(Icons.phone, candidate['phone']),
                                          _buildContactInfo(Icons.link, candidate['linkedin']),
                                          const Divider(height: 24),
                                          const Text(
                                            'نبذة مختصرة',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E1E1E),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            candidate['bio'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700],
                                              height: 1.5,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            'مجالات الخبرة',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E1E1E),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: (candidate['expertise'] as List<String>)
                                                .map((expertise) => Container(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppTheme.primaryColor.withOpacity(0.1),
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      child: Text(
                                                        expertise,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: AppTheme.primaryColor,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            'اللغات',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E1E1E),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: (candidate['languages'] as List<String>)
                                                .map((language) => Container(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue.withOpacity(0.1),
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      child: Text(
                                                        language,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Updated action buttons with white text
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _showRejectDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'رفض الطلب',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _handleAcceptRequest,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSubmitting
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'قبول الطلب',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 20, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
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
            _buildDrawerItem(context, 'الطلبات', Icons.assignment),
            _buildDrawerItem(context, 'الإحصائيات', Icons.bar_chart),
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
        Navigator.pop(context);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isSmallScreen) {
    final appBarHeight = 70.0;
    
    final logoutButton = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        },
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
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                      },
                      child: Image.asset(
                        'assets/icons/IMG_7405.JPG',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
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
                              children: [
                                _buildNavItem(context, 'الرئيسية', Icons.home, () {}),
                                _buildNavItem(context, 'الطلبات', Icons.assignment, () {}),
                                _buildNavItem(context, 'الأعضاء', Icons.people, () {}),
                                _buildNavItem(context, 'الإعدادات', Icons.settings, () {}),
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