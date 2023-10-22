import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class PageContainer extends StatelessWidget {
  final String title ;
  final Widget child;
  final List<SingleChildWidget> bloc;
  final List<SingleChildWidget> di;

  const PageContainer({
    required this.title,
    required this.di,
    required this.bloc,
    required this.child});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...di,
        ...bloc
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(title,style: TextStyle(color: Colors.white),),
        ),
        body: child,
      ),
    );
  }
}
