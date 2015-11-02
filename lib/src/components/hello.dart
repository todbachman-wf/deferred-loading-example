import 'package:react/react.dart' as react;

import 'package:deferred_loading_example/src/exception_parser.dart';

var helloComponent = react.registerComponent(() => new _HelloComponent());

class _HelloComponent extends react.Component {
  render() {
    _testSourceMaps();
    return react.div({}, 'Hi, I was deferred loaded!');
  }
}

void _testSourceMaps() {
  try {
    throw new FormatException();
  } catch(_, stackTrace) {
    applySourceMaps(stackTrace.toString()).then((result) => print(result));
  }
}
