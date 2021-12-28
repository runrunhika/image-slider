import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = CarouselController();
  int activeIndex = 0;
  final urlImages = [
    'https://10wallpaper.com/wallpaper/medium/1512/Assassins_creed_arno_dorian-PC_Game_HD_Wallpaper_medium.jpg',
    'https://wallpaperaccess.com/full/910880.jpg',
    'https://pc-onlinegames.com/wp-content/uploads/2015/02/pcgame19-1.jpg',
    'https://i.ytimg.com/vi/uvZo59uhz5E/sddefault.jpg#404_is_fine',
    'https://www.pcgamesn.com/wp-content/uploads/2020/01/wolcen-best-new-pc-games.jpg',
    'https://cdn.akamai.steamstatic.com/steam/apps/814380/header.jpg?t=1603904569',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: urlImages.length,
              options: CarouselOptions(
                  height: 400,
                  initialPage: 0,
                  // viewportFraction: 1,
                  // pageSnapping: false,
                  // enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  // autoPlay: true,
                  // reverse: true,
                  autoPlayAnimationDuration: Duration(seconds: 2),
                  onPageChanged: (index, reason) {
                    setState(() {
                      activeIndex = index;
                    });
                  }),
              itemBuilder: (ctx, index, realIndex) {
                final urlImage = urlImages[index];
                return buildImage(urlImage, index);
              },
            ),
            const SizedBox(
              height: 32,
            ),
            buildIndicator(),
            const SizedBox(
              height: 32,
            ),
            buildButton(stretch: true)
          ],
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
      // 画像と画像の距離
      margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: urlImages.length,
      onDotClicked: animateToSlide,
      // should show to pub dev
      effect: JumpingDotEffect(
          dotWidth: 20,
          dotHeight: 20,
          activeDotColor: Colors.red,
          dotColor: Colors.black12),
    );
  }

  Widget buildButton({bool stretch = false}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 15)),
              onPressed: next,
              child: Icon(
                Icons.arrow_back,
                size: 32,
              )),
          stretch
              ? Spacer()
              : SizedBox(
                  width: 32,
                ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 15)),
              onPressed: previous,
              child: Icon(
                Icons.arrow_forward,
                size: 32,
              ))
        ],
      );

  void animateToSlide(int index) => controller.animateToPage(index);

  void previous() => controller.nextPage(duration: Duration(seconds: 1));

  void next() => controller.previousPage(duration: Duration(seconds: 1));
}
