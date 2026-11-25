import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/experience.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({super.key, required this.experience});

  final Experience experience;

  @override
  Widget build(BuildContext context) {
    final thumbnail = experience.thumbnail.trim();

    return Scaffold(
      appBar: AppBar(title: Text(experience.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (thumbnail.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                thumbnail,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 220,
                  child: Center(child: Icon(Icons.broken_image_outlined)),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            experience.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            experience.category,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(experience.description),
          const SizedBox(height: 16),
          if (experience.startedAt != null)
            Text('Started: ${experience.startedAt}'),
          if (experience.endedAt != null) Text('Ended: ${experience.endedAt}'),
          if (experience.isOngoing) const Text('Ongoing'),
          const SizedBox(height: 12),
          Text('Stars: ${experience.starCount}'),
        ],
      ),
    );
  }
}
