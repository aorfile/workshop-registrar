class AppAssets {
  static const String _imagesPath = 'assets/images';
  
  // Category Images
  static const String developmentBg = '$_imagesPath/development_bg.jpg';
  static const String designBg = '$_imagesPath/design_bg.jpg';
  static const String marketingBg = '$_imagesPath/marketing_bg.jpg';
  static const String businessBg = '$_imagesPath/business_bg.jpg';
  
  // Workshop Type Icons
  static const String virtualIcon = '$_imagesPath/virtual_icon.svg';
  static const String physicalIcon = '$_imagesPath/physical_icon.svg';
  static const String hybridIcon = '$_imagesPath/hybrid_icon.svg';

  // Placeholder Images
  static const String workshopPlaceholder = '$_imagesPath/workshop_placeholder.jpg';
  static const String avatarPlaceholder = '$_imagesPath/avatar_placeholder.png';
  
  static String getCategoryImage(String category) {
    switch (category.toLowerCase()) {
      case 'development':
        return developmentBg;
      case 'design':
        return designBg;
      case 'marketing':
        return marketingBg;
      case 'business':
        return businessBg;
      default:
        return workshopPlaceholder;
    }
  }
}