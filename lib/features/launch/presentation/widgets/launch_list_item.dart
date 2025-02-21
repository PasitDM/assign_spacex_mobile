import 'package:flutter/material.dart';
import '../../../../common/components/images/app_image.dart';
import '../../../../extension/date_extension.dart';
import '../../domain/entities/launch.dart';

class LaunchListItem extends StatelessWidget {
  final Launch launch;
  final VoidCallback onTap;

  const LaunchListItem({super.key, required this.launch, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final launchDate = DateTime.parse(launch.dateUtc);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(launch.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                    const SizedBox(height: 6),
                    Text(
                      'Launch Date: ${launchDate.formatDateTime(DateFormatPattern.dayMonthYearHHmm)}',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Status: ${launch.upcoming ? 'Upcoming' : 'Past'}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: launch.upcoming ? Colors.orange : Colors.green,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text('•', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
                        ),
                        Text(
                          'Result: ${launch.success ? 'Success' : 'Failure'}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: launch.success ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Builder(
                builder: (context) {
                  if (launch.patchSmall.isNotEmpty) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AppImage(imageUrl: launch.patchSmall, width: 80, height: 80),
                    );
                  } else {
                    return Icon(Icons.error, color: Colors.grey[400], size: 80);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
