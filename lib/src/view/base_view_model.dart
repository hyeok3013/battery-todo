import 'package:battery_todo/src/view/base_view_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseViewModel<S extends BaseViewState>
    extends AutoDisposeNotifier<S> {}
