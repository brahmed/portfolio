import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/contact_repository_interface.dart';
import 'contact_message_model.dart';

/// Firestore-backed implementation — writes to the `messages` collection.
class ContactRepository implements ContactRepositoryInterface {
  ContactRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<void> send(ContactMessageModel message) =>
      _firestore.collection('messages').add(message.toFirestore());
}
