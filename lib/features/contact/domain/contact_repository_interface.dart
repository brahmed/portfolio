import '../data/contact_message_model.dart';

/// Contract for submitting a contact message.
abstract interface class ContactRepositoryInterface {
  Future<void> send(ContactMessageModel message);
}
