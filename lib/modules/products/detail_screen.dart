import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Producto'),
        backgroundColor: const Color(0xFF4D53DD),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF4D53DD),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Image.network(
              'https://i5.walmartimages.com.mx/mg/gm/3pp/asr/eaaa2151-7d68-467e-8459-26db0eb129e6.372ee831ecc41f5b81fd04ddd0445a85.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF',
              height: size.height / 2.5,
              width: size.width,
            ),
            const Row(
              children: [
                Icon(
                  Icons.shopping_basket,
                  color: Colors.grey,
                ),
                Text(
                  'Apple Inc.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Iphone 11 128GB",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Text(
                    '4.9 Calificación',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ]),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Detalles producto',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4D53DD),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Marca:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Apple',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Color:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Blanco',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
                'Dimensiones:150.9 mm x 75.7 mm x 8.3 mmPeso194g grs.Duración de la batería:Tiempo de conversación: Hasta 65 horasiempo de espera: NATiempo de carga continua: Hasta 10 horasTecnología:Bandas y Frecuencias disponibles'),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Column(
                      children: [
                        Text('Precio Total'),
                        Text(
                          '\$15,000.00',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4D53DD),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 120,
                      decoration: const BoxDecoration(
                          color: Color(0xFF4D53DD),
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: const Center(
                        child: Text(
                          'Comprar',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
