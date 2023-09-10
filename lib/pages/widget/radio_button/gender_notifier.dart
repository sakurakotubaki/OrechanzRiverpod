import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orechanz/pages/widget/radio_button/gender.dart';

final genderProvider = NotifierProvider<GenderNotifier, Gender>(GenderNotifier.new);
/// enumをデータの型に使ってラジオボタンの状態を管理する例
class GenderNotifier extends Notifier<Gender> {
  @override
   build() {
    return Gender.female;
  }

  void updateGender(Gender value) {
    state = value;
  }
}