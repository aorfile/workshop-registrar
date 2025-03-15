class Registration {
  final String registrationId;
  final String studentId;
  final String workshopId;
  final String status;
  final Map<String, dynamic> formData; // Stores all custom fields
  final DateTime registeredAt;
  final DateTime updatedAt;
  final DateTime? attendanceMarkedAt;
  final String? attendanceMarkedBy;
  final int? waitlistPosition;

  Registration({
    required this.registrationId,
    required this.studentId,
    required this.workshopId,
    required this.status,
    required this.formData,
    required this.registeredAt,
    required this.updatedAt,
    this.attendanceMarkedAt,
    this.attendanceMarkedBy,
    this.waitlistPosition,
  });

  factory Registration.fromForm({
    required String workshopId,
    required Map<String, dynamic> formData,
  }) {
    final now = DateTime.parse('2025-03-15 14:25:22');
    
    return Registration(
      registrationId: '', // Will be assigned by backend
      studentId: 'aorfile',
      workshopId: workshopId,
      status: 'pending',
      formData: formData,
      registeredAt: now,
      updatedAt: now,
    );
  }

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
    registrationId: json['registration_id'],
    studentId: json['student_id'],
    workshopId: json['workshop_id'],
    status: json['status'],
    formData: Map<String, dynamic>.from(json['form_data']),
    registeredAt: DateTime.parse(json['registered_at']),
    updatedAt: DateTime.parse(json['updated_at']),
    attendanceMarkedAt: json['attendance_marked_at'] != null 
      ? DateTime.parse(json['attendance_marked_at'])
      : null,
    attendanceMarkedBy: json['attendance_marked_by'],
    waitlistPosition: json['waitlist_position'],
  );

  Map<String, dynamic> toJson() => {
    'registration_id': registrationId,
    'student_id': studentId,
    'workshop_id': workshopId,
    'status': status,
    'form_data': formData,
    'registered_at': registeredAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'attendance_marked_at': attendanceMarkedAt?.toIso8601String(),
    'attendance_marked_by': attendanceMarkedBy,
    'waitlist_position': waitlistPosition,
  };

  // Helper methods
  bool get isPending => status == 'pending';
  bool get isConfirmed => status == 'confirmed';
  bool get isWaitlisted => status == 'waitlisted';
  bool get isAttended => status == 'attended';
}