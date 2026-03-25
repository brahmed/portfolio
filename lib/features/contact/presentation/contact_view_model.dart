import 'package:flutter/foundation.dart';

import '../../../core/utils/logger.dart';
import '../data/contact_message_model.dart';
import '../domain/contact_repository_interface.dart';

enum FormStatus { idle, sending, success, error }

/// Owns contact form state: field values, validation errors, and submit status.
class ContactViewModel extends ChangeNotifier {
  ContactViewModel({required ContactRepositoryInterface repository})
      : _repository = repository;

  final ContactRepositoryInterface _repository;

  // ── Field values ──────────────────────────────────────────────────────────
  String name = '';
  String email = '';
  String message = '';

  // ── Validation errors (null = valid) ──────────────────────────────────────
  final nameError = ValueNotifier<String?>(null);
  final emailError = ValueNotifier<String?>(null);
  final messageError = ValueNotifier<String?>(null);

  // ── Submit status ─────────────────────────────────────────────────────────
  FormStatus _status = FormStatus.idle;
  FormStatus get status => _status;

  // ── Validation ────────────────────────────────────────────────────────────

  bool _validateName() {
    if (name.trim().isEmpty) {
      nameError.value = 'nameRequired';
      return false;
    }
    nameError.value = null;
    return true;
  }

  bool _validateEmail() {
    final re = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!re.hasMatch(email.trim())) {
      emailError.value = 'emailInvalid';
      return false;
    }
    emailError.value = null;
    return true;
  }

  bool _validateMessage() {
    if (message.trim().isEmpty) {
      messageError.value = 'messageRequired';
      return false;
    }
    if (message.trim().length > 2000) {
      messageError.value = 'messageTooLong';
      return false;
    }
    messageError.value = null;
    return true;
  }

  bool _validateAll() =>
      _validateName() & _validateEmail() & _validateMessage();

  // ── Submit ────────────────────────────────────────────────────────────────

  Future<void> submit(String locale) async {
    if (!_validateAll()) return;
    if (_status == FormStatus.sending) return;

    _status = FormStatus.sending;
    notifyListeners();

    try {
      await _repository.send(
        ContactMessageModel(
          name: name.trim(),
          email: email.trim(),
          message: message.trim(),
          locale: locale,
        ),
      );
      _status = FormStatus.success;
    } catch (e, st) {
      logError('ContactViewModel.submit error', error: e, stackTrace: st);
      _status = FormStatus.error;
    }
    notifyListeners();
  }

  void reset() {
    name = '';
    email = '';
    message = '';
    nameError.value = null;
    emailError.value = null;
    messageError.value = null;
    _status = FormStatus.idle;
    notifyListeners();
  }

  @override
  void dispose() {
    nameError.dispose();
    emailError.dispose();
    messageError.dispose();
    super.dispose();
  }
}
