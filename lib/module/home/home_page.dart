import 'package:appbook/base/base_widget.dart';
import 'package:appbook/data/remote/order_service.dart';
import 'package:appbook/data/remote/product_service.dart';
import 'package:appbook/data/repo/order_repo.dart';
import 'package:appbook/data/repo/product_repo.dart';
import 'package:appbook/module/home/component/body.dart';
import 'package:appbook/module/home/home_bloc.dart';
import 'package:appbook/shared/model/order_data.dart';
import 'package:appbook/shared/model/product_data.dart';
import 'package:appbook/shared/model/rest_error.dart';
import 'package:appbook/shared/model/shopping_cart_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        title: '',
        di: [
          Provider.value(value: ProductService()),
          Provider.value(value: OrderService()),
          ProxyProvider<ProductService, ProductRepo>(
              update: (context, productService, previous) =>
                        ProductRepo(productService: productService),
          ),
          ProxyProvider<OrderService, OrderRepo>(
            update: (context, orderService, previous) =>
                      OrderRepo(orderService: orderService),

          )
        ],
        bloc: [],
        actions: [
          ShoppingCartWidget(),
        ],
        child: Body()
    );
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     elevation: 0,
  //     leading: IconButton(icon: SvgPicture.asset('assets/icons/menu.svg'),onPressed: null,),
  //   );
  // }
}

class ShoppingCartWidget extends StatelessWidget {
  const ShoppingCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: HomeBloc.getInstance(
          productRepo: Provider.of(context),
          orderRepo: Provider.of(context)
      ),
      child: CartWidget(),
    );
  }
}

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var bloc = Provider.of<HomeBloc>(context);
    bloc.getShoppingCartInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeBloc>(
          builder: (context, bloc, child) => StreamProvider<Object?>.value(
            value: bloc.shoppingCartStream,
            initialData: null,
            catchError: (context, error){
              return error;
            },
            child: Consumer<Object?>(
              builder: (context, data, child) {
                if(data == null || data is RestError){
                  return Container(
                    margin: EdgeInsets.only(top: 15, right: 20),
                    child: Icon(Icons.shopping_cart),
                  );
                }

                var cart = data as ShoppingCart;
                return Container(
                  margin: EdgeInsets.only(top: 15, right: 20),
                  child: badges.Badge(
                    badgeContent: Text(
                      '${cart.total}',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    child: Icon(Icons.shopping_cart),
                  ),
                );
              },
            ),
          ),
    );
  }
}


class ProductListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: HomeBloc.getInstance(
        productRepo: Provider.of(context),
        orderRepo: Provider.of(context),
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
                    if (data == null) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.yellow,
                        ),
                      );
                    }

                    if (data is RestError) {
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
                    return ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return Text(products[index].productName);
                        });
                  },
                ),
              ),
            ),
      ),
    );
  }

}
