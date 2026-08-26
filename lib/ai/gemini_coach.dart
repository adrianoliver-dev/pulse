import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';

import '../features/music/device_library.dart';
import 'coach_plan.dart';
import 'gemini_key.dart';

class GeminiCoach {
  GeminiCoach([String? overrideKey])
      : apiKey = (overrideKey ?? geminiApiKey).trim();

  final String apiKey;

  bool get enabled => apiKey.isNotEmpty;

  GenerativeModel _model() {
    return GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.4,
        responseMimeType: 'application/json',
      ),
    );
  }

  Future<List<CoachRoutine>> buildRoutines({
    required String request,
    Uint8List? audioBytes,
    String audioMime = 'audio/mp4',
  }) async {
    const schema = '''
Responde SOLO JSON con esta forma:
{"routines":[{"day":"Hoy","name":"...","mode":"series|tabata|hiit|custom","prepareSeconds":10,"workSeconds":40,"restSeconds":20,"rounds":8,"exerciseLabel":"","note":"","custom":[{"kind":"work|rest","seconds":30,"label":""}]}]}
Reglas: intervalos reales de entrenamiento, preparación 5-15s, work mínimo 5s, máximo 8 rutinas. Si pide un día, una rutina. Si pide la semana, una por día (Lunes a Domingo). mode custom solo si los intervalos no son uniformes.
''';
    final parts = <Part>[
      TextPart('$schema\nPedido del usuario:\n$request'),
      if (audioBytes != null && audioBytes.isNotEmpty)
        DataPart(audioMime, audioBytes),
    ];
    return parseCoachRoutines(await _generate(parts));
  }

  Future<PlaylistPick> buildPlaylist({
    required String request,
    required List<DeviceSong> library,
  }) async {
    final capped = library.take(180).toList();
    final catalog = StringBuffer();
    for (var i = 0; i < capped.length; i++) {
      final s = capped[i];
      catalog.writeln('$i | ${s.title} | ${s.artist}');
    }
    final parts = <Part>[
      TextPart(
        '''
Elige canciones SOLO de este catálogo local (índice | título | artista).
Pedido: $request
Responde SOLO JSON: {"name":"nombre corto de playlist","indices":[0,2,5]}
Entre 8 y 18 canciones. Si pide un artista o género, filtra. Si pide "mejores", prioriza temas que suenen a singles y evita audios, notas de voz y WhatsApp.
Catálogo:
$catalog
''',
      ),
    ];
    return parsePlaylistPick(await _generate(parts), capped);
  }

  Future<String> _generate(List<Part> parts) async {
    final res = await _model().generateContent([Content.multi(parts)]);
    return res.text ?? '{}';
  }
}
