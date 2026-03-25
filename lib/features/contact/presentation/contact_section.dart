import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_breakpoints.dart';
import '../../../core/widgets/animated_fade_slide.dart';
import '../../../core/widgets/section_title.dart';
import '../../../l10n/app_localizations.dart';
import 'contact_view_model.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _visible = false;
  bool _triggered = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_triggered || info.visibleFraction < 0.1) return;
    _triggered = true;
    setState(() => _visible = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return VisibilityDetector(
      key: const Key('contact-section'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.isMobile ? 24 : 80,
          vertical: 80,
        ),
        child: AnimatedFadeSlide(
          visible: _visible,
          child: context.isMobile
              ? _MobileLayout(l10n: l10n)
              : _DesktopLayout(l10n: l10n),
        ),
      ),
    );
  }
}

// ── Desktop: title on left, form on right ────────────────────────────────────

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: l10n.contactTitle),
              const SizedBox(height: 16),
              Text(
                l10n.contactSubtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(160),
                      height: 1.7,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 80),
        const Expanded(flex: 6, child: _ContactForm()),
      ],
    );
  }
}

// ── Mobile: stacked ───────────────────────────────────────────────────────────

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.contactTitle),
        const SizedBox(height: 16),
        Text(
          l10n.contactSubtitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color:
                    Theme.of(context).colorScheme.onSurface.withAlpha(160),
                height: 1.7,
              ),
        ),
        const SizedBox(height: 40),
        const _ContactForm(),
      ],
    );
  }
}

// ── Form ──────────────────────────────────────────────────────────────────────

class _ContactForm extends StatelessWidget {
  const _ContactForm();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ContactViewModel>();
    final l10n = AppLocalizations.of(context)!;

    if (vm.status == FormStatus.success) {
      return _SuccessState(l10n: l10n);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FormField(
          label: l10n.contactNameLabel,
          errorNotifier: vm.nameError,
          errorText: (k) => k == 'nameRequired' ? l10n.contactNameRequired : null,
          onChanged: (v) => vm.name = v,
          enabled: vm.status != FormStatus.sending,
        ),
        const SizedBox(height: 20),
        _FormField(
          label: l10n.contactEmailLabel,
          errorNotifier: vm.emailError,
          errorText: (k) =>
              k == 'emailInvalid' ? l10n.contactEmailInvalid : null,
          onChanged: (v) => vm.email = v,
          keyboardType: TextInputType.emailAddress,
          enabled: vm.status != FormStatus.sending,
        ),
        const SizedBox(height: 20),
        _FormField(
          label: l10n.contactMessageLabel,
          errorNotifier: vm.messageError,
          errorText: (k) => switch (k) {
            'messageRequired' => l10n.contactMessageRequired,
            'messageTooLong' => l10n.contactMessageTooLong,
            _ => null,
          },
          onChanged: (v) => vm.message = v,
          maxLines: 5,
          enabled: vm.status != FormStatus.sending,
        ),
        const SizedBox(height: 32),
        if (vm.status == FormStatus.error)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              l10n.contactError,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 13,
              ),
            ),
          ),
        _SubmitButton(vm: vm, l10n: l10n),
      ],
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.label,
    required this.errorNotifier,
    required this.errorText,
    required this.onChanged,
    this.maxLines = 1,
    this.keyboardType,
    this.enabled = true,
  });

  final String label;
  final ValueNotifier<String?> errorNotifier;
  final String? Function(String key) errorText;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final TextInputType? keyboardType;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: errorNotifier,
      builder: (context, errorKey, _) {
        final resolvedError =
            errorKey != null ? errorText(errorKey) : null;
        return TextField(
          onChanged: onChanged,
          maxLines: maxLines,
          keyboardType: keyboardType,
          enabled: enabled,
          decoration: InputDecoration(
            labelText: label,
            errorText: resolvedError,
            labelStyle: TextStyle(
              color:
                  Theme.of(context).colorScheme.onSurface.withAlpha(140),
              fontSize: 14,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withAlpha(60),
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.accent, width: 1.5),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1.5,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatefulWidget {
  const _SubmitButton({required this.vm, required this.l10n});
  final ContactViewModel vm;
  final AppLocalizations l10n;

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isSending = widget.vm.status == FormStatus.sending;
    final label =
        isSending ? widget.l10n.contactSending : widget.l10n.contactSendButton;
    final locale = Localizations.localeOf(context).languageCode;

    return Semantics(
      label: isSending ? widget.l10n.contactSending : widget.l10n.contactSendButton,
      button: true,
      enabled: !isSending,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSending
                ? AppColors.accent.withAlpha(120)
                : _hovered
                    ? AppColors.accent
                    : Colors.transparent,
            border: Border.all(
              color: isSending
                  ? AppColors.accent.withAlpha(120)
                  : AppColors.accent,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextButton(
            onPressed:
                isSending ? null : () => widget.vm.submit(locale),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              foregroundColor:
                  _hovered || isSending ? Colors.white : AppColors.accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: isSending
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                          color: _hovered ? Colors.white : AppColors.accent,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  const _SuccessState({required this.l10n});
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: Column(
        key: const ValueKey('success'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline,
              color: AppColors.accent, size: 40),
          const SizedBox(height: 16),
          Text(
            l10n.contactSuccess,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
