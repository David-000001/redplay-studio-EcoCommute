import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/auth_repository.dart';

enum _AuthMode { signIn, register, reset }

/// UI routes are deliberately not the security boundary. Firestore rules
/// enforce the actual vendor/admin permissions.
class AuthScreen extends StatefulWidget {
  const AuthScreen({required this.repository, super.key});
  final AuthRepository repository;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  _AuthMode _mode = _AuthMode.signIn;
  bool _busy = false;
  String? _feedback;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  String _friendlyError(Object error) {
    if (error is FirebaseAuthException) {
      return switch (error.code) {
        'invalid-email' => 'Enter a valid email address.',
        'email-already-in-use' => 'An account with this email already exists.',
        'weak-password' => 'Please use a stronger password.',
        'invalid-credential' || 'wrong-password' || 'user-not-found' =>
          'Unable to sign in. Check your email and password.',
        'too-many-requests' => 'Too many attempts. Try again later.',
        _ => 'Authentication failed. Please try again.',
      };
    }
    return 'Action failed. Check your connection and permissions.';
  }

  Future<void> _run(Future<void> Function() action, {String? success}) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _feedback = null;
    });
    try {
      await action();
      if (!mounted) return;
      setState(() => _feedback = success);
    } catch (error) {
      if (!mounted) return;
      setState(() => _feedback = _friendlyError(error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _select(_AuthMode mode) {
    setState(() {
      _mode = mode;
      _feedback = null;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    switch (_mode) {
      case _AuthMode.signIn:
        await _run(() => widget.repository.signIn(
              email: _email.text,
              password: _password.text,
            ));
      case _AuthMode.register:
        await _run(() => widget.repository.registerStudent(
              displayName: _name.text,
              email: _email.text,
              password: _password.text,
            ));
      case _AuthMode.reset:
        await _run(
          () => widget.repository.sendPasswordReset(_email.text),
          success: 'If the account exists, a reset email has been requested.',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.repository.isConfigured) {
      return Scaffold(
        appBar: AppBar(title: const Text('Authentication & Roles')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Firebase not configured. Connect your own Firebase project '
              'and enable Email/Password sign-in before testing real accounts. '
              'See docs/firebase-setup.md.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Authentication & Roles')),
      body: StreamBuilder<AuthIdentity?>(
        stream: widget.repository.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load authentication state.'));
          }
          if (!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final identity = snapshot.data;
          return identity == null ? _signInBody() : _signedInBody(identity);
        },
      ),
    );
  }

  Widget _signInBody() => SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                switch (_mode) {
                  _AuthMode.signIn => 'Welcome back',
                  _AuthMode.register => 'Create a student account',
                  _AuthMode.reset => 'Reset your password',
                },
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              if (_mode == _AuthMode.register) ...[
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Display name'),
                  validator: (value) =>
                      value == null || value.trim().isEmpty || value.trim().length > 80
                          ? 'Enter a name (1–80 characters).'
                          : null,
                ),
                const SizedBox(height: 8),
              ],
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value == null || !value.contains('@')
                        ? 'Enter an email address.'
                        : null,
              ),
              if (_mode != _AuthMode.reset) ...[
                const SizedBox(height: 8),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) =>
                      value == null || value.length < 6
                          ? 'Enter at least 6 characters.'
                          : null,
                ),
              ],
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _busy ? null : _submit,
                child: Text(switch (_mode) {
                  _AuthMode.signIn => 'Sign in',
                  _AuthMode.register => 'Register',
                  _AuthMode.reset => 'Send reset email',
                }),
              ),
              if (_busy) const LinearProgressIndicator(),
              if (_feedback != null) Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(_feedback!),
              ),
              if (_mode != _AuthMode.signIn)
                TextButton(
                  onPressed: _busy ? null : () => _select(_AuthMode.signIn),
                  child: const Text('Back to sign in'),
                ),
              if (_mode == _AuthMode.signIn) ...[
                TextButton(
                  onPressed: _busy ? null : () => _select(_AuthMode.register),
                  child: const Text('Create account'),
                ),
                TextButton(
                  onPressed: _busy ? null : () => _select(_AuthMode.reset),
                  child: const Text('Forgot password?'),
                ),
              ],
              const SizedBox(height: 12),
              const Text(
                'New accounts are students. Vendor access requires separate '
                'administrator approval. Administrator accounts cannot self-register.',
              ),
            ],
          ),
        ),
      );

  Widget _signedInBody(AuthIdentity identity) => StreamBuilder<UserProfile?>(
        stream: widget.repository.watchProfile(identity.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Unable to load profile. Check Firestore permissions.'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final profile = snapshot.data;
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text('Signed in', style: Theme.of(context).textTheme.headlineSmall),
              Text(identity.email),
              const SizedBox(height: 16),
              if (profile == null)
                const Text('Profile unavailable. Contact an administrator; '
                    'no role privileges are granted without a profile.')
              else ...[
                Text('Name: ${profile.displayName}'),
                Text('Role: ${profile.role.name}'),
                Text('Vendor approval: ${profile.vendorStatus.name}'),
                if (profile.role == FoodLoopRole.student &&
                    (profile.vendorStatus == VendorStatus.none ||
                        profile.vendorStatus == VendorStatus.rejected))
                  FilledButton(
                    onPressed: _busy
                        ? null
                        : () => _run(
                              () => widget.repository
                                  .requestVendorApproval(identity.uid),
                              success: 'Vendor approval requested.',
                            ),
                    child: const Text('Request vendor approval'),
                  ),
                if (profile.vendorStatus == VendorStatus.pending)
                  const Text('Vendor application pending admin review.'),
                if (profile.canReviewVendors)
                  _approvalList(),
              ],
              const SizedBox(height: 16),
              if (_feedback != null) Text(_feedback!),
              OutlinedButton(
                onPressed: _busy ? null : () => _run(widget.repository.signOut),
                child: const Text('Sign out'),
              ),
            ],
          );
        },
      );

  Widget _approvalList() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text('Pending vendor applications',
              style: Theme.of(context).textTheme.titleMedium),
          StreamBuilder<List<UserProfile>>(
            stream: widget.repository.pendingVendorRequests(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Unable to load pending vendors.');
              }
              if (!snapshot.hasData) return const LinearProgressIndicator();
              final pending = snapshot.data!;
              if (pending.isEmpty) return const Text('No pending applications.');
              return Column(
                children: [
                  for (final profile in pending)
                    ListTile(
                      title: Text(profile.displayName),
                      subtitle: Text('UID: ${profile.uid}'),
                      trailing: TextButton(
                        onPressed: _busy
                            ? null
                            : () => _run(
                                  () => widget.repository.approveVendor(profile.uid),
                                  success: 'Vendor approved.',
                                ),
                        child: const Text('Approve'),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      );
}
