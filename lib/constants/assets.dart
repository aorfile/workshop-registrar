class AppAssets {
  static const String _basePath = 'assets';
  static const String _imagesPath = '$_basePath/images';
  static const String _categoriesPath = '$_imagesPath/categories';
  static const String _defaultPath = '$_imagesPath/defaults';
  static const String _backgroundsPath = '$_imagesPath/backgrounds';

  // Default Images
  static const String defaultWorkshopImage = '$_defaultPath/workshop_default.jpg';
  static const String defaultUserAvatar = '$_defaultPath/user_avatar.png';
  static const String defaultErrorImage = '$_defaultPath/error_image.png';
  static const String placeholderImage = '$_defaultPath/placeholder.png';

  // Category Images - Using Unsplash Images
  static const Map<String, String> categoryImages = {
    'development': 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6',
    'design': 'https://images.unsplash.com/photo-1561070791-2526d30994b5',
    'marketing': 'https://images.unsplash.com/photo-1460925895917-afdab827c52f',
    'business': 'https://images.unsplash.com/photo-1507679799987-c73779587ccf',
    'technology': 'https://images.unsplash.com/photo-1518770660439-4636190af475',
    'data': 'https://images.unsplash.com/photo-1551288049-bebda4e38f71',
    'product': 'https://images.unsplash.com/photo-1460925895917-afdab827c52f',
    'leadership': 'https://images.unsplash.com/photo-1519389950473-47ba0277781c',
  };

  // Background Images - Using Unsplash Images
  static const Map<String, String> locationTypeImages = {
    'virtual': 'https://images.unsplash.com/photo-1516321165247-4aa89a48be28',
    'physical': 'https://images.unsplash.com/photo-1517048676732-d65bc937f952',
    'hybrid': 'https://images.unsplash.com/photo-1527689368864-3a821dbccc34',
  };

  static String getCategoryImage(String category) {
    return categoryImages[category.toLowerCase()] ?? defaultWorkshopImage;
  }

  static String getLocationTypeBackground(String locationType) {
    return locationTypeImages[locationType.toLowerCase()] ?? defaultWorkshopImage;
  }
}