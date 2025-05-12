import 'package:flutter/material.dart';

class PlayMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isMobile;

  const PlayMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isMobile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 16,
          vertical: isMobile ? 10 : 12,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(icon, size: isMobile ? 18 : 22, color: Colors.black87),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: isMobile ? 13 : 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
