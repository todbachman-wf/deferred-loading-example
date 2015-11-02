import 'dart:async';
import 'dart:html';

import 'package:react/react.dart' as react;

import 'package:deferred_loading_example/lib_b.dart' deferred as lib_b;
import 'package:deferred_loading_example/src/exception_parser.dart';

var loaderComponent = react.registerComponent(() => new _LoaderComponent());

class _LoaderComponent extends react.Component {
  render() {
    _testSourceMaps();
    return react.button({'onClick': _onClickHandler}, 'Load');
  }

  Future _onClickHandler(_) async {
    await lib_b.loadLibrary();
    var hello = lib_b.helloComponent({});
    react.render(hello, querySelector('#body-container'));
  }
}

void _testSourceMaps() {
  try {
    throw new IntegerDivisionByZeroException();
  } catch(_, stackTrace) {
    applySourceMaps(stackTrace.toString()).then((result) => print(result));
  }
}
