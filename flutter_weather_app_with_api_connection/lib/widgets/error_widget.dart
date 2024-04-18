import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorW extends StatelessWidget {
  const ErrorW({
    super.key,
    this.isInternetConnectionError = false,
    this.text = 'Something went wrong\nTry again',
  });

  final bool isInternetConnectionError;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isInternetConnectionError
              ? Lottie.asset('assets/noConnection.json')
              : const Icon(
                  Icons.cancel_rounded,
                  size: 40,
                  color: Colors.red,
                ),
          Text(
            isInternetConnectionError
                ? 'Check your internet connection\nAnd try again'
                : text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
