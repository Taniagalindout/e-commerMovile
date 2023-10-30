import 'package:flutter/material.dart';

class MyShopping extends StatefulWidget {
  const MyShopping({Key? key});

  @override
  State<MyShopping> createState() => _MyShoppingState();
}

class _MyShoppingState extends State<MyShopping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis compras'),
        backgroundColor: const Color(0xFF4D53DD),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.grey, width: 0.2),
                ),
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                      title: const Text('Entregado'),
                      subtitle: const Text(
                          'Celular Apple Desbloqueado iPhone 14 Plus 128 GB Morado'),
                      leading: SizedBox(
                        width: 48,
                        height: 48,
                        child: Image.asset('ruta_de_tu_imagen.png'),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.visibility),
                          label: const Text('Ver detalles'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward),
                          label: const Text('Comprar'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                      title: const Text('Entregado'),
                      subtitle: const Text(
                          'Cámara Canon EOS R5 RF24-105mm F4 L IS USM'),
                      leading: SizedBox(
                        width: 48,
                        height: 48,
                        child: Image.asset('ruta_de_tu_imagen.png'),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.visibility),
                          label: const Text('Ver detalles'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward),
                          label: const Text('Comprar'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                      title: const Text('Entregado'),
                      subtitle: const Text(
                          'Vestido de tirantes con estampado floral de margaritas bajo con abertura M con nudo'),
                      leading: SizedBox(
                        width: 48,
                        height: 48,
                        child: Image.asset('ruta_de_tu_imagen.png'),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.visibility),
                          label: const Text('Ver detalles'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward),
                          label: const Text('Comprar'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                        ),
                      ],
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
