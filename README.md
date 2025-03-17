# Workshop Registrar

A Flutter-based application for managing and registering workshops, developed as part of the Africa Digital Challenge 25. This application allows users to browse, register for, and manage various types of workshops across different categories.

## 🌟 Features

### For Workshop Participants
- Browse workshops by categories (Development, Design, Marketing, Business)
- View detailed workshop information including:
  - Workshop title and description
  - Date and time
  - Location (Virtual/Physical)
  - Available seats and current registrations
  - Prerequisites and materials
- Register for upcoming workshops
- Track registered workshops (Upcoming and Past)
- View workshop certificates and provide feedback for completed workshops
- Add workshops to calendar

### For Workshop Creators
- Create and manage workshops
- Set workshop details including:
  - Title and description
  - Category
  - Date and time
  - Location type (Virtual/Physical)
  - Capacity and minimum participants
  - Prerequisites and materials
- Track workshop registrations
- Manage workshop status

## 🛠️ Technical Details

### Technology Stack
- **Frontend**: Flutter/Dart (87.2%)
- **Additional Languages**:
  - C++ (6.3%)
  - CMake (5.2%)
  - Swift (0.6%)
  - C (0.4%)
  - HTML (0.3%)

### Key Components

#### 1. Main Screen (`lib/user/home/screens/main_screen.dart`)
- Features a search bar for workshop discovery
- Category-based filtering
- Featured workshop display
- List of upcoming workshops
- Quick access to workshop creation

#### 2. My Workshops Screen (`lib/user/home/screens/my_workshop_.dart`)
- Tab-based interface for:
  - Upcoming workshops
  - Past workshops
  - Created workshops
- Workshop management options
- Date-organized workshop listing

### Architecture
The application follows a structured architecture with:
- Separate screens for different functionalities
- Reusable widgets for common UI elements
- Model-based data management
- Router-based navigation using `go_router`

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK
- IDE (VS Code/Android Studio)
- Git

### Installation
1. Clone the repository
```bash
git clone https://github.com/aorfile/workshop-registrar.git
```

2. Navigate to the project directory
```bash
cd workshop-registrar
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the application
```bash
flutter run
```

## 📱 Supported Platforms
- Android
- iOS
- Windows
- Linux
- Web (TBD)

## 🎯 Project Status
This is an entry-level challenge project for Africa Digital Challenge 25. Some features are marked as "Coming Soon" and are under development.

### Latest Updates (as of 2025-03-17)
- Project initialization and basic structure setup
- Implementation of workshop browsing and registration features
- Cross-platform support for desktop environments
- User interface components and navigation system

### Upcoming Features
- Workshop creation functionality
- Certificate generation for completed workshops
- Calendar integration
- Enhanced search and filtering capabilities

## 🤝 Contributing
This project is part of a challenge, but contributions for improvements are welcome. Please follow these steps:
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

### Development Guidelines
- Follow Flutter best practices and coding conventions
- Ensure cross-platform compatibility
- Write clear commit messages
- Update documentation as needed
- Add appropriate comments for complex logic

## 📝 License
[Add License Information]

## 👥 Authors
- [@aorfile](https://github.com/aorfile) - Project Owner and Main Developer

## 🙏 Acknowledgments
- Africa Digital Challenge 25 organizers
- Flutter Development Team
- Contributors and Supporters

## 🎥 Video Demonstration
[Watch the 3-minute demo video here](#)

## 📊 Project Stats
- **Last Updated**: 2025-03-17 18:36:13 UTC
- **Repository ID**: 947312658
- **Primary Language**: Dart
- **Development Status**: Active

---
⭐️ If you find this project helpful, please consider giving it a star!