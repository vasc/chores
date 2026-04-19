import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../client/graphql_client.dart';
import '../graphql/operations/queries.graphql.dart';
import '../graphql/operations/fragments.graphql.dart';
import '../graphql/schema.graphql.dart';
import 'auth_storage.dart';
import 'household_storage.dart';

@immutable
class AuthState {
  const AuthState({this.token, this.me, this.loading = true});

  final String? token;
  final Fragment$UserFields? me;
  final bool loading;

  bool get isAuthed => token != null && me != null;
  bool get isAdult => me?.role == Enum$Role.adult;

  AuthState copyWith({String? token, Fragment$UserFields? me, bool? loading}) {
    return AuthState(
      token: token ?? this.token,
      me: me ?? this.me,
      loading: loading ?? this.loading,
    );
  }

  AuthState cleared() => const AuthState(loading: false);
}

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._ref) : super(const AuthState()) {
    _bootstrap();
  }

  final Ref _ref;

  GraphQLClient get _client => _ref.read(graphqlClientProvider);

  Future<void> _bootstrap() async {
    final stored = await AuthStorage.instance.read();
    if (stored == null) {
      state = state.cleared();
      return;
    }
    state = state.copyWith(token: stored);
    await refreshMe();
  }

  Future<void> refreshMe() async {
    final result = await _client.query(QueryOptions(
      document: documentNodeQueryMe,
      fetchPolicy: FetchPolicy.networkOnly,
    ));
    if (result.hasException || result.data == null) {
      await logout();
      return;
    }
    final parsed = Query$Me.fromJson(result.data!);
    if (parsed.me == null) {
      await logout();
      return;
    }
    state = AuthState(token: state.token, me: parsed.me, loading: false);
  }

  Future<void> setSession(String token, Fragment$UserFields user) async {
    await AuthStorage.instance.write(token);
    await HouseholdStorage.instance.write(user.householdId);
    state = AuthState(token: token, me: user, loading: false);
  }

  Future<void> logout() async {
    await AuthStorage.instance.clear();
    state = const AuthState(loading: false);
    _client.cache.store.reset();
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref);
});

final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  return buildGraphQLClient(
    tokenReader: () => ref.read(authControllerProvider).token,
  );
});

final graphqlClientNotifierProvider = Provider<ValueNotifier<GraphQLClient>>(
  (ref) => ValueNotifier(ref.watch(graphqlClientProvider)),
);
