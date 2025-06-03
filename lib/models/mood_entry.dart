class MoodEntry {
  final String id;
  final String mood;
  final String? note;
  final DateTime timestamp;

  MoodEntry({
    required this.id,
    required this.mood,
    this.note,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mood': mood,
      'note': note,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      id: map['id'],
      mood: map['mood'],
      note: map['note'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
