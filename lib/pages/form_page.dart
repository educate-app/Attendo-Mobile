import 'package:attendo/widgets/custom_button.dart';
import 'package:attendo/widgets/custom_tile_widget.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final List<TextEditingController> _controllers = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      _controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Form',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: true,
          ),
          body: Form(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTileWidget(
                        controller: _controllers[0],
                        title: 'Full Name',
                        icon: Icons.person_outline_outlined,
                        onClick: () {},
                        inputType: TextInputType.text),
                    CustomTileWidget(
                        controller: _controllers[1],
                        title: 'College Email Address',
                        icon: Icons.mail_outline,
                        onClick: () {},
                        inputType: TextInputType.text),
                    CustomTileWidget(
                        controller: _controllers[2],
                        title: 'Enrollment Number',
                        icon: Icons.school_rounded,
                        onClick: () {},
                        inputType: TextInputType.number),
                    CustomTileWidget(
                        controller: _controllers[3],
                        title: 'Phone Number',
                        icon: Icons.phone_android_outlined,
                        onClick: () {},
                        inputType: TextInputType.number),
                    CustomButton(onPressed: () {}, text: 'Submit')
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
