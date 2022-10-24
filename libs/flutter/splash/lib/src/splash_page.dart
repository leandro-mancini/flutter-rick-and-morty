import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_shared/flutter_shared.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    controller.forward().whenComplete(() {
      Modular.to.pushReplacementNamed('/characters');
    });

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GestureDetector(
          child: SizeTransition(
            sizeFactor: animation,
            axis: Axis.horizontal,
            axisAlignment: -1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(Assets.imgRickMorty),
                      fit: BoxFit.cover,
                    )),
                  ),
                  const Text(
                    'The Rick and Morty',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}