import 'package:flu_app/config/helpers/coloris_forma.dart';
import 'package:flu_app/presentation/providers/providers.dart';
import 'package:flu_app/presentation/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class ChartaScreen extends ConsumerStatefulWidget {
  const ChartaScreen({super.key});

  @override
  ConsumerState<ChartaScreen> createState() => _ChartaScreenState();
}

class _ChartaScreenState extends ConsumerState<ChartaScreen> {
  CircleAnnotationManager? _circleAnnotationManager;
  Cancelable? _dragCancelable;

  void _initiareCircleAnnotations(MapboxMap mapboxMap) {
    mapboxMap.annotations.createCircleAnnotationManager().then((manager) {
      _circleAnnotationManager = manager;
      _setupDragListener(manager);
      _addeVelRenovareMarker();
    });
  }

  void _setupDragListener(CircleAnnotationManager manager) {
    _dragCancelable?.cancel();
    final socketService = ref.read(socketServiceProvider);

    _dragCancelable = manager.dragEvents(
      onChanged: (CircleAnnotation annotation) {
        final pos = annotation.geometry.coordinates;
        ref.read(coordsMarkerProvider.notifier).state = pos;
        socketService.mitterePositio(pos);
      },
      onEnd: (CircleAnnotation annotation) {
        final pos = annotation.geometry.coordinates;
        ref.read(coordsMarkerProvider.notifier).state = pos;
        socketService.mitterePositio(pos);
      }
    );
  }

  Future<void> _addeVelRenovareMarker() async {
    final manager = _circleAnnotationManager;
    if (manager == null) return;

    await manager.deleteAll();
    final placed = ref.read(markerPositumProvider);

    if (placed) {
      final situs = ref.read(coordsMarkerProvider);
      final color = ref.read(formColorProvider);

      final optiones = CircleAnnotationOptions(
        geometry: Point(coordinates: situs),
        circleColor: color.toARGB32(),
        circleRadius: 14,
        circleStrokeColor: Colors.white.toARGB32(),
        circleStrokeWidth: 3,
        isDraggable: true,
      );

      try {
        await manager.create(optiones);
      } catch (e) {
        debugPrint('Error al crear el marcador: $e');
      }
    }

    final aliiRudi = ref.read(aliiUsoresProvider).value ?? [];
    final meusId = ref.read(socketServiceProvider).meusSocketId;
    final alii = aliiRudi.where((u) => u.id != meusId).toList();

    for (final usor in alii) {
      final usorColor = adHexExColor(usor.colorHex);

      final aliaOptionen = CircleAnnotationOptions(
        geometry: Point(coordinates: usor.positio),
        circleColor: usorColor.toARGB32(),
        circleRadius: 12,
        circleStrokeColor: Colors.white.toARGB32(),
        circleStrokeWidth: 2,
        isDraggable: false,
      );

      try {
        await manager.create(aliaOptionen);
      } catch (e) {
        debugPrint('Error al crear el marcador: $e');
      }
    }
  }

  @override
  void dispose() {
    _dragCancelable?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(markerPositumProvider, (previous, next) {
      if (next == true) _addeVelRenovareMarker();
    });

    ref.listen(aliiUsoresProvider, (prev, next) {
      _addeVelRenovareMarker();
    });

    final totalCapturados = ref.watch(capturedPokemonsProvider).length;
    final markerPositum = ref.watch(markerPositumProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: Text('MAPA DE ENTRENADORES 🌐', style: GoogleFonts.russoOne(fontSize: 18)),
        backgroundColor: Colors.pink.shade400,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MapWidget(
            key: const ValueKey('main_mapa'),
            cameraOptions: CameraOptions(
              center: Point(coordinates: initialisMarkerPoistio),
              zoom: 14.5,
            ),
            styleUri: MapboxStyles.MAPBOX_STREETS,
            onMapCreated: _initiareCircleAnnotations,
          ),

          Positioned(
               top: 12,
               right: 12, 
               width: 240, 
               child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: markerPositum
           ? _TrainerMapPokedexCard(
            nomen: ref.watch(formNomenProvider),
            color: ref.watch(formColorProvider),
            totalCapturados: totalCapturados,
           )
           : Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: ComplereForm(),
                ),
              ),
            ),
          ),

          if (markerPositum)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: ref.watch(formColorProvider), width: 2),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: ref.watch(formColorProvider),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'ENTRENADOR: ${ref.watch(formNomenProvider).toUpperCase()}',
                      style: GoogleFonts.russoOne(fontSize: 14, color: Colors.black87),
                    ),
                    const Spacer(),
                    Text(
                      'Lat: ${ref.watch(coordsMarkerProvider)[0]?.toStringAsFixed(4) ?? "0"}',
                      style: const TextStyle(fontFamily: 'Courier', fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

      class _TrainerMapPokedexCard extends StatelessWidget {
  final String nomen;
  final Color color;
  final int totalCapturados;

  const _TrainerMapPokedexCard({
    required this.nomen,
    required this.color,
    required this.totalCapturados,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.pink.shade600.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(Icons.catching_pokemon, size: 22, color: color),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          
          // Nombre y Estado
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  nomen,
                  style: GoogleFonts.russoOne(color: Colors.white, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
                const Text(
                  'ONLINE ⚡',
                  style: TextStyle(color: Colors.greenAccent, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Text('👑 ', style: TextStyle(fontSize: 10)),
                Text(
                  '$totalCapturados',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
