import 'package:dio/dio.dart';
import 'package:e_commerce/kernel/validations/validations.dart';
import 'package:e_commerce/modules/login/login_page.dart';
import 'package:e_commerce/modules/products/landing.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/kernel/widgets/my_button.dart';
import 'package:e_commerce/kernel/widgets/my_textfield.dart';
import 'package:e_commerce/kernel/widgets/square_tile.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _forKey = GlobalKey<FormState>();

  bool _isButtonDisabled = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  final dio = Dio();

  bool isLoading = false;
  double rotation = 0.0;
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    rotateIndicator();
    rotateSteps();
  }

  void rotateIndicator() async {
    while (isLoading) {
      await Future.delayed(const Duration(milliseconds: 180));
      setState(() {
        if (currentStep < 12) {
          currentStep += 1;
        } else {
          currentStep = 0;
        }
      });
    }
  }

  void rotateSteps() async {
    while (isLoading) {
      await Future.delayed(const Duration(milliseconds: 150));
      setState(() {
        rotation += 0.1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _forKey,
                  onChanged: () {
                    setState(() {
                      _isButtonDisabled = !_forKey.currentState!.validate();
                    });
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Center(
                            child: Image.asset(
                          'assets/images/logo-light.PNG',
                          width: 150,
                          height: 75,
                        )),
                        const SizedBox(height: 10),
                        Text(
                          'Registrarse',
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        MyTextField(
                          title: 'Nombre',
                          controller: nameController,
                          hintText: 'Ingresa tu nombre',
                          obscureText: false,
                          validations: Validations.onlyLetters,
                          errorText: 'Solo puede contener letras',
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          title: 'Apellidos',
                          controller: lastNameController,
                          hintText: 'Ingresa tu(s) Apellido(s)',
                          obscureText: false,
                          validations: Validations.onlyLetters,
                          errorText: 'Solo puede contener letras',
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          title: 'Teléfono',
                          controller: phoneController,
                          hintText: 'Ingresa tu teléfono',
                          obscureText: false,
                          validations: Validations.phone,
                          errorText: 'Ingresa un teléfono válido',
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          title: 'Email',
                          controller: emailController,
                          hintText: 'Correo electrónico',
                          obscureText: false,
                          validations: Validations.email,
                          errorText: 'Introduce un correo válido',
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          title: 'Contraseña',
                          controller: passwordController,
                          hintText: 'Ingresa tu contraseña',
                          obscureText: true,
                          validations: Validations.password,
                          errorText:
                              'Mínimo 8 caracteres \n1 letra mayúscula \n1 letra minúscula \n1 número \n1 caracter especial',
                        ),
                        const SizedBox(height: 25),
                        MyButton(
                          title: 'Registrarse',
                          onTap: _isButtonDisabled
                              ? null
                              : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Response response;
                                  try {
                                    response = await dio.post(
                                      'http://192.168.1.64:8080/api/users',
                                      data: {
                                        'name': nameController.text,
                                        'lastname': lastNameController.text,
                                        'email': emailController.text,
                                        'phone': phoneController.text,
                                        'password': passwordController.text,
                                        'rol': {'idRol': 1}
                                      },
                                    );
                                    if (response.statusCode == 200 ||
                                        response.statusCode == 201) {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          'email', emailController.text);
                                      prefs.setString('name',
                                          response.data['data']['name']);
                                      prefs.setString('lastname',
                                          response.data['data']['lastname']);
                                      Fluttertoast.showToast(
                                          msg:
                                              "Bienvenid@ ${response.data['data']['name']} ${response.data['data']['lastname']}",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => const Home(),
                                        ),
                                      );
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Ha ocurrido un error ${response.statusCode}",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                    }
                                  } on DioException catch (e) {
                                    if (e.response != null) {
                                      if (e.response!.data['status'] == 401) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "${e.response!.data['message']}",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.black,
                                            fontSize: 16.0);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "${e.response!.data['status']} ${e.response!.data['message']}",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.black,
                                            fontSize: 16.0);
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Ha ocurrido un error",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                    }
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                          isDisabled: _isButtonDisabled,
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  'O continua con',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SquareTile(imagePath: 'assets/images/google.png'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '¿Ya tienes una cuenta?',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(width: 4),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Inicia sesión',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (isLoading)
              Container(
                  color: const Color.fromARGB(206, 0, 0, 0),
                  child: Center(
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(rotation),
                      child: CircularStepProgressIndicator(
                        totalSteps: 12,
                        currentStep: currentStep,
                        selectedColor: Colors.redAccent,
                        unselectedColor: Colors.grey[200],
                        selectedStepSize: 10.0,
                        width: 60,
                        height: 60,
                        gradientColor: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 64, 233, 255),
                            Color(0xFF4D53DD),
                            Color.fromARGB(255, 139, 77, 221),
                            Color.fromARGB(255, 255, 64, 191)
                          ],
                        ),
                      ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
