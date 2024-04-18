import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingW extends StatelessWidget {
  const LoadingW({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset("assets/loading.json"),
    );
  }
}
