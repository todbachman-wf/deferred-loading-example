import 'dart:async';
import 'dart:html';

import 'package:source_maps/source_maps.dart';

final RegExp _stackTraceRegExp = new RegExp(r'(https?://.+\.js):(\d+):(\d+)');

Future<String> applySourceMaps(String stackTrace) async {
  // If in checked mode, return the stack trace unchanged.
  var isChecked = false;
  assert(() => isChecked = true);
  if (isChecked) {
    return stackTrace;
  }

  var output = new StringBuffer();
  var sourceMaps = {};
  await Future.forEach(stackTrace.split('\n'), (String text) async {
    var updatedText = text;
    var match = _stackTraceRegExp.firstMatch(text);
    if (match != null) {
      // Get the source map
      var sourceMap;
      var sourceMapUrl = '${match[1]}.map';
      if (sourceMaps.containsKey(sourceMapUrl)) {
        sourceMap = sourceMaps[sourceMapUrl];
      } else {
        try {
          sourceMap = parse(await HttpRequest.getString(sourceMapUrl));
          sourceMaps[sourceMapUrl] = sourceMap;
        } catch (_) {
          sourceMaps[sourceMapUrl] = null;
        }
      }

      if (sourceMap != null) {
        var lineNumber = int.parse(match[2]);
        var columnNumber = int.parse(match[3]);
        var span = sourceMap.spanFor(lineNumber, columnNumber);
        if (span != null) {
          var file = span.sourceUrl;
          var function = span.text;
          lineNumber = span.start.line;
          updatedText = '    at $function ($file:$lineNumber)';
        }
      }
    }
    output.writeln(updatedText);
  });
  return output.toString();
}
