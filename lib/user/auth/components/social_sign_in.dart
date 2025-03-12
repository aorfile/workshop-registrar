import 'package:flutter/material.dart';

class SocialSignInButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;

  const SocialSignInButton({
    super.key,
    required this.image,
    required this.onPressed,
  }) ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Image.asset(image),
      ),
    );
  }
}