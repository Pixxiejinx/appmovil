// ignore_for_file: prefer_const_constructors

import 'package:flu_app/presentation/widgets/widget.dart';
import 'package:flutter/material.dart';

class ChartaScreen extends StatefulWidget {
  const ChartaScreen({super.key});

  @override
  State<ChartaScreen> createState() => _ChartaScreenState();
}

class _ChartaScreenState extends State<ChartaScreen> {
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
          ColoredBox(
            color: Colors.blueGrey,
            child: Center(
              child: Text(
                'Mapa a pantalla completa',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(120),
                child: ComplereForm()
              ),
            ),
        ],
      ),
    );
  }
}