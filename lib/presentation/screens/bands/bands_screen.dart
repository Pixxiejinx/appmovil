import 'package:flutter/material.dart';

class BandsScreen extends StatefulWidget {
  const BandsScreen({super.key});

  @override
  State<BandsScreen> createState() => _BandsScreenState();
}

class _BandsScreenState extends State<BandsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandas')
      ),
    );
  }
}