import 'package:crmelinnovadorseller/src/controllers/dashboard_controller.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_buttons.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_menu.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../tools/custom_colors.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final _controller = DashboardController();

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
        title: const Text('Panel de control'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        leading: TextButton(
          onPressed: () => _controller.key.currentState?.openDrawer(),
          child: const Text(
            'Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      drawer: const CustomMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // Contenido de la pagina
            children: [
              // Nombre de la empresa
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width * .9,
                alignment: Alignment.centerLeft,
                child: CustomTitle(
                  title: _controller.seller?.companyName ?? 'Empresa',
                  fontSize: 25,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    // Inventarios
                    _addItems(
                      'assets/images/products.jpg',
                      'Inventarios',
                      () => '',
                      const Icon(
                        Icons.add,
                        color: CustomColors.colorPrimary,
                      ),
                    ),
                    // Promocionar articulos
                    _addItems(
                      'assets/images/message.jpg',
                      'Promocionar artículos',
                      () => '',
                      const Icon(
                        Icons.add,
                        color: CustomColors.colorPrimary,
                      ),
                    ),
                    // Editar perfil
                    _addItems(
                      'assets/images/edit_profile.jpg',
                      'Editar perfil',
                      () => Navigator.of(context).pushNamed('EditProfileView'),
                      const Icon(
                        Icons.edit,
                        color: CustomColors.colorPrimary,
                      ),
                    ),
                    // Salir
                    CustomButtons(
                      onTap: () => _controller.exitApp(),
                      width: MediaQuery.of(context).size.width * .9,
                      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
                      margin: const EdgeInsets.only(top: 40),
                      backgroundColor: CustomColors.colorPrimary,
                      title: 'Salir',
                      colorText: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      icon: const Icon(
                        Icons.exit_to_app,
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

  // Graficas

  // Elementos de acceso
  Widget _addItems(String url, String title, GestureTapCallback onTap, Widget icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        margin: const EdgeInsets.only(top: 20),
        decoration:
            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ]),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                url,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .1,
                fit: BoxFit.cover,
              ),
            ),
            // Texto
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                title: Text(title),
                titleTextStyle: const TextStyle(
                  color: CustomColors.colorPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                trailing: icon,
                splashColor: CustomColors.colorPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
