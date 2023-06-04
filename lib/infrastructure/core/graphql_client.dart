import 'package:graphql/client.dart';

GraphQLClient getPokeApiGraphQLClient() {
  final httpLink = HttpLink(
    'https://beta.pokeapi.co/graphql/v1beta',
  );

  Link link = httpLink;

  final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );

  return client;
}
