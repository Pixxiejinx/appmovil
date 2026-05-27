import 'package:flu_app/config/config.dart';
import 'package:flu_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonScreen extends ConsumerWidget {
  final String pokemon_id;
  const PokemonScreen({super.key, required this.pokemon_id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonAsync = ref.watch(pokemonProvider(pokemon_id));
    return pokemonAsync.when(
      data: (pokemon) => _PokemonVisum(pokemon: pokemon), 
      error: (error, stackTrace) => _ErrorWidget(nuntius: error.toString()), 
      loading: () => const _LoadingWidget()
    );
  }
}

class _PokemonVisum extends ConsumerWidget {
  final Pokemon pokemon;

  const _PokemonVisum({
    required this.pokemon
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capturados = ref.watch(capturedPokemonsProvider);
    final bool estaAtrapado = capturados.containsKey(pokemon.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.nomen),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("Sus habilidades y tipos:", style: GoogleFonts.russoOne(fontSize: 20)),
            Text(
              pokemon.facultates.join(', '), 
              style: GoogleFonts.russoOne(fontSize: 22, color: Colors.pink.shade900),
            ),
            
            Container(
              padding: const EdgeInsets.all(10),
              decoration: estaAtrapado ? BoxDecoration(
                border: Border.all(color: Colors.pinkAccent, width: 4),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4)
                  )
                ]
              ) : null,
              child: Image.network(
                pokemon.faciemImaginem ?? '',
                fit: BoxFit.contain,
                width: 300,
                height: 300,
              ),
            ),
            
            Text(
              'Mide ${pokemon.altitudo/10}m. y pesa ${pokemon.pondus/10}kg.',
              style: GoogleFonts.russoOne(fontSize: 22),
            )
          ],
        ),
      ),
      
      floatingActionButton: SizedBox(
  height: 40,  
  width: 150,
  child: FloatingActionButton.extended(
    extendedPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
    backgroundColor: estaAtrapado ? Colors.green.shade400 : Colors.pink.shade200,
    onPressed: () {
      ref.read(capturedPokemonsProvider.notifier).toggleCaptura(pokemon.id, pokemon.facultates);
    },
    icon: Icon(
      estaAtrapado ? Icons.star : Icons.catching_pokemon, 
      color: Colors.white,
      size: 18, 
    ),
    label: Text(
      estaAtrapado ? '¡EN POKÉDEX! ✨' : 'CAPTURAR 🔴', 
      style: const TextStyle(
        color: Colors.white, 
        fontWeight: FontWeight.bold,
        fontSize: 12, 
              ),
           ),
        ),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String nuntius;
  const _ErrorWidget({
    required this.nuntius
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error: $nuntius'),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}