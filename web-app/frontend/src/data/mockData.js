export const services = {
  tech: {
    title: 'خدمات تقنية',
    services: [
      {
        id: 1,
        title: 'البحث العلمي',
        description: 'خدمات البحث العلمي في مجال التكنولوجيا',
        price: 'متغير'
      },
      {
        id: 2,
        title: 'الشهادات المهنية',
        description: 'شهادات معتمدة في مختلف المجالات التقنية',
        price: 'متغير'
      },
      {
        id: 3,
        title: 'الدورات التدريبية',
        description: 'دورات تدريبية في البرمجة وتطوير البرمجيات',
        price: 'متغير'
      },
      {
        id: 4,
        title: 'الاستشارات',
        description: 'استشارات تقنية متخصصة',
        price: 'متغير'
      },
      {
        id: 5,
        title: 'التطوع',
        description: 'فرص تطوعية في المجال التقني',
        price: 'مجاني'
      }
    ]
  },
  engineering: {
    title: 'خدمات هندسية',
    services: [
      {
        id: 1,
        title: 'البحث العلمي',
        description: 'خدمات البحث العلمي في المجالات الهندسية',
        price: 'متغير'
      },
      {
        id: 2,
        title: 'الشهادات المهنية',
        description: 'شهادات معتمدة في مختلف التخصصات الهندسية',
        price: 'متغير'
      },
      {
        id: 3,
        title: 'الدورات التدريبية',
        description: 'دورات تدريبية في المجالات الهندسية',
        price: 'متغير'
      },
      {
        id: 4,
        title: 'الاستشارات',
        description: 'استشارات هندسية متخصصة',
        price: 'متغير'
      },
      {
        id: 5,
        title: 'التطوع',
        description: 'فرص تطوعية في المجال الهندسي',
        price: 'مجاني'
      }
    ]
  },
  law: {
    title: 'خدمات قانونية',
    services: [
      {
        id: 1,
        title: 'البحث العلمي',
        description: 'خدمات البحث العلمي في المجال القانوني',
        price: 'متغير'
      },
      {
        id: 2,
        title: 'الشهادات المهنية',
        description: 'شهادات معتمدة في المجال القانوني',
        price: 'متغير'
      },
      {
        id: 3,
        title: 'الدورات التدريبية',
        description: 'دورات تدريبية في القانون',
        price: 'متغير'
      },
      {
        id: 4,
        title: 'الاستشارات',
        description: 'استشارات قانونية متخصصة',
        price: 'متغير'
      },
      {
        id: 5,
        title: 'التطوع',
        description: 'فرص تطوعية في المجال القانوني',
        price: 'مجاني'
      }
    ]
  },
  administrative: {
    title: 'خدمات إدارية',
    services: [
      {
        id: 1,
        title: 'البحث العلمي',
        description: 'خدمات البحث العلمي في المجال الإداري',
        price: 'متغير'
      },
      {
        id: 2,
        title: 'الشهادات المهنية',
        description: 'شهادات معتمدة في الإدارة',
        price: 'متغير'
      },
      {
        id: 3,
        title: 'الدورات التدريبية',
        description: 'دورات تدريبية في الإدارة',
        price: 'متغير'
      },
      {
        id: 4,
        title: 'الاستشارات',
        description: 'استشارات إدارية متخصصة',
        price: 'متغير'
      },
      {
        id: 5,
        title: 'التطوع',
        description: 'فرص تطوعية في المجال الإداري',
        price: 'مجاني'
      }
    ]
  }
};

export const members = [
  {
    id: 1,
    name: 'أحمد محمد',
    department: 'tech',
    role: 'member',
    specialization: 'تطوير الويب',
    experience: '5 سنوات',
    rating: 4.5,
    image: 'https://via.placeholder.com/150',
    bio: 'مطور ويب محترف مع خبرة في React و Node.js'
  },
  {
    id: 2,
    name: 'سارة أحمد',
    department: 'engineering',
    role: 'member',
    specialization: 'هندسة البرمجيات',
    experience: '3 سنوات',
    rating: 4.8,
    image: 'https://via.placeholder.com/150',
    bio: 'مهندسة برمجيات متخصصة في تطوير التطبيقات'
  },
  {
    id: 3,
    name: 'محمد علي',
    department: 'law',
    role: 'member',
    specialization: 'القانون التجاري',
    experience: '7 سنوات',
    rating: 4.7,
    image: 'https://via.placeholder.com/150',
    bio: 'محامي متخصص في القانون التجاري'
  },
  {
    id: 4,
    name: 'فاطمة حسن',
    department: 'administrative',
    role: 'member',
    specialization: 'إدارة المشاريع',
    experience: '4 سنوات',
    rating: 4.6,
    image: 'https://via.placeholder.com/150',
    bio: 'مديرة مشاريع محترفة مع خبرة في إدارة الفرق'
  }
];

export const managingTeam = [
  {
    id: 1,
    name: 'خالد عبدالله',
    role: 'managing_team',
    department: 'tech',
    image: 'https://via.placeholder.com/150'
  },
  {
    id: 2,
    name: 'نورا محمد',
    role: 'managing_team',
    department: 'engineering',
    image: 'https://via.placeholder.com/150'
  },
  {
    id: 3,
    name: 'عمر أحمد',
    role: 'managing_team',
    department: 'law',
    image: 'https://via.placeholder.com/150'
  },
  {
    id: 4,
    name: 'ليلى حسن',
    role: 'managing_team',
    department: 'administrative',
    image: 'https://via.placeholder.com/150'
  }
];

export const requests = [
  {
    id: 1,
    clientName: 'عبدالرحمن محمد',
    email: 'abdulrahman@example.com',
    phone: '0501234567',
    service: 'تطوير موقع إلكتروني',
    department: 'tech',
    selectedMember: 1,
    status: 'pending',
    comments: 'أحتاج إلى تطوير موقع إلكتروني لشركتي',
    businessLicense: '123456789',
    createdAt: '2024-03-15'
  }
]; 