import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokemon_flutter/queries/readPokemons.dart' as queries;
import 'package:pokemon_flutter/models/pokemon.dart';

void main() async {
  client = new Client(
      endPoint: "https://graphql-pokemon.now.sh",
      cache: new InMemoryCache()
  );

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: new ThemeData(
        primaryColor: Colors.red,
      ),
      home: new PokemonList()
    );
  }
}

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => new _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: new AppBar(
          title: new Text("Pokedex"),
        ),
        body: _buildPokemonList(),
      );
  }

  Widget _buildPokemonList() =>
    new Query(
        queries.readPokemons,
        variables: {
          'nPokemons': 150
        },
        builder: ({
          bool loading,
          var data,
          String error,
        }) {
          if (error != '') {
            return new Text(error);
          }

          if (loading) {
            return new Text('Loading');
          }

          List _pokemons = data['pokemons'];

          return new ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: _pokemons.length,
            itemBuilder: (context, index) {
              if (index.isOdd){
                return Divider();
              }

              final pokemon = _pokemons[index];

              return _buildRow(Pokemon(name: pokemon['name']));
            },
          );
        });

  Widget _buildRow(Pokemon pokemon) {
    return ListTile(
      title: new Text(
        pokemon.name
      ),
    );
  }

}
