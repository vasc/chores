import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox(this.message, {super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        message,
        style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
      ),
    );
  }
}

String prettifyError(Object e) {
  if (e is OperationException) {
    if (e.graphqlErrors.isNotEmpty) {
      return e.graphqlErrors.map((g) => g.message).join('\n');
    }
    if (e.linkException != null) return e.linkException.toString();
  }
  final s = e.toString();
  if (s.startsWith('Exception: ')) return s.substring('Exception: '.length);
  return s;
}
