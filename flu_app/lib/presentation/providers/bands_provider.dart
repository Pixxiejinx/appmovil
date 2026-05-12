import 'package:flutter_riverpod/legacy.dart';
import 'package:flu_avm/config/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus{
  // ignore: constant_identifier_names
  Online,
  // ignore: constant_identifier_names
  Offline,
  // ignore: constant_identifier_names
  Connecting
}

final bandsProvider = StateNotifierProvider<BandsNotifier,BandsState>((ref){
  return BandsNotifier();
});

class BandsState{
  final List<Band> bands;
  final ServerStatus serverStatus;
  final IO.Socket socket;

  BandsState({
    required this.bands,
    required this.serverStatus,
    required this.socket
  });

  BandsState copyWith({
    List<Band>? bands,
    ServerStatus? serverStatus,
    IO.Socket? socket
  }){
    return BandsState(
      bands: bands ?? this.bands,
      serverStatus: serverStatus ?? this.serverStatus,
      socket: socket ?? this.socket
    );
  }
}





final BandsProvider = StateNotifierProvider<BandsNotifier,BandsState>((ref){
  return BandsNotifier();
});

class BandsNotifier extends StateNotifier<BandsState> {
  BandsNotifier() : super(BandsState(
    bands: [
      Band(id: '1', nomen: 'Yeule', numerusVotum: 5),
      Band(id: '1', nomen: 'Masive Attack', numerusVotum: 5),
      Band(id: '2', nomen: 'Melanie Martinez', numerusVotum: 2),
      Band(id: '3', nomen: 'Lana del Rey', numerusVotum: 3),
      Band(id: '4', nomen: 'One Ok Rock', numerusVotum: 8),
    ],
    serverStatus: ServerStatus.Connecting,
    socket: IO.io(
      'http://localhost:3000',
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        .build(),
    ),
  ));

  void delereBand(Band band) {}

  void addereVotum(Band band) {}

  void addereBand(Band band) {}
}
     



 /*class BandsNotifier extends StateNotifier<List<Band>>{
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
}*/