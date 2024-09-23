import 'package:flutter/material.dart';

class RecoverAccountView extends StatefulWidget {
  const RecoverAccountView({super.key});

  @override
  State<RecoverAccountView> createState() => _RecoverAccountViewState();
}

class _RecoverAccountViewState extends State<RecoverAccountView> with SingleTickerProviderStateMixin {
  late AnimationController _controllerAnimation;

  @override
  void initState() {
    super.initState();
    _controllerAnimation = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controllerAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

}
