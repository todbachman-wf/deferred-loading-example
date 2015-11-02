import 'dart:async';
import 'dart:html';

import 'package:react/react.dart' as react;
import 'package:react/react_client.dart' as reactClient;

import 'package:deferred_loading_example/lib_a.dart';
import 'package:deferred_loading_example/lib_b.dart' deferred as libB;

void main() {
  reactClient.setClientConfiguration();
  var loader = loaderComponent({'loadHandler': onLoad});
  react.render(loader, querySelector('#toolbar-container'));
}

Future onLoad(_) async {
  print('load button clicked');
  await libB.loadLibrary();
  var hello = libB.helloComponent({});
  react.render(hello, querySelector('#body-container'));
}