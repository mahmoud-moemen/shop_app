import 'package:flutter/material.dart';
import 'package:shop_app/shared/component/components.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../login/login_screen.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel(
      {
        required this.image,
        required this.title,
        required this.body});
}

class OnBoardingScreen extends StatefulWidget
{
  OnBoardingScreen ({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController=PageController();

  List<BoardingModel> boarding=[
    BoardingModel(
      image:'assets/images/onBoard1.jpg',
      title:'On Board 1 Title',
      body: 'On Board 1 Title',
    ),
    BoardingModel(
      image:'assets/images/onBoard1.jpg',
      title:'On Board 2 Title',
      body: 'On Board 2 Title',
    ),
    BoardingModel(
      image:'assets/images/onBoard1.jpg',
      title:'On Board 3 Title',
      body: 'On Board 3 Title',
    ),
  ];

  bool isLast=false;

  void submit()// navigateAndFinish w bt save fl cache en onBoarding=true
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value!)
      {
        navigateAndFinish(context, LoginScreen());
      }
    });

  }
  @override

  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(callback:
               submit, text: 'SKIP'),

        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if(index==boarding.length-1)
                    {
                      setState((){
                        isLast= true;
                      });
                      print('last page');
                    }else{
                    setState((){
                      isLast= false;
                    });
                    print('not last page');
                  }
                },
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>BuildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40.0,),
            Row(
              children:
              [
                SmoothPageIndicator(
                    controller:boardController ,
                    count: boarding.length,
                    effect:ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      expansionFactor: 4.0,
                      dotWidth: 10.0,
                      spacing:5.0 ,
                      activeDotColor: defaultColor
                    ) ,
                ),
                Spacer(),
                FloatingActionButton(onPressed: ()
                {
                  if(isLast)
                    {
                      submit();
                    }else
                    {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve:Curves.fastLinearToSlowEaseIn );
                    }

                },
                  child: Icon(Icons.arrow_forward_ios,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(child: Image(image: AssetImage('${model.image}'))),

      Text(
        ' ${model.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 15.0),
      Text(
        ' ${model.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 15.0),

    ],
  );
}
