import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flu_app/presentation/providers/providers.dart'; 
import 'package:google_fonts/google_fonts.dart';

class NumeratorScreen extends ConsumerWidget {
  const NumeratorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capturados = ref.watch(capturedPokemonsProvider);
    
    int fuego = 0;
    int agua = 0;
    int plantaTierra = 0;
    int electrico = 0;
    int normal = 0;
    int volador = 0;
    int veneno = 0;
    int bicho = 0;
    int psiquico = 0;
    int fantasmaSiniestro = 0;
    int dragonHada = 0;
    int hielo = 0;
    int lucha = 0;
    int acero = 0;

    capturados.forEach((id, datosTipo) {
      final filtro = datosTipo.toLowerCase();

      if (filtro.contains('fire') || filtro.contains('blaze')) fuego++;
      
      if (filtro.contains('water') || filtro.contains('torrent')) agua++;
      
      if (filtro.contains('grass') || filtro.contains('ground') || filtro.contains('rock') || 
          filtro.contains('overgrow') || filtro.contains('chlorophyll')) {
        plantaTierra++;
      }
      
      if (filtro.contains('electric') || filtro.contains('static')) electrico++;
      
      if (filtro.contains('normal')) normal++;
      
      if (filtro.contains('flying')) volador++;
      
      if (filtro.contains('poison')) veneno++;
      
      if (filtro.contains('bug') || filtro.contains('swarm')) bicho++;
      
      if (filtro.contains('psychic')) psiquico++;
      
      if (filtro.contains('ghost') || filtro.contains('dark')) fantasmaSiniestro++;
      
      if (filtro.contains('dragon') || filtro.contains('fairy')) dragonHada++;
      
      if (filtro.contains('ice')) hielo++;
      
      if (filtro.contains('fighting')) lucha++;
      
      if (filtro.contains('steel')) acero++;
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC), 
      appBar: AppBar(
        title: Text('ESTADÍSTICAS POKÉDEX', style: GoogleFonts.russoOne()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.pink.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${capturados.length}', style: GoogleFonts.russoOne(fontSize: 36, color: Colors.pink)),
                    const SizedBox(width: 12),
                    Text('Pokémon Atrapados 👑', style: GoogleFonts.russoOne(fontSize: 16, color: Colors.black87)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.1, 
                children: [
                  _TipoCounterCard(titulo: 'Fuego 🔥', contador: fuego, color: Colors.orange.shade100, colorTexto: Colors.orange.shade900),
                  _TipoCounterCard(titulo: 'Agua 💧', contador: agua, color: Colors.blue.shade100, colorTexto: Colors.blue.shade900),
                  _TipoCounterCard(titulo: 'Planta/Tierra 🌿', contador: plantaTierra, color: Colors.green.shade100, colorTexto: Colors.green.shade900),
                  _TipoCounterCard(titulo: 'Eléctrico ⚡', contador: electrico, color: Colors.yellow.shade100, colorTexto: Colors.yellow.shade900),
                  _TipoCounterCard(titulo: 'Normal 🔘', contador: normal, color: Colors.grey.shade200, colorTexto: Colors.grey.shade800),
                  _TipoCounterCard(titulo: 'Volador 🍃', contador: volador, color: Colors.indigo.shade50, colorTexto: Colors.indigo.shade900),
                  _TipoCounterCard(titulo: 'Veneno 🔮', contador: veneno, color: Colors.purple.shade100, colorTexto: Colors.purple.shade900),
                  _TipoCounterCard(titulo: 'Bicho 🐛', contador: bicho, color: Colors.lightGreen.shade100, colorTexto: Colors.lightGreen.shade900),
                  _TipoCounterCard(titulo: 'Psíquico 🧠', contador: psiquico, color: Colors.pink.shade100, colorTexto: Colors.pink.shade900),
                  _TipoCounterCard(titulo: 'Fantasma/Oscuro 👻', contador: fantasmaSiniestro, color: Colors.deepPurple.shade100, colorTexto: Colors.deepPurple.shade900),
                  _TipoCounterCard(titulo: 'Mítico/Hada ✨', contador: dragonHada, color: Colors.teal.shade50, colorTexto: Colors.teal.shade900),
                  _TipoCounterCard(titulo: 'Hielo ❄️', contador: hielo, color: Colors.cyan.shade100, colorTexto: Colors.cyan.shade900),
                  _TipoCounterCard(titulo: 'Lucha 🥊', contador: lucha, color: Colors.red.shade100, colorTexto: Colors.red.shade900),
                  _TipoCounterCard(titulo: 'Acero ⚔️', contador: acero, color: Colors.blueGrey.shade100, colorTexto: Colors.blueGrey.shade900),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _TipoCounterCard extends StatelessWidget {
  final String titulo;
  final int contador;
  final Color color;
  final Color colorTexto;

  const _TipoCounterCard({
    required this.titulo, 
    required this.contador, 
    required this.color, 
    required this.colorTexto
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                titulo, 
                style: GoogleFonts.russoOne(color: colorTexto, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white.withOpacity(0.8),
              child: Text(
                '$contador', 
                style: TextStyle(fontWeight: FontWeight.bold, color: colorTexto, fontSize: 14)
              ),
            ),
          ],
        ),
      ),
    );
  }
}