import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'candidate_selection_modal.dart';

class RequestCardGrid extends StatefulWidget {
  final List<Map<String, dynamic>> requests;
  final bool isSmallScreen;

  const RequestCardGrid({
    super.key,
    required this.requests,
    required this.isSmallScreen,
  });

  @override
  State<RequestCardGrid> createState() => _RequestCardGridState();
}

class _RequestCardGridState extends State<RequestCardGrid> with TickerProviderStateMixin {
  // Track which request is showing the rejection dialog
  int? _showingRejectionForIndex;
  final Map<int, TextEditingController> _rejectionControllers = {};
  
  // Track which requests have assigned members
  final Map<int, Map<String, dynamic>> _assignedMembers = {};
  
  // Animation controllers for hover effects
  final Map<int, AnimationController> _hoverControllers = {};
  final Map<int, bool> _isHovering = {};
  
  @override
  void initState() {
    super.initState();
    // Initialize hover controllers for each request
    for (int i = 0; i < widget.requests.length; i++) {
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
    // Dispose all text controllers
    for (final controller in _rejectionControllers.values) {
      controller.dispose();
    }
    // Dispose all animation controllers
    for (final controller in _hoverControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
  
  @override
  void didUpdateWidget(RequestCardGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // If the request count changes, update hover controllers
    if (widget.requests.length != oldWidget.requests.length) {
      // Dispose old controllers if needed
      for (int i = widget.requests.length; i < oldWidget.requests.length; i++) {
        _hoverControllers[i]?.dispose();
        _hoverControllers.remove(i);
        _isHovering.remove(i);
      }
      
      // Add new controllers if needed
      for (int i = 0; i < widget.requests.length; i++) {
        if (!_hoverControllers.containsKey(i)) {
          _hoverControllers[i] = AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 200),
            value: 0,
          );
          _isHovering[i] = false;
        }
      }
    }
  }
  
  // Get or create a controller for a specific index
  TextEditingController _getController(int index) {
    if (!_rejectionControllers.containsKey(index)) {
      _rejectionControllers[index] = TextEditingController();
    }
    return _rejectionControllers[index]!;
  }

  // Handle assigning a member to a request
  void _assignMember(int index, Map<String, dynamic> member) {
    setState(() {
      _assignedMembers[index] = member;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.isSmallScreen ? 1 : widget.isSmallScreen ? 2 : 3,
        childAspectRatio: widget.isSmallScreen ? 1.0 : 1.1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: widget.requests.length,
      itemBuilder: (context, index) {
        final request = widget.requests[index];
        return _buildRequestCard(context, request, index);
      },
    );
  }

  // Get color for status badge
  Color _getStatusColor(String status) {
    switch (status) {
      case "جديد":
        return const Color(0xFF9C27B0); // Light purple
      case "قيد المراجعة":
        return const Color(0xFFFFB300); // Yellow
      case "تم القبول":
        return const Color(0xFF4CAF50); // Green
      case "مرفوض":
      case "تم الرفض":
        return const Color(0xFFF44336); // Red
      default:
        return const Color(0xFF9C27B0); // Default to purple for new
    }
  }

  Widget _buildRequestCard(BuildContext context, Map<String, dynamic> request, int index) {
    final bool isShowingRejection = _showingRejectionForIndex == index;
    final bool hasAssignedMember = _assignedMembers.containsKey(index);
    final assignedMember = hasAssignedMember ? _assignedMembers[index] : null;
    
    // Animations for hover effect
    Animation<double> elevationAnimation = CurvedAnimation(
      parent: _hoverControllers[index]!,
      curve: Curves.easeOut,
    );
    
    Animation<double> scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverControllers[index]!,
      curve: Curves.easeOut,
    ));
    
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering[index] = true;
        });
        _hoverControllers[index]!.forward();
      },
      onExit: (_) {
        setState(() {
          _isHovering[index] = false;
        });
        _hoverControllers[index]!.reverse();
      },
      child: AnimatedBuilder(
        animation: _hoverControllers[index]!,
        builder: (context, child) {
          return Transform.scale(
            scale: scaleAnimation.value,
            child: Card(
              elevation: 2 + (elevationAnimation.value * 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SizedBox(
                height: 420, // Consistent card height
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with ID and status
                    Container(
                      decoration: BoxDecoration(
                        color: hasAssignedMember ? Colors.green : AppTheme.primaryColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            request["id"] ?? "#${index + 1}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // Pill status badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20), // Pill shape
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  margin: const EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _getStatusColor(hasAssignedMember ? "تم القبول" : (request["status"] ?? "جديد")),
                                  ),
                                ),
                                Text(
                                  hasAssignedMember ? "تم التعيين" : (request["status"] ?? "جديد"),
                                  style: TextStyle(
                                    color: _getStatusColor(hasAssignedMember ? "تم القبول" : (request["status"] ?? "جديد")),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Request details
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoItem("الاسم الكامل", request["clientName"] ?? "غير متوفر"),
                              _buildInfoItem("البريد الإلكتروني", request["email"] ?? "client@example.com"),
                              _buildInfoItem("رقم الجوال", request["phone"] ?? "+966 50 123 4567"),
                              _buildInfoItem("الخدمة المطلوبة", "${request["category"] ?? ""} - ${request["subcategory"] ?? ""} - ${request["service"] ?? ""}"),
                              _buildInfoItem("ملاحظات إضافية", request["details"] ?? "لا توجد ملاحظات"),
                              _buildInfoItem("رقم السجل التجاري", request["licenseNumber"] ?? "غير متوفر"),
                              _buildInfoItem("تاريخ الطلب", request["time"] ?? "غير محدد"),
                              
                              // Assigned member section (if a member is assigned)
                              if (hasAssignedMember) 
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.only(top: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.green.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "تم تعيين العضو",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundImage: NetworkImage(assignedMember!["profileImage"]),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              assignedMember["name"],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        assignedMember["specialization"],
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
                        ),
                      ),
                    ),
                    
                    // Rejection form if showing
                    if (isShowingRejection)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "سبب الرفض",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _getController(index),
                              maxLines: 2,
                              decoration: InputDecoration(
                                hintText: "اكتب سبب الرفض هنا...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.all(12),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildAnimatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _showingRejectionForIndex = null;
                                      });
                                    },
                                    backgroundColor: Colors.grey[200]!,
                                    textColor: Colors.grey[700]!,
                                    label: "إلغاء",
                                    isOutlined: true,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildAnimatedButton(
                                    onPressed: () {
                                      // Handle rejection confirmation
                                      final reason = _getController(index).text;
                                      if (reason.trim().isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("الرجاء إدخال سبب الرفض")),
                                        );
                                        return;
                                      }
                                      
                                      // Actually reject the request
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("تم رفض الطلب: ${reason.trim()}")),
                                      );
                                      
                                      setState(() {
                                        _showingRejectionForIndex = null;
                                        // In a real app, update the request status
                                      });
                                    },
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    label: "تأكيد الرفض",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    
                    // Action buttons
                    if (!isShowingRejection)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // If no member is assigned yet, show candidate selection button
                            if (!hasAssignedMember)
                              Expanded(
                                child: _buildAnimatedButton(
                                  onPressed: () async {
                                    // Show candidates modal and wait for result
                                    final selectedMember = await showDialog<Map<String, dynamic>>(
                                      context: context,
                                      builder: (context) => CandidateSelectionModal(
                                        request: request,
                                      ),
                                    );
                                    
                                    // Handle the selected member
                                    if (selectedMember != null) {
                                      _assignMember(index, selectedMember);
                                    }
                                  },
                                  backgroundColor: AppTheme.primaryColor,
                                  textColor: Colors.white,
                                  icon: Icons.people,
                                  label: "عرض المرشحين",
                                ),
                              )
                            // If member is assigned, show confirmation button
                            else
                              Expanded(
                                child: _buildAnimatedButton(
                                  onPressed: null, // Disabled as already confirmed
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  icon: Icons.check_circle,
                                  label: "تم إرسال الطلب",
                                  disabledBackgroundColor: Colors.green.withOpacity(0.7),
                                ),
                              ),
                            
                            if (!hasAssignedMember)
                              ...[
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildAnimatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _showingRejectionForIndex = index;
                                      });
                                    },
                                    backgroundColor: Colors.white,
                                    textColor: Colors.red,
                                    borderColor: Colors.red,
                                    icon: Icons.cancel_outlined,
                                    label: "رفض الطلب",
                                    isOutlined: true,
                                  ),
                                ),
                              ],
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  // Animated button with hover effect
  Widget _buildAnimatedButton({
    required VoidCallback? onPressed,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
    Color? disabledBackgroundColor,
    bool isOutlined = false,
    IconData? icon,
    required String label,
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
            child: isOutlined 
              ? OutlinedButton.icon(
                  onPressed: onPressed,
                  icon: Icon(icon ?? Icons.check, size: 16),
                  label: Text(
                    label,
                    style: TextStyle(fontSize: 12),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: textColor,
                    side: BorderSide(color: borderColor ?? textColor),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: isHovering ? borderColor?.withOpacity(0.1) ?? textColor.withOpacity(0.1) : null,
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: onPressed,
                  icon: Icon(icon ?? Icons.check, size: 16),
                  label: Text(
                    label,
                    style: const TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    foregroundColor: textColor,
                    disabledBackgroundColor: disabledBackgroundColor ?? backgroundColor.withOpacity(0.7),
                    disabledForegroundColor: textColor,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    elevation: isHovering ? 4 : 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
          ),
        );
      },
    );
  }
  
  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          Divider(color: Colors.grey[200]),
        ],
      ),
    );
  }
} 