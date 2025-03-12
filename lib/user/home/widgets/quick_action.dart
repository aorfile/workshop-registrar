import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _QuickActionCard(
                  title: 'Register Workshop',
                  icon: Icons.add_circle_outline,
                  color: Colors.teal,
                  onTap: () {},
                  width: isMobile ? double.infinity : 200,
                ),
                _QuickActionCard(
                  title: 'Download Resources',
                  icon: Icons.download_outlined,
                  color: Colors.indigo,
                  onTap: () {},
                  width: isMobile ? double.infinity : 200,
                ),
                _QuickActionCard(
                  title: 'View Schedule',
                  icon: Icons.calendar_today_outlined,
                  color: Colors.orange,
                  onTap: () {},
                  width: isMobile ? double.infinity : 200,
                ),
                _QuickActionCard(
                  title: 'Contact Support',
                  icon: Icons.support_agent_outlined,
                  color: Colors.purple,
                  onTap: () {},
                  width: isMobile ? double.infinity : 200,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final double width;

  const _QuickActionCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: color.withOpacity(0.2),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}