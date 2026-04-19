import 'package:graphql_flutter/graphql_flutter.dart';

const String defaultApiUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://localhost:4000/graphql',
);

GraphQLClient buildGraphQLClient({required String? Function() tokenReader}) {
  final httpLink = HttpLink(defaultApiUrl);
  final authLink = AuthLink(getToken: () {
    final t = tokenReader();
    return t == null ? null : 'Bearer $t';
  });
  final link = authLink.concat(httpLink);
  return GraphQLClient(
    cache: GraphQLCache(),
    link: link,
    defaultPolicies: DefaultPolicies(
      query: Policies(
        fetch: FetchPolicy.cacheAndNetwork,
        cacheReread: CacheRereadPolicy.mergeOptimistic,
      ),
    ),
  );
}
