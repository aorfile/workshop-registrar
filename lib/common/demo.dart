
import 'package:frontend/user/home/model/resource.dart';
import 'package:frontend/user/home/model/workshop.dart';

class DemoData {
  static const String currentDateTime = '2025-03-12 15:11:57';
  static const String currentUser = 'aorfile';

  static final List<Workshop> workshops = [
    Workshop(
      id: '1',
      title: 'Flutter Development Workshop',
      description: 'Learn to build beautiful cross-platform applications with Flutter. This hands-on workshop covers essential concepts, widgets, and best practices.',
      date: 'March 14, 2025',
      time: '10:00 AM - 2:00 PM',
      totalSeats: 30,
      remainingSeats: 15,
      instructor: 'John Doe',
      topics: ['Flutter', 'Dart', 'UI Design', 'State Management'],
      location: 'Room 101',
      category: 'Development',
      createdAt: DateTime.parse('2025-03-01 09:00:00'),
      isRegistered: false,
    ),
    Workshop(
      id: '2',
      title: 'UI/UX Design Masterclass',
      description: 'Master the principles of user interface and experience design. Learn about user research, wireframing, and creating high-fidelity prototypes.',
      date: 'March 15, 2025',
      time: '2:00 PM - 6:00 PM',
      totalSeats: 25,
      remainingSeats: 8,
      instructor: 'Jane Smith',
      topics: ['UI Design', 'UX Research', 'Prototyping', 'User Testing'],
      location: 'Room 102',
      category: 'Design',
      createdAt: DateTime.parse('2025-03-02 10:00:00'),
      isRegistered: true,
    ),
    Workshop(
      id: '3',
      title: 'Web Development Fundamentals',
      description: 'Get started with modern web development. Cover HTML5, CSS3, JavaScript, and responsive design principles.',
      date: 'March 16, 2025',
      time: '9:00 AM - 1:00 PM',
      totalSeats: 35,
      remainingSeats: 20,
      instructor: 'Mike Wilson',
      topics: ['HTML', 'CSS', 'JavaScript', 'Responsive Design'],
      location: 'Room 103',
      category: 'Development',
      createdAt: DateTime.parse('2025-03-03 11:00:00'),
      isRegistered: false,
    ),
    Workshop(
      id: '4',
      title: 'Data Science with Python',
      description: 'Learn data analysis and visualization using Python. Explore pandas, numpy, and matplotlib libraries.',
      date: 'March 17, 2025',
      time: '1:00 PM - 5:00 PM',
      totalSeats: 28,
      remainingSeats: 12,
      instructor: 'Sarah Johnson',
      topics: ['Python', 'Data Analysis', 'Visualization', 'Statistics'],
      location: 'Room 104',
      category: 'Data Science',
      createdAt: DateTime.parse('2025-03-04 12:00:00'),
      isRegistered: false,
    ),
  ];

  static final List<Resource> resources = [
    Resource(
      id: '1',
      title: 'Flutter Development Guide',
      description: 'Comprehensive guide covering Flutter basics to advanced concepts.',
      type: 'PDF',
      fileUrl: 'assets/resources/flutter_guide.pdf',
      fileSize: '2.5 MB',
      uploadDate: 'March 10, 2025',
      uploadedBy: 'John Doe',
      tags: ['Flutter', 'Mobile Development', 'Beginner'],
      isDownloadable: true,
      downloadCount: 145,
      lastUpdated: DateTime.parse('2025-03-10 09:00:00'),
    ),
    Resource(
      id: '2',
      title: 'UI Design Principles Video',
      description: 'Video tutorial explaining core UI design principles and patterns.',
      type: 'Video',
      fileUrl: 'assets/resources/ui_design.mp4',
      fileSize: '85 MB',
      uploadDate: 'March 11, 2025',
      uploadedBy: 'Jane Smith',
      tags: ['UI Design', 'Design Patterns', 'Tutorial'],
      isDownloadable: true,
      downloadCount: 89,
      lastUpdated: DateTime.parse('2025-03-11 10:00:00'),
    ),
    Resource(
      id: '3',
      title: 'Web Development Slides',
      description: 'Presentation slides covering HTML, CSS, and JavaScript basics.',
      type: 'Presentation',
      fileUrl: 'assets/resources/web_dev_slides.pptx',
      fileSize: '5.8 MB',
      uploadDate: 'March 12, 2025',
      uploadedBy: 'Mike Wilson',
      tags: ['Web Development', 'HTML', 'CSS', 'JavaScript'],
      isDownloadable: true,
      downloadCount: 67,
      lastUpdated: DateTime.parse('2025-03-12 11:00:00'),
    ),
    Resource(
      id: '4',
      title: 'Data Science Code Samples',
      description: 'Python code examples for common data analysis tasks.',
      type: 'Code',
      fileUrl: 'assets/resources/data_science_code.zip',
      fileSize: '1.2 MB',
      uploadDate: 'March 12, 2025',
      uploadedBy: 'Sarah Johnson',
      tags: ['Python', 'Data Science', 'Code Examples'],
      isDownloadable: true,
      downloadCount: 34,
      lastUpdated: DateTime.parse('2025-03-12 12:00:00'),
    ),
    Resource(
      id: '5',
      title: 'UX Research Templates',
      description: 'Templates for user research, personas, and journey maps.',
      type: 'Document',
      fileUrl: 'assets/resources/ux_templates.zip',
      fileSize: '3.7 MB',
      uploadDate: 'March 12, 2025',
      uploadedBy: 'Jane Smith',
      tags: ['UX Research', 'Templates', 'Design'],
      isDownloadable: true,
      downloadCount: 112,
      lastUpdated: DateTime.parse('2025-03-12 13:00:00'),
    ),
  ];

  // Helper methods for filtering and sorting
  static List<Workshop> getWorkshopsByCategory(String category) {
    return workshops.where((w) => w.category == category).toList();
  }

  static List<Workshop> getRegisteredWorkshops() {
    return workshops.where((w) => w.isRegistered).toList();
  }

  static List<Resource> getResourcesByType(String type) {
    return resources.where((r) => r.type == type).toList();
  }

  static List<Resource> searchResources(String query) {
    query = query.toLowerCase();
    return resources.where((r) => 
      r.title.toLowerCase().contains(query) ||
      r.description.toLowerCase().contains(query) ||
      r.tags.any((tag) => tag.toLowerCase().contains(query))
    ).toList();
  }

  // Statistics
  static Map<String, int> getWorkshopStats() {
    return {
      'total': workshops.length,
      'registered': getRegisteredWorkshops().length,
      'available': workshops.where((w) => w.remainingSeats > 0).length,
      'upcoming': workshops.where((w) => DateTime.parse(w.date).isAfter(DateTime.now())).length,
    };
  }

  static Map<String, int> getResourceStats() {
    return {
      'total': resources.length,
      'downloads': resources.fold(0, (sum, r) => sum + r.downloadCount),
      'pdf': getResourcesByType('PDF').length,
      'video': getResourcesByType('Video').length,
    };
  }
}