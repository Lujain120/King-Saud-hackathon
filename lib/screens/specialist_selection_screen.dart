import 'package:flutter/material.dart';
import '../models/specialist.dart';
import 'specialist_profile_screen.dart';
import 'request_confirmation_screen.dart';

class SpecialistSelectionScreen extends StatefulWidget {
  final String serviceTitle;
  final String categoryTitle;

  const SpecialistSelectionScreen({
    super.key,
    required this.serviceTitle,
    required this.categoryTitle,
  });

  @override
  State<SpecialistSelectionScreen> createState() => _SpecialistSelectionScreenState();
}

class _SpecialistSelectionScreenState extends State<SpecialistSelectionScreen> {
  String? selectedSpecialistId;

  // Mock data - replace with actual data from your backend
  final List<Specialist> specialists = [
    const Specialist(
      id: '1',
      name: 'أحمد محمد',
      title: 'مطور برمجيات',
      description: 'خبرة 5 سنوات في تطوير تطبيقات الويب والموبايل',
      imageUrl: 'https://via.placeholder.com/150',
      bio: 'مطور برمجيات متخصص في تطوير تطبيقات الويب والموبايل. لدي خبرة واسعة في العمل مع مختلف التقنيات والأدوات الحديثة.',
      services: [
        'تطوير تطبيقات الويب',
        'تطوير تطبيقات الموبايل',
        'تصميم واجهات المستخدم',
        'تطوير واجهات برمجة التطبيقات',
      ],
      experience: [
        'بكالوريوس في هندسة البرمجيات',
        'شهادة AWS Certified Developer',
        'خبرة 5 سنوات في تطوير البرمجيات',
        'عمل مع شركات رائدة في مجال التقنية',
      ],
      linkedinUrl: 'https://linkedin.com/in/ahmed-mohammed',
    ),
    const Specialist(
      id: '2',
      name: 'سارة أحمد',
      title: 'مهندسة برمجيات',
      description: 'متخصصة في تطوير تطبيقات الأندرويد',
      imageUrl: 'https://via.placeholder.com/150',
      bio: 'مهندسة برمجيات متخصصة في تطوير تطبيقات الأندرويد. لدي خبرة في العمل مع Kotlin و Java.',
      services: [
        'تطوير تطبيقات الأندرويد',
        'تصميم واجهات المستخدم',
        'تحسين أداء التطبيقات',
        'تطوير المكتبات والمكونات',
      ],
      experience: [
        'ماجستير في هندسة البرمجيات',
        'شهادة Google Certified Android Developer',
        'خبرة 4 سنوات في تطوير تطبيقات الأندرويد',
        'عمل مع شركات ناشئة وشركات كبيرة',
      ],
    ),
    const Specialist(
      id: '3',
      name: 'محمد علي',
      title: 'مطور واجهات مستخدم',
      description: 'خبرة في تصميم واجهات المستخدم وتجربة المستخدم',
      imageUrl: 'https://via.placeholder.com/150',
      bio: 'مطور واجهات مستخدم متخصص في تصميم وتطوير واجهات المستخدم المتميزة. لدي خبرة في العمل مع React و Vue.js.',
      services: [
        'تصميم واجهات المستخدم',
        'تطوير واجهات المستخدم',
        'تحسين تجربة المستخدم',
        'تطوير المكتبات والمكونات',
      ],
      experience: [
        'بكالوريوس في تصميم واجهات المستخدم',
        'شهادة Google UX Design',
        'خبرة 3 سنوات في تصميم وتطوير واجهات المستخدم',
        'عمل مع شركات تقنية رائدة',
      ],
      linkedinUrl: 'https://linkedin.com/in/mohammed-ali',
    ),
    const Specialist(
      id: '4',
      name: 'فاطمة خالد',
      title: 'مهندسة برمجيات',
      description: 'متخصصة في تطوير تطبيقات iOS',
      imageUrl: 'https://via.placeholder.com/150',
      bio: 'مهندسة برمجيات متخصصة في تطوير تطبيقات iOS. لدي خبرة في العمل مع Swift و Objective-C.',
      services: [
        'تطوير تطبيقات iOS',
        'تصميم واجهات المستخدم',
        'تحسين أداء التطبيقات',
        'تطوير المكتبات والمكونات',
      ],
      experience: [
        'بكالوريوس في هندسة البرمجيات',
        'شهادة Apple Certified iOS Developer',
        'خبرة 4 سنوات في تطوير تطبيقات iOS',
        'عمل مع شركات تقنية رائدة',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختيار المختص'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: specialists.length,
              itemBuilder: (context, index) {
                final specialist = specialists[index];
                final isSelected = specialist.id == selectedSpecialistId;
                return _buildSpecialistCard(specialist, isSelected);
              },
            ),
          ),
          if (selectedSpecialistId != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to confirmation screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestConfirmationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.send),
                    const SizedBox(width: 8),
                    Text(
                      'إرسال الطلب',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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

  Widget _buildSpecialistCard(Specialist specialist, bool isSelected) {
    return Card(
      elevation: isSelected ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isSelected
            ? BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Profile Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              specialist.imageUrl,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          
          // Specialist Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  specialist.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  specialist.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  specialist.description,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecialistProfileScreen(
                          specialist: specialist,
                          onSelect: () {
                            setState(() {
                              selectedSpecialistId = specialist.id;
                            });
                          },
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 36),
                  ),
                  child: const Text('عرض الملف الشخصي'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedSpecialistId = isSelected ? null : specialist.id;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    minimumSize: const Size(double.infinity, 36),
                  ),
                  child: Text(
                    isSelected ? 'إلغاء الاختيار' : 'اختيار هذا العضو',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 