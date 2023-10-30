import 'package:e_commerce/modules/products/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://as2.ftcdn.net/v2/jpg/04/62/99/95/1000_F_462999568_6XLccvVROTHh0ZTpMkf1UYEnkv46Mh1v.jpg',
  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/shoes-sale-bannuer-design-template-38d8c87b5b44afb4906d2d55743a98ae_screen.jpg?ts=1616352652',
  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fashion-sale-banner-template-design-4772368bb4e85c49923b38d0c7cd5fc6_screen.jpg?ts=1649240579',
  'https://marketplace.canva.com/EAFEhUK_WdY/1/0/1600w/canva-banner-para-mercado-shops-tienda-de-celulares-moderno-negro-AWRKN423ZV0.jpg',
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MainAppState();
}

class _MainAppState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  bool _showButtons = false;
  void _scrollTo(bool forward) {
    final double offset = forward
        ? _scrollController.offset + 200.0
        : _scrollController.offset - 200.0;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  Color temaOscuro = Colors.black;
  Color temaDefault = const Color(0xFF4D53DD);
  Color temaActual = const Color(0xFF4D53DD);
  Color background = const Color.fromARGB(255, 236, 236, 236);
  Color darkBackground = const Color.fromARGB(255, 43, 40, 40);
  Color lightbackground = const Color.fromARGB(255, 236, 236, 236);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        item,
                        height: 1000.0,
                        width: size.width,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();
    double ar = 2.5;
    double carrito = size.width;
    double categoryHeight = size.height / 4;
    double categoryMax = 200;
    if (size.width > size.height) {
      ar = 4 / 1;
      carrito = size.width / 2;
      categoryHeight = size.height / 2;
      categoryMax = size.width / 2.5;
    } else {
      ar = 2.5;
      carrito = size.width;
      categoryHeight = size.height / 4;
      categoryMax = size.width / 1.5;
    }
    Widget imageCarousel = CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: ar,
        enlargeCenterPage: true,
      ),
      items: imageSliders,
    );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _scaffoldkey,
          backgroundColor: background,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: temaActual,
            ),
            backgroundColor: temaActual,
            title: const Text('E-commerce'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
              StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return IconButton(
                    icon: const Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: () {
                      _scaffoldkey.currentState!.openEndDrawer();
                    },
                  );
                },
              )
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: temaActual),
                    accountName: const Text('Samuel Cano'),
                    accountEmail: const Text('20193tn131@utez.edu.mx'),
                    currentAccountPicture: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/profile');
                      },
                      
                      child: const CircleAvatar(backgroundColor: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const ListTile(
                      title: Text('Home'),
                      leading: Icon(Icons.home),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const ListTile(
                      title: Text('Mis compras'),
                      leading: Icon(Icons.shop),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const ListTile(
                    title: Text('Wishlist'),
                    leading: Icon(Icons.star),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () {},
                  child: const ListTile(
                    title: Text('Settings'),
                    leading: Icon(Icons.settings),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (temaActual == temaDefault) {
                      temaActual = temaOscuro;
                      background = darkBackground;
                    } else {
                      temaActual = temaDefault;
                      background = lightbackground;
                    }
                    setState(() {});
                  },
                  child: const ListTile(
                    title: Text('Cambiar Tema'),
                    leading: Icon(Icons.dark_mode),
                  ),
                )
              ],
            ),
          ),
          endDrawer: Drawer(
            width: carrito,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: const <Widget>[Text('Carrito de compras')],
            ),
          ),
          body: ListView(
            children: <Widget>[
              imageCarousel,
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Row(
                  children: [
                    Container(
                      height: 90,
                      width: size.width,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: const Icon(
                                      Icons.computer,
                                      size: 30,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Tecnología',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: const Icon(
                                      Icons.shop,
                                      size: 30,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Ropa',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: const Icon(
                                      Icons.gamepad,
                                      size: 30,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Videojuegos',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: const Icon(
                                      Icons.house,
                                      size: 30,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Hogar',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: const Icon(
                                      Icons.tv,
                                      size: 30,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'TV\'s',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 22.0, top: 10.0),
                  child: const Text(
                    'Celulares',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
              /*SafeArea(
                child:*/
              SizedBox(
                  width: double.infinity,
                  height: categoryHeight,
                  child: MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          _showButtons = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          _showButtons = false;
                        });
                      },
                      child: Stack(children: [
                        GridView(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          padding: const EdgeInsets.all(5),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: categoryMax,
                                  childAspectRatio: 1.2 / 1,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2),
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const DetailPage()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GridTile(
                                    footer: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  234, 255, 255, 255),
                                            ),
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    bottom:
                                                        Radius.circular(10))),
                                        child: const ListTile(
                                            title: Text(
                                              'Iphone 13 128GB',
                                              style: TextStyle(fontSize: 14.0),
                                            ),
                                            subtitle: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                  size: 15,
                                                ),
                                                Text(
                                                  '4.9 | 2336',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '\$15,000',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                      color: Color(0xFF4D53DD)),
                                                )
                                              ],
                                            ))),
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          'https://i5.walmartimages.com.mx/mg/gm/3pp/asr/eaaa2151-7d68-467e-8459-26db0eb129e6.372ee831ecc41f5b81fd04ddd0445a85.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF',
                                          alignment: Alignment.topCenter,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: GridTile(
                                  footer: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                234, 255, 255, 255),
                                          ),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  bottom: Radius.circular(10))),
                                      child: const ListTile(
                                          title: Text(
                                            'Iphone 13 128GB',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                                size: 15,
                                              ),
                                              Text(
                                                '4.9 | 2336',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '\$15,000',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Color(0xFF4D53DD)),
                                              )
                                            ],
                                          ))),
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://i5.walmartimages.com.mx/mg/gm/3pp/asr/eaaa2151-7d68-467e-8459-26db0eb129e6.372ee831ecc41f5b81fd04ddd0445a85.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF',
                                        alignment: Alignment.topCenter,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: GridTile(
                                  footer: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                234, 255, 255, 255),
                                          ),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  bottom: Radius.circular(10))),
                                      child: const ListTile(
                                          title: Text(
                                            'Iphone 13 128GB',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                                size: 15,
                                              ),
                                              Text(
                                                '4.9 | 2336',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '\$15,000',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Color(0xFF4D53DD)),
                                              )
                                            ],
                                          ))),
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://i5.walmartimages.com.mx/mg/gm/3pp/asr/eaaa2151-7d68-467e-8459-26db0eb129e6.372ee831ecc41f5b81fd04ddd0445a85.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF',
                                        alignment: Alignment.topCenter,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: GridTile(
                                  footer: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                234, 255, 255, 255),
                                          ),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  bottom: Radius.circular(10))),
                                      child: const ListTile(
                                          title: Text(
                                            'Iphone 13 128GB',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                                size: 15,
                                              ),
                                              Text(
                                                '4.9 | 2336',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '\$15,000',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Color(0xFF4D53DD)),
                                              )
                                            ],
                                          ))),
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://i5.walmartimages.com.mx/mg/gm/3pp/asr/eaaa2151-7d68-467e-8459-26db0eb129e6.372ee831ecc41f5b81fd04ddd0445a85.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF',
                                        alignment: Alignment.topCenter,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: GridTile(
                                  footer: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                234, 255, 255, 255),
                                          ),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  bottom: Radius.circular(10))),
                                      child: const ListTile(
                                          title: Text(
                                            'Iphone 13 128GB',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                                size: 15,
                                              ),
                                              Text(
                                                '4.9 | 2336',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '\$15,000',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Color(0xFF4D53DD)),
                                              )
                                            ],
                                          ))),
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://i5.walmartimages.com.mx/mg/gm/3pp/asr/eaaa2151-7d68-467e-8459-26db0eb129e6.372ee831ecc41f5b81fd04ddd0445a85.jpeg?odnHeight=612&odnWidth=612&odnBg=FFFFFF',
                                        alignment: Alignment.topCenter,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_showButtons)
                          Positioned(
                            left: 0,
                            top: categoryHeight / 2.5,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () => _scrollTo(false),
                            ),
                          ),
                        if (_showButtons)
                          Positioned(
                            right: 0,
                            top: categoryHeight / 2.5,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: () => _scrollTo(true),
                            ),
                          ),
                      ]))),
              Container(
                  padding: const EdgeInsets.only(left: 22.0, top: 10.0),
                  child: const Text(
                    'Ropa',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
              SafeArea(
                  child: SizedBox(
                      width: double.infinity,
                      height: categoryHeight,
                      child: GridView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(5),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: categoryMax,
                            childAspectRatio: 1.2 / 1,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2),
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: GridTile(
                                footer: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              234, 255, 255, 255),
                                        ),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(10))),
                                    child: const ListTile(
                                        title: Text(
                                          'Vestido Dama',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 15,
                                            ),
                                            Text(
                                              '4.9 | 2336',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '\$700',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Color(0xFF4D53DD)),
                                            )
                                          ],
                                        ))),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://img.kwcdn.com/product/Fancyalgo/VirtualModelMatting/d914b27a63fce6d0e5452201b4829b46.jpg?imageView2/2/w/800/q/70/format/webp',
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: GridTile(
                                footer: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              234, 255, 255, 255),
                                        ),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(10))),
                                    child: const ListTile(
                                        title: Text(
                                          'Vestido Dama',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 15,
                                            ),
                                            Text(
                                              '4.9 | 2336',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '\$700',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Color(0xFF4D53DD)),
                                            )
                                          ],
                                        ))),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://img.kwcdn.com/product/Fancyalgo/VirtualModelMatting/d914b27a63fce6d0e5452201b4829b46.jpg?imageView2/2/w/800/q/70/format/webp',
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: GridTile(
                                footer: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              234, 255, 255, 255),
                                        ),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(10))),
                                    child: const ListTile(
                                        title: Text(
                                          'Vestido Dama',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 15,
                                            ),
                                            Text(
                                              '4.9 | 2336',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '\$700',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Color(0xFF4D53DD)),
                                            )
                                          ],
                                        ))),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://img.kwcdn.com/product/Fancyalgo/VirtualModelMatting/d914b27a63fce6d0e5452201b4829b46.jpg?imageView2/2/w/800/q/70/format/webp',
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: GridTile(
                                footer: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              234, 255, 255, 255),
                                        ),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(10))),
                                    child: const ListTile(
                                        title: Text(
                                          'Vestido Dama',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 15,
                                            ),
                                            Text(
                                              '4.9 | 2336',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '\$700',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Color(0xFF4D53DD)),
                                            )
                                          ],
                                        ))),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://img.kwcdn.com/product/Fancyalgo/VirtualModelMatting/d914b27a63fce6d0e5452201b4829b46.jpg?imageView2/2/w/800/q/70/format/webp',
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: GridTile(
                                footer: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              234, 255, 255, 255),
                                        ),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(10))),
                                    child: const ListTile(
                                        title: Text(
                                          'Vestido Dama',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 15,
                                            ),
                                            Text(
                                              '4.9 | 2336',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '\$700',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Color(0xFF4D53DD)),
                                            )
                                          ],
                                        ))),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://img.kwcdn.com/product/Fancyalgo/VirtualModelMatting/d914b27a63fce6d0e5452201b4829b46.jpg?imageView2/2/w/800/q/70/format/webp',
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))),
              Container(
                  padding: const EdgeInsets.only(left: 22.0, top: 10.0),
                  child: const Text(
                    'Videojuegos',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
              SafeArea(
                  child: SizedBox(
                      width: double.infinity,
                      height: categoryHeight,
                      child: GridView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(5),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: categoryMax,
                            childAspectRatio: 1.2 / 1,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2),
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: GridTile(
                                footer: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              234, 255, 255, 255),
                                        ),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(10))),
                                    child: const ListTile(
                                        title: Text(
                                          'Zelda Tears of the Kingdom',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 15,
                                            ),
                                            Text(
                                              '4.9 | 2336',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '\$1600',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Color(0xFF4D53DD)),
                                            )
                                          ],
                                        ))),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://m.media-amazon.com/images/I/91hN+j+G7LL._AC_UF894,1000_QL80_.jpg',
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: GridTile(
                                footer: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              234, 255, 255, 255),
                                        ),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(10))),
                                    child: const ListTile(
                                        title: Text(
                                          'Zelda Tears of the Kingdom',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 15,
                                            ),
                                            Text(
                                              '4.9 | 2336',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '\$1600',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Color(0xFF4D53DD)),
                                            )
                                          ],
                                        ))),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://m.media-amazon.com/images/I/91hN+j+G7LL._AC_UF894,1000_QL80_.jpg',
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: GridTile(
                                footer: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              234, 255, 255, 255),
                                        ),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(10))),
                                    child: const ListTile(
                                        title: Text(
                                          'Zelda Tears of the Kingdom',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 15,
                                            ),
                                            Text(
                                              '4.9 | 2336',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '\$1600',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Color(0xFF4D53DD)),
                                            )
                                          ],
                                        ))),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://m.media-amazon.com/images/I/91hN+j+G7LL._AC_UF894,1000_QL80_.jpg',
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: GridTile(
                                footer: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              234, 255, 255, 255),
                                        ),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(10))),
                                    child: const ListTile(
                                        title: Text(
                                          'Zelda Tears of the Kingdom',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 15,
                                            ),
                                            Text(
                                              '4.9 | 2336',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '\$1600',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Color(0xFF4D53DD)),
                                            )
                                          ],
                                        ))),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://m.media-amazon.com/images/I/91hN+j+G7LL._AC_UF894,1000_QL80_.jpg',
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: GridTile(
                                footer: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              234, 255, 255, 255),
                                        ),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                bottom: Radius.circular(10))),
                                    child: const ListTile(
                                        title: Text(
                                          'Zelda Tears of the Kingdom',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 15,
                                            ),
                                            Text(
                                              '4.9 | 2336',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '\$1600',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Color(0xFF4D53DD)),
                                            )
                                          ],
                                        ))),
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      'https://m.media-amazon.com/images/I/91hN+j+G7LL._AC_UF894,1000_QL80_.jpg',
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ));
  }
}
