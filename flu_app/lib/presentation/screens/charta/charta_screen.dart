// ignore_for_file: prefer_const_constructors

import 'package:flu_app/presentation/providers/charta_provider.dart';
import 'package:flu_app/presentation/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class ChartaScreen extends StatefulWidget {
  const ChartaScreen({super.key});

  @override
  State<ChartaScreen> createState() => _ChartaScreenState();
}

class _ChartaScreenState extends State<ChartaScreen> {

  void _initiareCirleAnnotations(MapboxMap mapboxMap) {
    // Aquí puedes agregar anotaciones o personalizar el mapa después de que se haya creado
  }

   void _aperireColorPicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Selecciona un color'),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ComplereForm.paletteColorum.map((color) {
                return GestureDetector(
                  onTap: () {
                    ref.read(formColorProvider.notifier).state = color;
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapas'),
      ),
      body: Stack(
        fit: StackFit.expand,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          MapWidget(
            key: ValueKey('main_mapa'),
            cameraOptions: CameraOptions(
              center: Point(
                coordinates: Position(-122.467895, 37.800126)
                ),
                zoom: 14.5,
            ),
            styleUri: MapboxStyles.MAPBOX_STREETS,
            onMapCreated: _initiareCirleAnnotations,
          ),
          Align(
            alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: ComplereForm()
              ),
            ),
        ],
      ),
    );
  }
}