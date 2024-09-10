import 'package:crmelinnovadorseller/src/providers/autenticator_provider.dart';
import 'package:crmelinnovadorseller/src/tools/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomMenu extends StatefulWidget {
  const CustomMenu({super.key});

  @override
  State<CustomMenu> createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _authProvider = AuthProvider();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Image.asset('assets/images/logo.png'),
          ),
          ListTile(
            trailing: const Icon(Icons.edit),
            title: const Text('Editar perfil'),
            splashColor: CustomColors.colorPrimary,
            onTap: ()=> Navigator.of(context).pushNamed('EditProfileView'),
          ),
          ListTile(
            trailing: const Icon(Icons.inventory),
            title: const Text('Inventario'),
            splashColor: CustomColors.colorPrimary,
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer
            },
          ),
          ListTile(
            trailing: const Icon(Icons.notification_add),
            title: const Text('Promocionar artículo'),
            splashColor: CustomColors.colorPrimary,
            onTap: () {
              Navigator.pop(context); // Cierra el Drawer
            },
          ),
          ListTile(
            trailing: const Icon(Icons.logout),
            title: const Text('Salir'),
            splashColor: CustomColors.colorPrimary,
            onTap: () {
              _authProvider.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
