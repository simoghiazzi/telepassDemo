import 'package:flutter/material.dart';
import '../../models/reel_model.dart';

class Reel extends StatelessWidget {
  final ReelModel reel;
  final VoidCallback? onTap;
  final double size;

  const Reel({super.key, required this.reel, this.onTap, this.size = 112.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    reel.highlighted ? Color(0xFFFFD600) : Colors.grey.shade400,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image.asset(
                  reel.imageUrl,
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.broken_image,
                          size: size * 0.5,
                          color: Colors.grey,
                        ),
                      ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: size + 10,
            child: Text(
              reel.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF1A2647),
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
