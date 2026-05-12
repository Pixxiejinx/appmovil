import 'package:flutter_riverpod/legacy.dart';
import 'package:flu_avm/config/config.dart';

final bandsProvider = StateNotifierProvider<BandsNotifier,List<Band>>((ref){
  return BandsNotifier();
});

class BandsNotifier extends StateNotifier<List<Band>>{
  
  //Esto es el state
  BandsNotifier() : super([
 Band(id: '1', nomen: 'Yeule', numerusVotum:5),
  Band(id: '1', nomen: 'Masive Attack', numerusVotum:5),
  Band(id: '2', nomen: 'Melanie Martinez', numerusVotum:2),
  Band(id: '3', nomen: 'Lana del Rey', numerusVotum:3),
  Band(id: '4', nomen: 'One Ok Rock', numerusVotum:8),
  ]);

  void addereBand(Band band){
    state = [...state, band];
  }

  void delereBand(Band band){
    state = state.where((b) => b.id != band.id ).toList();
  }

  void addereVotum(Band band){
    state = state.map((b) {
      return b.id == band.id 
        ? Band(id: b.id, nomen: b.nomen, numerusVotum: b.numerusVotum + 1)  
        : b;
    }).toList();
  }
}