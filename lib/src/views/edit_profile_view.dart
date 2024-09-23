import 'package:crmelinnovadorseller/src/controllers/edit_profile_controller.dart';
import 'package:crmelinnovadorseller/src/tools/custom_colors.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_input.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../widgets/custom_dropdown_menu.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controllerAnimation;
  final _controller = EditProfileController();

  @override
  void initState() {
    super.initState();
    _controllerAnimation = AnimationController(vsync: this);
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
    _controllerAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.key,
      backgroundColor: CustomColors.colorSecundary,
      appBar: AppBar(
        backgroundColor: CustomColors.colorPrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        centerTitle: true,
        title: const Text('Editar perfil'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Atras',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      // Cuerpo de la pagina
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Titulo datos de empresa
              const Padding(
                padding: EdgeInsets.only(
                  top: 30,
                  bottom: 10,
                ),
                child: CustomTitle(
                  title: 'Modificar los datos de tu empresa.',
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.clip,
                ),
              ),
              // Nombres y Apellidos
              CustomInput(
                controller: _controller.nit,
                obscureText: false,
                keyboardType: TextInputType.number,
                fillColor: Colors.white,
                title: 'NIT',
                icon: const Icon(Icons.numbers),
              ),
              // Nombre de la compañia
              CustomInput(
                controller: _controller.companyName,
                obscureText: false,
                keyboardType: TextInputType.number,
                fillColor: Colors.white,
                title: 'Nombre de la empresa.',
                icon: const Icon(Icons.edit),
              ),
              // Tipo de empresa
              CustomDropdownMenu(
                title: 'Tipo de empresa.',
                items: const <String>[
                  'Sociedad por acciones simplificadas (SAS)',
                  'Sociedad limitada',
                  'Empresa unipersonal',
                  'Sociedad anónima',
                  'Sociedad colectiva',
                  'Sociedad Comandita Simple',
                  'Sociedad comandita por acciones',
                  'Empresa asociativa de trabajo'
                ],
                onChanged: (value) {
                  setState(() {
                    _controller.companyType = value;
                  });
                },
              ),
              // Datos de contacto
              const Padding(
                padding: EdgeInsets.only(
                  top: 30,
                  bottom: 10,
                ),
                child: CustomTitle(
                  title: 'Modificar los datos personales.',
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.clip,
                ),
              ),
              // Nombres completos
              CustomInput(
                controller: _controller.fullNames,
                obscureText: false,
                keyboardType: TextInputType.number,
                fillColor: Colors.white,
                title: 'Nombres completos',
                icon: const Icon(Icons.edit),
              ),
              // Telefono
              CustomInput(
                controller: _controller.phoneNumber,
                obscureText: false,
                keyboardType: TextInputType.number,
                fillColor: Colors.white,
                title: 'Número celular 🇨🇴',
                icon: const Icon(Icons.phone_android),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 30,
                  bottom: 10,
                ),
                child: CustomTitle(
                  title: 'Modifica los datos de la  cuenta.',
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.clip,
                ),
              ),
              // email
              CustomInput(
                enabled: false,
                controller: _controller.email,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                fillColor: Colors.white,
                title: _controller.seller?.email ?? 'Email - Cuenta',
                icon: const Icon(Icons.email),
              ),
              // Contraseña
              CustomInput(
                controller: _controller.password,
                obscureText: true,
                keyboardType: TextInputType.number,
                fillColor: Colors.white,
                title: 'Contraseña.',
                icon: const Icon(Icons.lock),
              ),
              // Repita contraseña
              CustomInput(
                controller: _controller.repeatPassword,
                obscureText: true,
                keyboardType: TextInputType.number,
                fillColor: Colors.white,
                title: 'Repita la contraseña.',
                icon: const Icon(Icons.lock),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
