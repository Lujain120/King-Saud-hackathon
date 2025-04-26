import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CandidateSelectionModal extends StatefulWidget {
  final Map<String, dynamic> request;

  const CandidateSelectionModal({
    super.key,
    required this.request,
  });

  @override
  State<CandidateSelectionModal> createState() => _CandidateSelectionModalState();
}

class _CandidateSelectionModalState extends State<CandidateSelectionModal> with SingleTickerProviderStateMixin {
  int? _selectedCandidateIndex;
  bool _isSubmitting = false;
  bool _isLoading = true;
  String _searchQuery = '';
  List<Map<String, dynamic>> _filteredCandidates = [];
  
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  // Sample list of candidates - in a real app, this would be fetched based on the request
  final List<Map<String, dynamic>> _allCandidates = [
    {
      "id": "MEM001",
      "name": "د. محمد الغامدي",
      "specialization": "استشارات إدارية",
      "bio": "خبير استشاري في مجال إدارة المشاريع والتخطيط الاستراتيجي مع خبرة تزيد عن 10 سنوات في العمل مع شركات محلية ودولية",
      "serviceTags": ["استشارية", "دراسة جدوى", "تخطيط استراتيجي"],
      "rating": 4.8,
      "experience": "10 سنوات",
      "price": "1500 ر.س",
      "profileImage": "https://randomuser.me/api/portraits/men/32.jpg",
      "linkedin": "https://linkedin.com/in/mohammedalghandi",
    },
    {
      "id": "MEM002",
      "name": "أ. نورة السبيعي",
      "specialization": "تخطيط استراتيجي",
      "bio": "متخصصة في التخطيط الاستراتيجي وتطوير الأعمال، عملت مع العديد من الشركات الناشئة والمؤسسات الحكومية في تطوير خطط النمو",
      "serviceTags": ["استشارية", "تخطيط استراتيجي", "تطوير الأفكار"],
      "rating": 4.9,
      "experience": "8 سنوات",
      "price": "1200 ر.س",
      "profileImage": "https://randomuser.me/api/portraits/women/44.jpg",
      "linkedin": "https://linkedin.com/in/nouraalsebai",
    },
    {
      "id": "MEM003",
      "name": "د. فهد القحطاني",
      "specialization": "تمويل واستثمار",
      "bio": "دكتوراه في الاقتصاد وخبير في التمويل والاستثمار، قدم استشارات لأكثر من 50 شركة في مجال التخطيط المالي وإدارة المخاطر",
      "serviceTags": ["استشارية", "تمويل و استثمار", "الحوكمة و الامتثال"],
      "rating": 4.7,
      "experience": "12 سنوات",
      "price": "1800 ر.س",
      "profileImage": "https://randomuser.me/api/portraits/men/62.jpg",
      "linkedin": "https://linkedin.com/in/fahadqahtani",
    },
    {
      "id": "MEM004",
      "name": "م. سارة العتيبي",
      "specialization": "إدارة المشاريع",
      "bio": "مهندسة معمارية ومديرة مشاريع معتمدة PMP، متخصصة في إدارة المشاريع الإنشائية والتطوير العقاري",
      "serviceTags": ["استشارية", "إدارة المشاريع", "الهياكل التنظيمية"],
      "rating": 4.6,
      "experience": "7 سنوات",
      "price": "1350 ر.س",
      "profileImage": "https://randomuser.me/api/portraits/women/22.jpg",
      "linkedin": null,
    },
    {
      "id": "MEM005",
      "name": "أ. عبدالله المالكي",
      "specialization": "تدريب وتطوير",
      "bio": "مدرب معتمد في مجال التنمية البشرية والإدارة، قدم أكثر من 200 دورة تدريبية في مجالات متعددة",
      "serviceTags": ["دورات تدريبية", "إدارة الوقت", "مهارات التواصل"],
      "rating": 4.9,
      "experience": "9 سنوات",
      "price": "1100 ر.س",
      "profileImage": "https://randomuser.me/api/portraits/men/18.jpg",
      "linkedin": "https://linkedin.com/in/abdullahalmalki",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadCandidates();
    
    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );
    
    // Start animation
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadCandidates() {
    // Simulate API call
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      
      // Get service information from request
      final String category = widget.request["category"] ?? "";
      final String subcategory = widget.request["subcategory"] ?? "";
      final String service = widget.request["service"] ?? "";
      
      // Filter candidates by matching service tags
      final filtered = _allCandidates.where((candidate) {
        final serviceTags = candidate["serviceTags"] as List<String>;
        return serviceTags.contains(category) || 
               serviceTags.contains(subcategory) || 
               serviceTags.contains(service);
      }).toList();
      
      setState(() {
        _filteredCandidates = filtered;
        _isLoading = false;
      });
    });
  }

  void _selectCandidate(int index) {
    setState(() {
      _selectedCandidateIndex = index;
    });
  }

  void _filterCandidates(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  List<Map<String, dynamic>> get _displayedCandidates {
    if (_searchQuery.isEmpty) {
      return _filteredCandidates;
    }
    
    return _filteredCandidates.where((candidate) {
      final name = candidate["name"] as String;
      final specialization = candidate["specialization"] as String;
      final bio = candidate["bio"] as String;
      
      return name.contains(_searchQuery) || 
             specialization.contains(_searchQuery) || 
             bio.contains(_searchQuery);
    }).toList();
  }

  void _submitSelection() {
    if (_selectedCandidateIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("الرجاء اختيار عضو أولاً")),
      );
      return;
    }
    
    setState(() {
      _isSubmitting = true;
    });
    
    // Simulate API call with delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      
      // Run closing animation
      _animationController.reverse().then((_) {
        setState(() {
          _isSubmitting = false;
        });
        
        // Show success message and return selected candidate
        final selectedCandidate = _displayedCandidates[_selectedCandidateIndex!];
        Navigator.of(context).pop(selectedCandidate);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("تم إرسال الطلب إلى ${selectedCandidate["name"]} بنجاح"),
            backgroundColor: Colors.green,
          ),
        );
      });
    });
  }

  Future<void> _launchURL(String? url) async {
    if (url == null || url.isEmpty) return;
    
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تعذر فتح الرابط: $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: isSmallScreen ? double.infinity : 650,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
              maxWidth: 650,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "اختيار العضو المناسب",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Run the animation in reverse before closing
                          _animationController.reverse().then((_) {
                            Navigator.of(context).pop();
                          });
                        },
                        icon: const Icon(Icons.close, color: Colors.white),
                        splashRadius: 24,
                      ),
                    ],
                  ),
                ),
                
                // Request info & search bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Request info
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الطلب: ${widget.request["id"] ?? ""}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "الخدمة المطلوبة: ${widget.request["service"] ?? "غير محدد"}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              "العميل: ${widget.request["clientName"] ?? "غير محدد"}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Search bar
                      TextField(
                        onChanged: _filterCandidates,
                        decoration: InputDecoration(
                          hintText: "ابحث عن اسم أو تخصص...",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          fillColor: Colors.grey[50],
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Loading indicator or empty state
                if (_isLoading)
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  )
                else if (_displayedCandidates.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_search,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "لم يتم العثور على أعضاء مناسبين",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "جرب تغيير معايير البحث أو العودة لاحقًا",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                // Candidates list
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _displayedCandidates.length,
                      itemBuilder: (context, index) {
                        final candidate = _displayedCandidates[index];
                        final isSelected = _selectedCandidateIndex == index;
                        
                        return _buildCandidateCard(candidate, index, isSelected);
                      },
                    ),
                  ),
                
                // Submit button
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFEEEEEE),
                        width: 1,
                      ),
                    ),
                  ),
                  child: _buildAnimatedButton(
                    onPressed: _selectedCandidateIndex == null || _isSubmitting 
                        ? null 
                        : _submitSelection,
                    backgroundColor: AppTheme.primaryColor,
                    textColor: Colors.white,
                    text: "قبول وإرسال للعضو",
                    isLoading: _isSubmitting,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCandidateCard(Map<String, dynamic> candidate, int index, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: isSelected ? 4 : 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? AppTheme.primaryColor : Colors.transparent,
            width: isSelected ? 2 : 0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with image and basic info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile image
                  Hero(
                    tag: 'candidate-${candidate["id"]}',
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(candidate["profileImage"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Basic info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name and selection radio
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                candidate["name"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected 
                                  ? AppTheme.primaryColor.withOpacity(0.1) 
                                  : Colors.transparent,
                              ),
                              child: Radio<int>(
                                value: index,
                                groupValue: _selectedCandidateIndex,
                                onChanged: (value) => _selectCandidate(value!),
                                activeColor: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        
                        // Specialization
                        Text(
                          candidate["specialization"],
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // Stats row
                        Row(
                          children: [
                            _buildInfoChip(
                              Icons.star,
                              candidate["rating"].toString(),
                              Colors.amber,
                            ),
                            const SizedBox(width: 8),
                            _buildInfoChip(
                              Icons.work,
                              candidate["experience"],
                              Colors.blue,
                            ),
                            const SizedBox(width: 8),
                            _buildInfoChip(
                              Icons.attach_money,
                              candidate["price"],
                              Colors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              
              // Bio
              Text(
                "نبذة",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                candidate["bio"],
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.grey[700],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // LinkedIn + Select button
              Row(
                children: [
                  // LinkedIn button
                  if (candidate["linkedin"] != null)
                    _buildAnimatedButton(
                      onPressed: () => _launchURL(candidate["linkedin"]),
                      backgroundColor: Colors.transparent,
                      textColor: Colors.blue[700]!,
                      text: "LinkedIn",
                      icon: Icons.link,
                      isOutlined: true,
                      width: 120,
                    ),
                  
                  const Spacer(),
                  
                  // Select button
                  _buildAnimatedButton(
                    onPressed: () => _selectCandidate(index),
                    backgroundColor: isSelected ? Colors.green : AppTheme.primaryColor,
                    textColor: Colors.white,
                    text: isSelected ? "تم الاختيار" : "اختيار هذا العضو",
                    icon: isSelected ? Icons.check_circle : Icons.person_add,
                    width: 180,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildAnimatedButton({
    required VoidCallback? onPressed,
    required Color backgroundColor,
    required Color textColor,
    required String text,
    IconData? icon,
    bool isOutlined = false,
    bool isLoading = false,
    double? width,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovering = false;
        
        return MouseRegion(
          onEnter: (_) => setState(() => isHovering = true),
          onExit: (_) => setState(() => isHovering = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: width ?? double.infinity,
            height: 50,
            child: isOutlined
              ? OutlinedButton.icon(
                  onPressed: onPressed,
                  icon: Icon(icon ?? Icons.check),
                  label: Text(text),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: textColor,
                    side: BorderSide(color: textColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: isHovering 
                      ? textColor.withOpacity(0.1) 
                      : Colors.transparent,
                  ),
                )
              : ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    foregroundColor: textColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: Colors.grey[300],
                    elevation: isHovering ? 4 : 2,
                  ),
                  child: isLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : icon != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(icon, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              text,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          text,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
          ),
        );
      },
    );
  }
  
  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 