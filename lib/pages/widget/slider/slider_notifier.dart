import 'package:flutter_riverpod/flutter_riverpod.dart';

final sliderValueProvider = NotifierProvider<SliderNotifier, double>(SliderNotifier.new);

class SliderNotifier extends Notifier<double> {
  @override
   build() {
    return 20.0;
  }

  void updateValue(double newValue) {
    state = newValue;
  }
}