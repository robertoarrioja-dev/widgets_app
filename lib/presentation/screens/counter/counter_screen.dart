import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class CounterScreen extends ConsumerWidget {
  static const name = 'counter_screen';

  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int clickCounter = ref.watch(counterProvider);
    final isDarkmode = ref.watch(themeNotifierProvider).isDarkmode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
        actions: [
          IconButton(
            icon: Icon(isDarkmode
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleDarkmode();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$clickCounter',
              style: const TextStyle(
                fontSize: 160,
                fontWeight: FontWeight.w100,
              ),
            ),
            Text(
              'Click${clickCounter == 1 ? '' : 's'}',
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomButtom(
            icon: Icons.refresh_outlined,
            onPressed: () {
              // ref.read(counterProvider.notifier)
              //   .update((state) => state + 1);
              ref.read(counterProvider.notifier).state = 0;
            },
          ),
          const SizedBox(height: 10),
          CustomButtom(
            icon: Icons.exposure_minus_1_outlined,
            onPressed: () {
              // ref.read(counterProvider.notifier)
              //   .update((state) => state + 1);
              var valorActual = ref.read(counterProvider.notifier).state;
              if (valorActual == 0) return;
              ref.read(counterProvider.notifier).state--;
            },
          ),
          const SizedBox(height: 10),
          CustomButtom(
            icon: Icons.exposure_plus_1_outlined,
            onPressed: () {
              // ref.read(counterProvider.notifier)
              //   .update((state) => state + 1);
              ref.read(counterProvider.notifier).state++;
            },
          ),
        ],
      ),
    );
  }
}

class CustomButtom extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CustomButtom({
    Key? key,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      enableFeedback: true,
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
