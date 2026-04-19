import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gql/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../auth/auth_controller.dart';
import '../graphql/operations/chores.graphql.dart';
import '../graphql/operations/fragments.graphql.dart';
import '../graphql/operations/queries.graphql.dart';
import '../graphql/schema.graphql.dart';
import '../widgets/error_box.dart';

class ChoreDetailScreen extends ConsumerStatefulWidget {
  const ChoreDetailScreen({super.key, required this.assignmentId});
  final String assignmentId;

  @override
  ConsumerState<ChoreDetailScreen> createState() => _ChoreDetailScreenState();
}

class _ChoreDetailScreenState extends ConsumerState<ChoreDetailScreen> {
  bool _busy = false;
  String? _error;

  static final _df = DateFormat.yMMMd().add_jm();

  Future<void> _runMutation({
    required DocumentNode document,
    required Map<String, dynamic> variables,
  }) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final result = await ref.read(graphqlClientProvider).mutate(MutationOptions(
          document: document,
          variables: variables,
        ));
    if (!mounted) return;
    if (result.hasException) {
      setState(() {
        _busy = false;
        _error = prettifyError(result.exception!);
      });
      return;
    }
    await ref.read(authControllerProvider.notifier).refreshMe();
    if (!mounted) return;
    context.pop();
  }

  Future<void> _reject(Fragment$AssignmentFields a) async {
    final reason = await showDialog<String>(
      context: context,
      builder: (_) {
        final ctrl = TextEditingController();
        return AlertDialog(
          title: const Text('Send back?'),
          content: TextField(
            controller: ctrl,
            decoration: const InputDecoration(
              hintText: 'Why? (optional)',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () => Navigator.pop(context, ctrl.text),
              child: const Text('Send back'),
            ),
          ],
        );
      },
    );
    if (reason == null) return;
    await _runMutation(
      document: documentNodeMutationRejectChore,
      variables: Variables$Mutation$RejectChore(
        assignmentId: widget.assignmentId,
        reason: reason.trim().isEmpty ? null : reason.trim(),
      ).toJson(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Chore')),
      body: Query(
        options: QueryOptions(
          document: documentNodeQueryAssignments,
          fetchPolicy: FetchPolicy.cacheAndNetwork,
        ),
        builder: (result, {refetch, fetchMore}) {
          if (result.isLoading && result.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (result.hasException) {
            return Center(child: Text(result.exception!.toString()));
          }
          final parsed = Query$Assignments.fromJson(result.data!);
          final a = parsed.assignments.where((x) => x.id == widget.assignmentId).firstOrNull;
          if (a == null) {
            return const Center(child: Text('Assignment not found'));
          }
          final isMine = a.assignedTo.id == auth.me?.id;
          final canSubmit = isMine &&
              (a.status == Enum$ChoreStatus.pending ||
                  a.status == Enum$ChoreStatus.rejected);
          final canApprove = auth.isAdult && a.status == Enum$ChoreStatus.submitted;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (_error != null) ErrorBox(_error!),
              Text(a.chore.title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 4),
              if (a.chore.description != null && a.chore.description!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(a.chore.description!),
                ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text('${a.chore.tokenValue} 🪙')),
                  Chip(label: Text('Assigned to ${a.assignedTo.name}')),
                  Chip(label: Text(a.status.name)),
                  if (a.dueDate != null)
                    Chip(label: Text('Due ${_df.format(a.dueDate!.toLocal())}')),
                ],
              ),
              if (a.rejectReason != null && a.rejectReason!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Card(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: ListTile(
                    leading: const Icon(Icons.feedback_outlined),
                    title: const Text('Sent back'),
                    subtitle: Text(a.rejectReason!),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              if (canSubmit)
                FilledButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _runMutation(
                            document: documentNodeMutationSubmitChore,
                            variables: Variables$Mutation$SubmitChore(
                              assignmentId: widget.assignmentId,
                            ).toJson(),
                          ),
                  icon: const Icon(Icons.check),
                  label: const Text("I did it!"),
                ),
              if (canApprove) ...[
                FilledButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _runMutation(
                            document: documentNodeMutationApproveChore,
                            variables: Variables$Mutation$ApproveChore(
                              assignmentId: widget.assignmentId,
                            ).toJson(),
                          ),
                  icon: const Icon(Icons.thumb_up_outlined),
                  label: Text('Approve · +${a.chore.tokenValue} 🪙'),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: _busy ? null : () => _reject(a),
                  icon: const Icon(Icons.thumb_down_outlined),
                  label: const Text('Send back'),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
