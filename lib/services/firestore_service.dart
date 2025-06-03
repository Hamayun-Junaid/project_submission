import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/mood_entry.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addMood(MoodEntry entry) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('moods')
        .doc(entry.id)
        .set(entry.toMap());
  }

  Stream<List<MoodEntry>> getMoodEntries() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const Stream.empty();

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('moods')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => MoodEntry.fromMap(doc.data())).toList());
  }
}
