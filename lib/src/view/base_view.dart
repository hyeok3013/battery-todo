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
    // viewModelProvider 초기화 여부를 확인
    final state = ref.watch(viewModelProvider);
    if (state == null) {
      // 초기화되지 않은 경우 기본 상태를 반환하거나 로딩 상태를 표시
      return Center(child: CircularProgressIndicator());
    }
    return builder(
      ref,
      ref.read(viewModelProvider.notifier),
      state,
    );
  }
}
