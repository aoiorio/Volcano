import 'dart:math';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'record_voice_with_wave.g.dart';

const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
final rnd = Random();

String genRandomString(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    );

@Riverpod(keepAlive: true)
class RecordVoiceWithWaveController extends _$RecordVoiceWithWaveController {
  String? path = '';

  @override
  RecorderController build() {
    // final controller = RecorderController();
    final recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 16000;

    return recorderController;
  }

  Future<void> startRecordingWithWave() async {
    final directoryName = await getApplicationCacheDirectory();
    final filePath = '${directoryName.path}/${genRandomString(12)}.m4a';

    await state.record(path: filePath);
  }

  Future<void> stopRecordingWithWave() async {
    path = await state.stop();
  }
}
