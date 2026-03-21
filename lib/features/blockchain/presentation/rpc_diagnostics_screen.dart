import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scavium_wallet/features/blockchain/application/rpc_status_controller.dart';
import 'package:scavium_wallet/shared/widgets/scavium_scaffold.dart';
import 'package:scavium_wallet/shared/widgets/section_title.dart';

class RpcDiagnosticsScreen extends ConsumerStatefulWidget {
  const RpcDiagnosticsScreen({super.key});

  @override
  ConsumerState<RpcDiagnosticsScreen> createState() =>
      _RpcDiagnosticsScreenState();
}

class _RpcDiagnosticsScreenState extends ConsumerState<RpcDiagnosticsScreen> {
  int? _checkingIndex;
  bool? _activePingOk;
  String? _message;

  Future<void> _refresh() async {
    setState(() {
      _message = null;
    });

    await ref.read(rpcStatusControllerProvider.notifier).refreshStatus();

    if (!mounted) return;
    setState(() {});
  }

  Future<void> _pingActive() async {
    setState(() {
      _message = null;
      _activePingOk = null;
    });

    final ok =
        await ref.read(rpcStatusControllerProvider.notifier).pingActiveRpc();

    if (!mounted) return;

    setState(() {
      _activePingOk = ok;
      _message =
          ok
              ? 'El nodo activo respondió correctamente.'
              : 'El nodo activo no respondió.';
    });
  }

  Future<void> _selectRpc(int index) async {
    setState(() {
      _message = null;
      _checkingIndex = index;
    });

    await ref.read(rpcStatusControllerProvider.notifier).selectRpc(index);

    if (!mounted) return;

    setState(() {
      _checkingIndex = null;
      _message = 'Nodo RPC activo actualizado.';
    });
  }

  Future<void> _pingRpc(int index) async {
    setState(() {
      _message = null;
      _checkingIndex = index;
    });

    final ok = await ref
        .read(rpcStatusControllerProvider.notifier)
        .pingRpc(index);

    if (!mounted) return;

    setState(() {
      _checkingIndex = null;
      _message =
          ok
              ? 'RPC ${index + 1} respondió correctamente.'
              : 'RPC ${index + 1} no respondió.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final rpcStatusState = ref.watch(rpcStatusControllerProvider);

    return ScaviumScaffold(
      appBar: AppBar(title: const Text('RPC Diagnostics')),
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SectionTitle(
            title: 'RPC diagnostics',
            subtitle: 'Inspect and control the currently active RPC endpoint.',
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _refresh,
                  child: const Text('Refresh'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: _pingActive,
                  child: const Text('Ping active'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_activePingOk != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _activePingOk == true
                      ? 'Active RPC: OK'
                      : 'Active RPC: no response',
                ),
              ),
            ),
          if (_message != null) ...[
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_message!),
              ),
            ),
          ],
          const SizedBox(height: 20),
          rpcStatusState.when(
            data: (status) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Active index: ${status.activeIndex}'),
                          const SizedBox(height: 8),
                          SelectableText('Active RPC: ${status.activeRpcUrl}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(status.rpcUrls.length, (index) {
                    final rpcUrl = status.rpcUrls[index];
                    final isActive = index == status.activeIndex;
                    final isBusy = _checkingIndex == index;

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isActive
                                  ? 'RPC ${index + 1} (active)'
                                  : 'RPC ${index + 1}',
                            ),
                            const SizedBox(height: 8),
                            SelectableText(rpcUrl),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed:
                                        isBusy ? null : () => _pingRpc(index),
                                    child: Text(
                                      isBusy ? 'Checking...' : 'Ping',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed:
                                        isBusy || isActive
                                            ? null
                                            : () => _selectRpc(index),
                                    child: Text(
                                      isActive ? 'Active' : 'Set active',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Error loading RPC status: $error'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
