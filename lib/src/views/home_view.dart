import 'package:crmelinnovadorseller/src/controllers/home_controller.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_buttons.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_input.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../tools/custom_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = HomeController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.key,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: 200,
                  color: CustomColors.colorSecundary,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 300,
                    ),
                  ),
                ),
              ),
              // Componentes del Login
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .04,
                ),
                child: Column(
                  children: [
                    // Tiltulo
                    const CustomTitle(
                      title: 'Iniciar',
                      fontSize: 40,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                    // Usuario
                    CustomInput(
                      controller: _controller.email,
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      fillColor: Colors.white,
                      title: 'Usuario',
                      icon: const Icon(
                        Icons.verified_user,
                        color: CustomColors.colorPrimary,
                      ),
                    ),
                    // Contraseña
                    CustomInput(
                      controller: _controller.password,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      fillColor: Colors.white,
                      title: 'Contraseña',
                      icon: const Icon(
                        Icons.lock,
                        color: CustomColors.colorPrimary,
                      ),
                    ),
                    // Boton Iniciar secion
                    CustomButtons(
                      onTap: () => _controller.login(),
                      width: MediaQuery.of(context).size.width * .9,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.only(top: 40, bottom: 20),
                      backgroundColor: CustomColors.colorPrimary,
                      title: 'Iniciar sesión',
                      colorText: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      icon: const Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                    ),
                    // Recuperar cuenta
                    TextButton(
                      onPressed: () => '',
                      child: const Text(
                        '¿Olvidaste tu cuenta o tu contraseña?\nClic aquí.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Titulo registrarse
                    const CustomTitle(
                      title: 'Crear cuenta',
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                    // Registrar ahora
                    CustomButtons(
                      onTap: () => Navigator.of(context).pushNamed('register'),
                      width: MediaQuery.of(context).size.width * .9,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      backgroundColor: CustomColors.colorPrimary,
                      title: 'Nueva cuenta',
                      colorText: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
