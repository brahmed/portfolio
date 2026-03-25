import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/features/contact/data/contact_message_model.dart';
import 'package:portfolio/features/contact/domain/contact_repository_interface.dart';
import 'package:portfolio/features/contact/presentation/contact_view_model.dart';

// ── Stubs ────────────────────────────────────────────────────────────────────

class _SuccessRepo implements ContactRepositoryInterface {
  ContactMessageModel? lastMessage;

  @override
  Future<void> send(ContactMessageModel message) async {
    lastMessage = message;
  }
}

class _FailingRepo implements ContactRepositoryInterface {
  @override
  Future<void> send(ContactMessageModel message) async =>
      throw Exception('network error');
}

// ── Helpers ──────────────────────────────────────────────────────────────────

ContactViewModel _makeVm({ContactRepositoryInterface? repo}) =>
    ContactViewModel(repository: repo ?? _SuccessRepo());

void _fillValid(ContactViewModel vm) {
  vm.name = 'Amine Brahmi';
  vm.email = 'test@example.com';
  vm.message = 'Hello from test';
}

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  group('ContactViewModel — initial state', () {
    test('starts idle with no errors', () {
      final vm = _makeVm();
      expect(vm.status, FormStatus.idle);
      expect(vm.nameError.value, isNull);
      expect(vm.emailError.value, isNull);
      expect(vm.messageError.value, isNull);
    });
  });

  group('ContactViewModel — validation', () {
    test('empty name sets nameError', () async {
      final vm = _makeVm();
      vm.email = 'a@b.com';
      vm.message = 'hi';
      await vm.submit('en');
      expect(vm.nameError.value, 'nameRequired');
      expect(vm.status, FormStatus.idle); // did not send
    });

    test('invalid email sets emailError', () async {
      final vm = _makeVm();
      vm.name = 'Amine';
      vm.email = 'not-an-email';
      vm.message = 'hi';
      await vm.submit('en');
      expect(vm.emailError.value, 'emailInvalid');
      expect(vm.status, FormStatus.idle);
    });

    test('empty message sets messageError', () async {
      final vm = _makeVm();
      vm.name = 'Amine';
      vm.email = 'a@b.com';
      await vm.submit('en');
      expect(vm.messageError.value, 'messageRequired');
      expect(vm.status, FormStatus.idle);
    });

    test('message over 2000 chars sets messageTooLong', () async {
      final vm = _makeVm();
      vm.name = 'Amine';
      vm.email = 'a@b.com';
      vm.message = 'x' * 2001;
      await vm.submit('en');
      expect(vm.messageError.value, 'messageTooLong');
      expect(vm.status, FormStatus.idle);
    });

    test('valid inputs clear all errors', () async {
      final vm = _makeVm();
      // First cause errors
      await vm.submit('en');
      expect(vm.nameError.value, isNotNull);
      // Then fix and resubmit
      _fillValid(vm);
      await vm.submit('en');
      expect(vm.nameError.value, isNull);
      expect(vm.emailError.value, isNull);
      expect(vm.messageError.value, isNull);
    });
  });

  group('ContactViewModel — successful submit', () {
    test('transitions to success and sends correct data', () async {
      final repo = _SuccessRepo();
      final vm = _makeVm(repo: repo);
      _fillValid(vm);
      await vm.submit('fr');

      expect(vm.status, FormStatus.success);
      expect(repo.lastMessage?.name, 'Amine Brahmi');
      expect(repo.lastMessage?.email, 'test@example.com');
      expect(repo.lastMessage?.message, 'Hello from test');
      expect(repo.lastMessage?.locale, 'fr');
    });

    test('trims whitespace before sending', () async {
      final repo = _SuccessRepo();
      final vm = _makeVm(repo: repo);
      vm.name = '  Amine  ';
      vm.email = '  test@example.com  ';
      vm.message = '  Hello  ';
      await vm.submit('en');

      expect(repo.lastMessage?.name, 'Amine');
      expect(repo.lastMessage?.email, 'test@example.com');
      expect(repo.lastMessage?.message, 'Hello');
    });
  });

  group('ContactViewModel — failed submit', () {
    test('transitions to error on repository failure', () async {
      final vm = _makeVm(repo: _FailingRepo());
      _fillValid(vm);
      await vm.submit('en');
      expect(vm.status, FormStatus.error);
    });
  });

  group('ContactViewModel — reset', () {
    test('clears all state after success', () async {
      final vm = _makeVm();
      _fillValid(vm);
      await vm.submit('en');
      expect(vm.status, FormStatus.success);

      vm.reset();
      expect(vm.status, FormStatus.idle);
      expect(vm.name, '');
      expect(vm.email, '');
      expect(vm.message, '');
      expect(vm.nameError.value, isNull);
    });
  });
}
