import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final name = 'Tania Cano';
  final email = '20203tn155@utez.edu.mx';
  final password = '*********';
  bool _isEditingEnabled = false;

  @override
  void initState() {
    super.initState();
    /*nameController.text = name;
    emailController.text = email;*/
    passwordController.text = password;
  }

  void _enableEditing() {
    setState(() {
      _isEditingEnabled = true;
    });
  }

  void _disableEditing() {
    setState(() {
      _isEditingEnabled = false;
    });
  }

  String obtenerIniciales(String nombre) {
    List<String> palabras = nombre.split(' ');
    String iniciales = '';
    for (var i = 0; i < 2; i++) {
      iniciales += palabras[i][0].toUpperCase();
    }
    return iniciales;
  }

  Future<List<String?>> _email() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? name = prefs.getString('name');
    String? lastname = prefs.getString('lastname');

    return [email, name, lastname];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        elevation: 0,
        backgroundColor: const Color(0xFF47BAF4),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF47BAF4),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder<List<String?>>(
              future: _email(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<String?>> snapshot) {
                Widget result = const CircularProgressIndicator();
                if (snapshot.hasData) {
                  result = Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3.0,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF47BAF4),
                              Color(0xFF4D53DD),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                        ),
                        child: Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: Text(
                              obtenerIniciales(
                                  '${snapshot.data![1]!} ${snapshot.data![2]!}'),
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF6FC4),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue:
                                    '${snapshot.data![1]!} ${snapshot.data![2]!}',
                                decoration: const InputDecoration(
                                  labelText: 'Nombre completo',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.name,
                                readOnly: !_isEditingEnabled,
                                //controller: nameController,
                                obscureText: false,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _isEditingEnabled
                                ? _disableEditing
                                : _enableEditing,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: snapshot.data![0]!,
                                decoration: const InputDecoration(
                                  labelText: 'Correo electrónico',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                readOnly: !_isEditingEnabled,
                                //controller: emailController,
                                obscureText: false,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _isEditingEnabled
                                ? _disableEditing
                                : _enableEditing,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                onTap: () {
                                  passwordController.text = '';
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Contraseña',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                readOnly: !_isEditingEnabled,
                                controller: passwordController,
                                obscureText: true,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _isEditingEnabled
                                ? _disableEditing
                                : _enableEditing,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4D53DD),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "Modificar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 2),
                    ],
                  );
                } else if (snapshot.hasError) {
                  result = const Center(child: CircularProgressIndicator());
                }
                return result;
              }),
        ),
      ),
    );
  }
}
