String readPokemons =
"""
  query {
    pokemons(first: 150) {
      name
    }
  }
""".replaceAll('\n', ' ');