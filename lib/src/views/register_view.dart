import 'package:crmelinnovadorseller/src/controllers/register_controller.dart';
import 'package:crmelinnovadorseller/src/tools/custom_colors.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_buttons.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_card_image.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_dropdown_menu.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_input.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hugeicons/hugeicons.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _controller = RegisterController();
  List<String> gender = <String>['Masculino', 'Femenino', 'Otro'];

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.key,
      // Menu
      appBar: AppBar(
        backgroundColor: CustomColors.colorPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        centerTitle: true,
        title: const Text('Creación de la cuenta'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_circle_left,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      // Cuerpo
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
        decoration: const BoxDecoration(
          color: CustomColors.colorSecundary,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Titulo
              const CustomDescription(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                description:
                    'Diligencia la siguiente información para continuar con tu registro.',
                fontSize: 18,
                color: Colors.black,
                fontFamily: 'Rboto',
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              // Nombres completos
              CustomInput(
                controller: _controller.fullNames,
                obscureText: false,
                keyboardType: TextInputType.name,
                fillColor: Colors.white,
                title: 'Nombres completos.',
                icon: const Icon(
                  Icons.drive_file_rename_outline_sharp,
                  color: CustomColors.colorPrimary,
                ),
              ),
              // Edad
              CustomInput(
                controller: _controller.age,
                obscureText: false,
                keyboardType: TextInputType.number,
                fillColor: Colors.white,
                title: 'Edad.',
                icon: const Icon(
                  Icons.calendar_month_sharp,
                  color: CustomColors.colorPrimary,
                ),
              ),
              // Informacion de interes
              CustomButtons(
                onTap: () => _windowOfInterest(),
                width: MediaQuery.of(context).size.width * .9,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                backgroundColor: CustomColors.colorPrimary,
                title: 'Elige información de tu interés.',
                colorText: Colors.white,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                icon: const Icon(
                  Icons.abc,
                  color: Colors.white,
                ),
              ),
              // Genero
              CustomDropdownMenu(
                title: 'Seleccione su género',
                initialValue: _controller.gender,
                items: gender,
              ),
              // Usuario - Correo
              CustomInput(
                controller: _controller.email,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                fillColor: Colors.white,
                title: 'Correo electrónico.',
                icon: const Icon(
                  Icons.email,
                  color: CustomColors.colorPrimary,
                ),
              ),
              // Contraseña
              CustomInput(
                controller: _controller.password,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                fillColor: Colors.white,
                title: 'Contraseña.',
                icon: const Icon(
                  Icons.password,
                  color: CustomColors.colorPrimary,
                ),
              ),
              // Repita contraseña
              CustomInput(
                controller: _controller.repeatPassword,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                fillColor: Colors.white,
                title: 'Repita la contraseña.',
                icon: const Icon(
                  Icons.password,
                  color: CustomColors.colorPrimary,
                ),
              ),
              // Finalizar registro
              CustomButtons(
                onTap: () => _controller.register(),
                width: MediaQuery.of(context).size.width * .9,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                backgroundColor: CustomColors.colorPrimary,
                title: 'Finalizar registro.',
                colorText: Colors.white,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                icon: const Icon(
                  Icons.app_registration,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Ventana emergente para seleccionar informacion de interes
  Future _windowOfInterest() {
    return showDialog(
      barrierColor: CustomColors.colorPrimary,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Selecciona uno o varios temas de tu interés.'),
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            color: CustomColors.colorPrimary,
          ),
          content: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            width: double.maxFinite,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              // Esto asegura que el GridView se ajuste a su contenido
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
              children: [
                CustomCardImage(
                  icon: HugeIcons.strokeRoundedHealth,
                  title: 'Salud',
                  interest: _controller.interest,
                ),
                CustomCardImage(
                  icon: HugeIcons.strokeRoundedClothes,
                  title: 'Ropa y Accesorios',
                  interest: _controller.interest,
                ),
                CustomCardImage(
                  icon: HugeIcons.strokeRoundedBrush,
                  title: 'Artesanía',
                  interest: _controller.interest,
                ),
                CustomCardImage(
                  icon: HugeIcons.strokeRoundedVegetarianFood,
                  title: 'Comida',
                  interest: _controller.interest,
                ),
                CustomCardImage(
                  icon: HugeIcons.strokeRoundedDrink,
                  title: 'Bebidas',
                  interest: _controller.interest,
                ),
                CustomCardImage(
                  icon: HugeIcons.strokeRoundedTulip,
                  title: 'Belleza',
                  interest: _controller.interest,
                ),
                CustomCardImage(
                  icon: HugeIcons.strokeRoundedArtboardTool,
                  title: 'Miscelánea',
                  interest: _controller.interest,
                ),
                CustomCardImage(
                  icon: HugeIcons.strokeRoundedBasketball01,
                  title: 'Deportes',
                  interest: _controller.interest,
                ),
                CustomCardImage(
                  icon: HugeIcons.strokeRoundedBitcoinSmartphone01,
                  title: 'Tecnología',
                  interest: _controller.interest,
                ),
              ],
            ),
          ),
          actions: [
            CustomButtons(
              onTap: () => Navigator.of(context).pop(),
              width: MediaQuery.of(context).size.width * .8,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              backgroundColor: CustomColors.colorPrimary,
              title: 'Aceptar',
              colorText: Colors.white,
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              icon: const Icon(
                Icons.arrow_circle_left,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
