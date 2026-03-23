import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:scavium_wallet/app/router/route_names.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_backup_controller.dart';
import 'package:scavium_wallet/shared/widgets/feedback/app_snackbar.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';

class RestoreBackupScreen extends ConsumerStatefulWidget {
  const RestoreBackupScreen({super.key});

  @override
  ConsumerState<RestoreBackupScreen> createState() =>
      _RestoreBackupScreenState();
}

class _RestoreBackupScreenState extends ConsumerState<RestoreBackupScreen> {
  final _passwordController = TextEditingController();

  bool _loading = false;
  String? _error;
  String? _selectedFileName;
  String? _rawBackup;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _pickBackupFile() async {
    setState(() {
      _error = null;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['scwb', 'json'],
        allowMultiple: false,
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final file = result.files.single;

      String raw;

      if (file.bytes != null) {
        raw = utf8.decode(file.bytes!);
      } else if (!kIsWeb && file.path != null) {
        raw = await File(file.path!).readAsString();
      } else {
        throw Exception('Unable to read selected backup file');
      }

      setState(() {
        _rawBackup = raw;
        _selectedFileName = file.name;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  Future<void> _restore() async {
    final password = _passwordController.text.trim();

    if (_rawBackup == null || _rawBackup!.trim().isEmpty) {
      setState(() {
        _error = 'Please select a backup file first';
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _error = 'Backup password is required';
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final controller = ref.read(walletBackupControllerProvider);

      await controller.restoreEncryptedBackup(
        rawBackup: _rawBackup!,
        password: password,
      );

      if (!mounted) return;

      AppSnackbar.showInfo(context, 'Wallet restored successfully');

      context.go(RouteNames.home);
    } catch (e) {
      setState(() {
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Restore Backup')),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Restore a wallet from an encrypted backup file.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          const Text(
            'Important:',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text('- You need both the backup file and its password.'),
          const SizedBox(height: 4),
          const Text(
            '- If the file is invalid or the password is incorrect, the wallet cannot be restored.',
          ),
          const SizedBox(height: 4),
          const Text(
            '- This will restore the wallet into secure local storage on this device.',
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: _loading ? null : _pickBackupFile,
            icon: const Icon(Icons.upload_file_outlined),
            label: Text(
              _selectedFileName == null
                  ? 'Select backup file'
                  : 'Selected: $_selectedFileName',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Backup password'),
          ),
          const SizedBox(height: 20),
          if (_error != null) ...[
            Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
          ],
          ElevatedButton(
            onPressed: _loading ? null : _restore,
            child:
                _loading
                    ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Text('Restore wallet'),
          ),
        ],
      ),
    );
  }
}
