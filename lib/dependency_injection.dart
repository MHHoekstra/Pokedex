import 'package:get_it/get_it.dart';
import 'package:pokedex/application/pokedex/interactors/get_pokemon_list_interactor.dart';
import 'package:pokedex/domain/pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex/infrastructure/core/graphql_client.dart';
import 'package:pokedex/infrastructure/pokedex/repositories/graphql_pokemon_repository.dart';

void configureDependencyInjection() {
  final instance = GetIt.instance;

  //Clients
  instance.registerLazySingleton(() => getPokeApiGraphQLClient());

  //Repositories
  instance.registerLazySingleton<PokemonRepository>(
    () => GraphQLPokemonRepository(
      instance(),
    ),
  );

  //Interactors
  instance.registerLazySingleton(() => GetPokemonListInteractor(instance()));
}
