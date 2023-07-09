import 'package:flutter/material.dart';

class CenterErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback? onReloadTapped;

  const CenterErrorWidget({
    super.key,
    required this.error,
    this.onReloadTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            error,
            style: const TextStyle(color: Colors.red),
          ),
          if (onReloadTapped != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: onReloadTapped, icon: const Icon(Icons.refresh)),
            )
        ],
      ),
    );
  }
}
