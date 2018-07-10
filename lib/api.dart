import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokemon_flutter/queries/readPokemons.dart' as queries;

class Api {

  List getPokemons() {
    var _pokemons = List();

    new Query(
        queries.readPokemons,
        variables: {
        'nPokemons': 150
        },
        builder: ({
          bool loading,
          var data,
          String error,
        })

        {
          _pokemons = data['pokemons'];
        });
    return _pokemons;
  }

}