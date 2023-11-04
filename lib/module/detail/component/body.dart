import 'package:appbook/event/add_to_cart_event.dart';
import 'package:appbook/module/home/home_bloc.dart';
import 'package:appbook/shared/constants.dart';
import 'package:appbook/shared/model/product_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int quantityCount = 0;
  //decrement quantity
  void decrementQuantity(){
    setState(() {
      if(quantityCount > 0){
        quantityCount--;
        print(quantityCount);
      }
    });
  }

  void incrementQuantity(){
    setState(() {
      quantityCount++;
      print(quantityCount);
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings?.arguments as Map<String, Object>;
    final name = routeArgs['product'];
    final namebloc = routeArgs['bloc'];

    var products = name as Product;
    var bloc = namebloc as HomeBloc;




    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
          SizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      SafeArea(
                          child: SizedBox(
                            height: 350,
                            width: 350,
                            child: Hero(
                               tag: products.productId,
                                child: Image.network(products.productImage, fit: BoxFit.cover,)
                            ),
                          )
                      ),
                    const SizedBox(height: 10,),
                    Text(products.productName, style: GoogleFonts.lexendDeca().copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(height: 10,),
                    Text('100 g', style: GoogleFonts.quicksand().copyWith(
                        fontSize: 16,
                        color: Colors.grey
                    ),),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            border: Border.all(
                              color: Colors.grey
                            ),

                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed:(){
                                decrementQuantity();
                              }, icon: Icon(Icons.remove)),
                              Text(quantityCount.toString(), style: GoogleFonts.quicksand().copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),),
                              IconButton(onPressed: (){
                                incrementQuantity();
                              }, icon: Icon(Icons.add))
                            ],
                          ),
                        ),
                        Text('50\$',style: GoogleFonts.lexendDeca().copyWith(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text("About the product", style: GoogleFonts.quicksand().copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),),
                    const SizedBox(height: 10,),
                    Text("This character description generator will generate a fairly random description of a belonging to a random race. However, some aspects of the descriptions will remain the same, this is done to keep the general structure the same, while still randomizing the important details. The generator does take into account which race is randomly picked, and changes some of the details accordingly. For example, if the character is an elf, they will have a higher chance of looking good and clean, they will, of course, have an elvish name, and tend to be related to more elvish related towns and people.",
                      style: GoogleFonts.quicksand().copyWith(
                        fontSize: 16,
                        color: Colors.black54,

                      ),
                      textAlign: TextAlign.justify,
                    ),

                  ],
                ),
              ),
            ),
          ),
        Container(
          height: 180,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.topCenter,
              colors: [
                Colors.white,
                Colors.white10
              ]
            )
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.black12,
                  child: CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.white,
                     child: LikeButton(),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: (){
                      if(quantityCount>0){
                        bloc.event.add(AddToCartEvent(product: products));
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            backgroundColor: kPrimaryColor,
                            content: const Text(
                              "Successfuly added to cart",
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              IconButton(
                                  onPressed: (){
                                    //pop once to remove dialog box
                                    Navigator.pop(context);

                                    //pop again to go previous screen

                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.done, color: Colors.white,)
                              )
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFEC449),
                    ),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width/2,
                      child: Center(
                        child: Text(
                          'Add to Cart',
                          style: GoogleFonts.lexendDeca().copyWith(
                              color: Colors.black,
                              fontSize: 16
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
