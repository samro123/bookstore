import 'package:appbook/module/home/component/header_with_search_box.dart';
import 'package:appbook/module/home/component/tile_with_under_line.dart';
import 'package:appbook/module/home/component/title_with_more_btn.dart';
import 'package:appbook/module/home/home_bloc.dart';
import 'package:appbook/shared/constants.dart';
import 'package:appbook/shared/model/product_data.dart';
import 'package:appbook/shared/model/rest_error.dart';
import 'package:appbook/shared/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: HomeBloc.getInstance(
          productRepo: Provider.of(context),
          orderRepo: Provider.of(context)
      ),
      child: Consumer<HomeBloc>(
        builder: (context, bloc, child) =>
        Container(
          child: StreamProvider<Object?>.value(
              value: bloc.getProductList(),
              initialData: null,
              catchError: (context, error) {
                return error;
              },
            child: Consumer<Object?>(
              builder: (context, data, child) {
                if (data == null){
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.yellow,
                    ),
                  );
                }

                if (data is RestError){
                  return Center(
                    child: Container(
                      child: Text(
                        data.message,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                }

                var products = data as List<Product>;
                return Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        HeaderWithSearchBox(size: size),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: Row(
                            children: [
                              TileWithUnderLine(text: "Recommended",),
                              Spacer(),
                              TitleWithMoreBtn(title: "More", press: (){},)
                            ],
                          ),

                        ),
                        //it will cover 40% of our total width
                        Container(
                          height: size.height * 0.6,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder:(context, index) {
                              return RecomendCard(
                                  image: products[index].productImage,
                                  title: products[index].productName,
                                  country: products[index].productId,
                                  price: products[index].price,
                                  press: (){
                                    Navigator.pushNamed(context, '/detail');
                                  },
                                  pressBuy: (){

                                  },
                              );
                            },),
                        )
                      ],
                    ),
                  ),
                );
              },

            ),
          ),
        )
        ,
      ),
    );
  }
}

class RecomendCard extends StatelessWidget {
  final String image, title, country;
  final double price;
  final Function() press;
  final Function() pressBuy;
  const RecomendCard({
    super.key,
    required this.image,
    required this.title,
    required this.country,
    required this.price,
    required this.press,
    required this.pressBuy
  });



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          top: kDefaultPadding /2,
          bottom: kDefaultPadding * 2.5
      ),
      width: size.width * 0.4,
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(image),
              Positioned(
                right: -20,
                top: -10,
                child: GestureDetector(
                  onTap: pressBuy,
                  child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimaryColor,
                    border: Border.all(width: 3, color: Colors.white)
                  ),
                  child: Center(child: Text("Buy", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),)),
              ),
                ))
            ],
            clipBehavior: Clip.none,
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23)
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                             Text("$title".toUpperCase(),
                               // style: Theme.of(context).textTheme.button,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                          Text("$country",
                              style: TextStyle(
                                  color: kPrimaryColor.withOpacity(0.5),

                              ),
                          maxLines: 1,)
                        ],
                      ),

                  ),
                  Text("\$$price",
                    style: Theme.of(context)
                        .textTheme.button!
                        .copyWith(color: kPrimaryColor),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}






