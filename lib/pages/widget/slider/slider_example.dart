import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orechanz/pages/widget/slider/slider_notifier.dart';


class SliderExample extends ConsumerWidget {
  const SliderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSliderValue = ref.watch(sliderValueProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Slider Notifier')),
      body: Slider(
        value: currentSliderValue,
        max: 100,
        divisions: 5,
        label: currentSliderValue.round().toString(),
        onChanged: (double value) {
          ref.read(sliderValueProvider.notifier).updateValue(value);
        },
      ),
    );
  }
}