part of lib_b;

var helloComponent = react.registerComponent(() => new _HelloComponent());

class _HelloComponent extends react.Component {
  render() {
    return react.div({}, 'Hi, I was deferred loaded!');
  }
}