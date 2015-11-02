part of lib_a;

var loaderComponent = react.registerComponent(() => new _LoaderComponent());

class _LoaderComponent extends react.Component {
  Function get loadHandler => props['loadHandler'];

  render() {
    return react.button({'onClick': loadHandler}, 'Load');
  }
}