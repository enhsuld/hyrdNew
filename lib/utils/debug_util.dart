import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart' show Trace;

class DebugUtil {
  static void dumpStackTrace(int depth, {int startLevel = 1}) {
    final frames = Trace.current(startLevel).frames;
    if (frames != null) {
      debugPrint('Stack Trace:');
      int n = depth <= frames.length ? depth : frames.length;
      for (int i = 0; i < n; ++i) debugPrint(frames[i].toString());
      if (depth < frames.length)
        debugPrint('... (eliminated ${frames.length - depth})');
    }
  }
}
