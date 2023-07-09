import 'package:flutter/material.dart';

class CenterLoadingWidget extends StatelessWidget {
  const CenterLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
