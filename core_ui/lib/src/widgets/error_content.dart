import 'package:flutter/material.dart';

class ErrorContent extends StatelessWidget {
  final VoidCallback onTap;

  const ErrorContent({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Oops! Something goes wrong...\nCheck your internet connection!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            onPressed: onTap,
            child: const Icon(
              Icons.refresh,
            ),
          )
        ],
      ),
    );
  }
}
