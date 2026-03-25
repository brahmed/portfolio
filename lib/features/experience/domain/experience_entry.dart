/// Represents a single work experience entry on the timeline.
class ExperienceEntry {
  const ExperienceEntry({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    this.isLast = false,
  });

  final String role;
  final String company;
  final String period;
  final String description;

  /// Used to suppress the connecting line after the last item.
  final bool isLast;
}
