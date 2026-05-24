import 'package:flu_app/config/config.dart';
import 'package:flu_app/services/pokemon_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokemonProvider = FutureProvider.family<Pokemon, String>((ref, id) async {
   final (pokemon, error) = await PokemonService.getPokemon(id);

   if (pokemon!= null) return pokemon;

   throw Exception(error);
});