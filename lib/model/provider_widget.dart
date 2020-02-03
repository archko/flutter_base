import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final Widget child;
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelInitial;

  ProviderWidget({
    Key key,
    this.model,
    this.child,
    this.builder,
    this.onModelInitial,
  });

  @override
  ProviderWidgetState<T> createState() => ProviderWidgetState<T>();
}

class ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    super.initState();
    this.model = widget.model;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onModelInitial != null) {
        widget.onModelInitial(this.model);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => this.model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
      builder;
  final A model1;
  final B model2;
  final Widget child;
  final Function(A, B) onModelInitial;

  ProviderWidget2({
    Key key,
    this.builder,
    this.model1,
    this.model2,
    this.child,
    this.onModelInitial,
  }) : super(key: key);

  _ProviderWidgetState2<A, B> createState() => _ProviderWidgetState2<A, B>();
}

class _ProviderWidgetState2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> {
  A model1;
  B model2;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onModelInitial != null) {
        widget.onModelInitial(model1, model2);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>(
            builder: (context) => model1,
          ),
          ChangeNotifierProvider<B>(
            builder: (context) => model2,
          )
        ],
        child: Consumer2<A, B>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}

class ProviderWidget3<A extends ChangeNotifier, B extends ChangeNotifier,
    C extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(
      BuildContext context, A model1, B model2, C model3, Widget child) builder;
  final A model1;
  final B model2;
  final C model3;
  final Widget child;
  final Function(A, B, C) onModelInitial;

  ProviderWidget3({
    Key key,
    this.builder,
    this.model1,
    this.model2,
    this.model3,
    this.child,
    this.onModelInitial,
  }) : super(key: key);

  _ProviderWidgetState3<A, B, C> createState() =>
      _ProviderWidgetState3<A, B, C>();
}

class _ProviderWidgetState3<A extends ChangeNotifier, B extends ChangeNotifier,
    C extends ChangeNotifier> extends State<ProviderWidget3<A, B, C>> {
  A model1;
  B model2;
  C model3;

  @override
  void initState() {
    model1 = widget.model1;
    model2 = widget.model2;
    model3 = widget.model3;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onModelInitial != null) {
        widget.onModelInitial(model1, model2, model3);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<A>(
            builder: (context) => model1,
          ),
          ChangeNotifierProvider<B>(
            builder: (context) => model2,
          ),
          ChangeNotifierProvider<C>(
            builder: (context) => model3,
          )
        ],
        child: Consumer3<A, B, C>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}
