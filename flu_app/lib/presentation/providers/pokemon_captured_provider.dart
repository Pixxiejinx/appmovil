import 'package:flutter_riverpod/legacy.dart';

class CapturedPokemonsNotifier extends StateNotifier<Map<int, String>> {
  CapturedPokemonsNotifier() : super({});

  void toggleCaptura(int id, List<String> facultates) {
    final Map<int, String> newState = Map.from(state);

    if (newState.containsKey(id)) {
      newState.remove(id); 
    } else {
      newState[id] = facultates.join(', ').toLowerCase(); 
    }
    state = newState;
  }

  bool estaAtrapado(int id) => state.containsKey(id);
}

final capturedPokemonsProvider = StateNotifierProvider<CapturedPokemonsNotifier, Map<int, String>>((ref) {
  return CapturedPokemonsNotifier();
});