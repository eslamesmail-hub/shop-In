import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_in/login/login_screen.dart';
import 'package:shop_in/shared/network/local/cache_helper.dart';
import 'package:shop_in/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();

  final List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onBoarding.svg',
      title: 'Welcome',
      body: 'Welcome to Shop in e-Commerce app',
    ),
    BoardingModel(
      image: 'assets/images/onBoarding1.svg',
      title: 'About',
      body: 'Here you can find anything you want',
    ),
    BoardingModel(
      image: 'assets/images/onBoarding2.svg',
      title: 'Thanks',
      body: 'Thanks for your time',
    )
  ];

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: submit,
              child: Text(
                'Skip',
                style: TextStyle(
                  color: defaultColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardingController,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardingController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: defaultColor,
                      activeDotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: defaultColor,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardingController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SvgPicture.asset(
              model.image,
            ),
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      );
}
