import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'record_voice.g.dart';

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

// ! you must specify keepAlive to true here! because it won't be readable from anywhere!
@Riverpod(keepAlive: true)
class RecordVoice extends _$RecordVoice {
  @override
  String? build() {
    return '';
  }

  Future<void> startRecording(AudioRecorder recorder) async {
    // NOTE generate file path with function
    final directoryName = await getApplicationCacheDirectory();
    final filePath = '${directoryName.path}/${genRandomString(12)}.m4a';

    await recorder.start(
      // NOTE default value aacLc is the best performance, if you want to create wav file you should specify encoder to pcm16bits
      const RecordConfig(),
      path: filePath,
    );
  }

  Future<void> stopRecording(AudioRecorder recorder) async {
    state = await recorder.stop() ?? '';
  }
}
