import 'package:crmelinnovadorseller/src/controllers/edit_profile_controller.dart';
import 'package:crmelinnovadorseller/src/tools/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> with SingleTickerProviderStateMixin {
  late AnimationController _controllerAnimation;
  final _controller = EditProfileController();

  @override
  void initState() {
    super.initState();
    _controllerAnimation = AnimationController(vsync: this);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp){
      _controller.init(context, refresh);
    });
  }

  void refresh(){
    if(mounted){
      setState(() {

      });
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

      ),
    );
  }
}
