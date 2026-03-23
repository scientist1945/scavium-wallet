import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scavium_wallet/features/wallet/application/wallet_backup_controller.dart';
import 'package:scavium_wallet/features/wallet/data/wallet_repository_impl.dart';
import 'package:scavium_wallet/shared/widgets/feedback/app_snackbar.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:share_plus/share_plus.dart';

class ExportBackupScreen extends ConsumerStatefulWidget {
  const ExportBackupScreen({super.key});

  @override
  ConsumerState<ExportBackupScreen> createState() => _ExportBackupScreenState();
}

class _ExportBackupScreenState extends ConsumerState<ExportBackupScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _export() async {
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (password.isEmpty) {
      setState(() => _error = 'Password is required');
      return;
    }

    if (password.length < 8) {
      setState(() => _error = 'Password must be at least 8 characters');
      return;
    }

    if (password != confirm) {
      setState(() => _error = 'Passwords do not match');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final controller = ref.read(walletBackupControllerProvider);
      final repository = ref.read(walletRepositoryProvider);

      final profile = await repository.loadWalletProfile();
      if (profile == null) {
        throw Exception('No wallet available to export');
      }

      final backupJson = await controller.exportEncryptedBackup(
        password: password,
      );

      final fileName = controller.buildDefaultBackupFileName(
        address: profile.account.address,
        network: 'testnet', // ← ajustar si luego tenés config dinámica
      );
      if (_isDesktopPlatform) {
        final savePath = await _pickBackupSavePath(fileName);

        if (savePath == null || savePath.trim().isEmpty) {
          if (mounted) {
            AppSnackbar.showInfo(context, 'Backup export cancelled');
          }
          return;
        }

        final file = File(savePath);
        await file.writeAsString(backupJson);

        if (mounted) {
          AppSnackbar.showInfo(context, 'Encrypted backup saved successfully');
        }
        return;
      }

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsString(backupJson);

      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'SCAVIUM Wallet encrypted backup');

      if (mounted) {
        AppSnackbar.showInfo(
          context,
          'Encrypted backup generated successfully',
        );
      }
    } catch (e) {
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<String?> _pickBackupSavePath(String suggestedName) async {
    if (!_isDesktopPlatform) {
      return null;
    }

    final location = await getSaveLocation(
      suggestedName: suggestedName,
      acceptedTypeGroups: const [
        XTypeGroup(label: 'SCAVIUM Wallet Backup', extensions: ['scwb']),
      ],
    );

    return location?.path;
  }

  bool get _isDesktopPlatform {
    if (kIsWeb) {
      return false;
    }

    return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  }

  @override
  Widget build(BuildContext context) {
    return ScaviumScaffold(
      appBar: AppBar(title: const Text('Export Backup')),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Create an encrypted backup file of your wallet.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          const Text(
            'Important:',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            '- Anyone with this file and the password can access your wallet.',
          ),
          const SizedBox(height: 4),
          const Text(
            '- If you lose the file or the password, the backup cannot be recovered.',
          ),
          const SizedBox(height: 4),
          const Text(
            '- Do not store the password in the same place as the backup file.',
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Backup password'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _confirmController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm backup password',
            ),
          ),
          const SizedBox(height: 20),
          if (_error != null) ...[
            Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
          ],
          ElevatedButton(
            onPressed: _loading ? null : _export,
            child:
                _loading
                    ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Text('Export encrypted backup'),
          ),
        ],
      ),
    );
  }
}
