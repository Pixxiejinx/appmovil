
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MenuItem {
  final String titulus;
  final String subtitulus;
  final String link;
  final Widget? icon;
  final String? imagePath;


  const MenuItem({
  required this.titulus,
  required this.subtitulus,
  required this.link,
  this.icon,
  this.imagePath,

});

}

final appMenuItems = <MenuItem>[
  const MenuItem(
    titulus: 'Contador Pokemon',
    subtitulus: 'PokeHouse',
    link: '/numerator-river',
    icon: Icon(Icons.analytics_outlined),
  ),

  const MenuItem(
    titulus: 'Bandas musicales',
    subtitulus: 'Gráficos de Pie Chart y votaciones',
    link: '/bands',
    icon: Icon(Icons.music_note_outlined),
  ),

  const MenuItem(
    titulus: 'Mapa de entrenadores',
    subtitulus: 'Localizador de usuarios',
    link: '/charta',
    icon: Icon(Icons.map),
  ),

  const MenuItem(
    titulus: 'PokeApi',
    subtitulus: 'Peticiones http a una Api',
    link: '/request',
    icon: Icon(Icons.catching_pokemon),
  ),

  MenuItem(
  titulus: 'Tareas Cute',
  subtitulus: 'Mi lista de tareas personal',
  link: '/todo-cute',
  icon: Padding(
    padding: const EdgeInsets.all(4.0), 
    child: Image.asset(
      'assets/images/vecteezy_medical-clipboard-checklist-pixel-art-icon-for-patient-form_74234734.png',
      fit: BoxFit.contain,
    ),
  ),
),

];

