import 'package:battery_todo/src/view/base_view_model.dart';
import 'package:battery_todo/src/view/base_view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class BaseView<VM extends BaseViewModel<S>, S extends BaseViewState>
    extends ConsumerWidget {
  const BaseView({
    super.key,
    required this.viewModelProvider,
    required this.builder,
  });

  final AutoDisposeNotifierProvider<VM, S> viewModelProvider;
  final Widget Function(WidgetRef ref, VM viewModel, S state) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(viewModelProvider);
    return builder(
      ref,
      ref.read(viewModelProvider.notifier),
      state,
    );
  }
}
