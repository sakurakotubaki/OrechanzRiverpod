import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkboxNotifierProvider = NotifierProvider<CheckboxNotifier, bool>(CheckboxNotifier.new);
/// Checkboxの状態を管理するNotifier
class CheckboxNotifier extends Notifier<bool> {
  @override
   build() {
    return false;
  }

  void updateValue(bool newValue) {
    state = newValue;
  }
}