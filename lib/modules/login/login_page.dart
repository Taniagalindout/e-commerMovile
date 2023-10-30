import 'package:dio/dio.dart';
import 'package:e_commerce/kernel/validations/validations.dart';
import 'package:e_commerce/modules/login/register.dart';
import 'package:e_commerce/modules/products/landing.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/kernel/widgets/my_button.dart';
import 'package:e_commerce/kernel/widgets/my_textfield.dart';
import 'package:e_commerce/kernel/widgets/square_tile.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _forKey = GlobalKey<FormState>();

  bool _isButtonDisabled = true;

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

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
                        const SizedBox(height: 30),
                        // logo
                        Center(
                            child: Image.asset(
                          'assets/images/logo-light.PNG',
                          width: 200,
                          height: 75,
                        )),

                        Text(
                          'Bienvenido, comienza tus compras ahora',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          'Iniciar sesión',
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 30),

                        // username textfield
                        MyTextField(
                          title: 'Email',
                          controller: usernameController,
                          hintText: 'Correo electrónico',
                          obscureText: false,
                          validations: Validations.email,
                          errorText: 'Introduce un correo válido',
                        ),

                        const SizedBox(height: 20),

                        // password textfield
                        MyTextField(
                          title: 'Contraseña',
                          controller: passwordController,
                          hintText: 'Contraseña',
                          obscureText: true,
                          validations: Validations.password,
                          errorText:
                              'Mínimo 8 caracteres \n1 letra mayúscula \n1 letra minúscula \n1 número \n1 caracter especial',
                        ),

                        const SizedBox(height: 10),

                        // forgot password?
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        // sign in button
                        MyButton(
                          title: 'Iniciar sesión',
                          onTap: _isButtonDisabled
                              ? null
                              : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Response response;
                                  try {
                                    response = await dio.post(
                                      'http://192.168.1.64:8080/api/users/login',
                                      data: {
                                        'email': usernameController.text,
                                        'password': passwordController.text
                                      },
                                    );

                                    if (response.statusCode == 200 ||
                                        response.statusCode == 201) {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      Fluttertoast.showToast(
                                          msg:
                                              "Bienvenid@ ${response.data['data']['name']} ${response.data['data']['lastname']}",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                      prefs.setString(
                                          'email', usernameController.text);
                                      prefs.setString('name',
                                          response.data['data']['name']);
                                      prefs.setString('lastname',
                                          response.data['data']['lastname']);
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
                                                "Usuario o contraseña incorrectos",
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

                        // or continue with
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

                        // google + apple sign in buttons
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // google button
                            SquareTile(imagePath: 'assets/images/google.png'),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // not a member? register now
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '¿No tienes una cuenta?',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(width: 4),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Registrate',
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
