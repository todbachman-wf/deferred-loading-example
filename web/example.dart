import 'dart:async';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart' as reactClient;

import 'package:deferred_loading_example/lib_a.dart';

Future main() async {
  reactClient.setClientConfiguration();
  var loader = loaderComponent({});
  react.render(loader, querySelector('#toolbar-container'));
}