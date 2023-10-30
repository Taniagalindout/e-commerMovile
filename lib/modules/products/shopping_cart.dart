import 'package:e_commerce/kernel/widgets/custom_text.dart';
import 'package:e_commerce/kernel/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShoppingCartWidget extends StatelessWidget {
  const ShoppingCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Carrito de compras'),
        backgroundColor: const Color(0xFF4D53DD),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF4D53DD),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(children: [
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          'https://i5.walmartimages.com.mx/mg/gm/3pp/asr/eaaa2151-7d68-467e-8459-26db0eb129e6.372ee831ecc41f5b81fd04ddd0445a85.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF',
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                          child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: 14),
                              child: const CustomText(
                                text: 'Iphone 11',
                                size: 15,
                                color: Colors.black,
                                weight: FontWeight.normal,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.chevron_left),
                                  onPressed: () {}),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CustomText(
                                  text: '1',
                                  size: 15,
                                  color: Colors.black,
                                  weight: FontWeight.normal,
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.chevron_right),
                                  onPressed: () {}),
                            ],
                          )
                        ],
                      )),
                      const Padding(
                        padding: EdgeInsets.all(14),
                        child: CustomText(
                          text: "\$15,000",
                          size: 22,
                          weight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          'https://img.kwcdn.com/product/Fancyalgo/VirtualModelMatting/d914b27a63fce6d0e5452201b4829b46.jpg?imageView2/2/w/800/q/70/format/webp',
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                          child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: 14),
                              child: const CustomText(
                                text: 'Vestido negro dama',
                                size: 15,
                                color: Colors.black,
                                weight: FontWeight.normal,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.chevron_left),
                                  onPressed: () {}),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CustomText(
                                  text: '1',
                                  size: 15,
                                  color: Colors.black,
                                  weight: FontWeight.normal,
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.chevron_right),
                                  onPressed: () {}),
                            ],
                          )
                        ],
                      )),
                      const Padding(
                        padding: EdgeInsets.all(14),
                        child: CustomText(
                          text: "\$700",
                          size: 22,
                          weight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          'https://m.media-amazon.com/images/I/91hN+j+G7LL._AC_UF894,1000_QL80_.jpg',
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                          child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: 14),
                              child: const CustomText(
                                text: 'The Legend of Zelda',
                                size: 15,
                                color: Colors.black,
                                weight: FontWeight.normal,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.chevron_left),
                                  onPressed: () {}),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CustomText(
                                  text: '1',
                                  size: 15,
                                  color: Colors.black,
                                  weight: FontWeight.normal,
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.chevron_right),
                                  onPressed: () {}),
                            ],
                          )
                        ],
                      )),
                      const Padding(
                        padding: EdgeInsets.all(14),
                        child: CustomText(
                          text: "\$1,600",
                          size: 22,
                          weight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ],
          ),
          Positioned(
              bottom: 30,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'TOTAL A PAGAR:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text(
                              '\$17,300',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      MyButton(
                        isDisabled: false,
                        title: 'PAGAR',
                        onTap: () {},
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
