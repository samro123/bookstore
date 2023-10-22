import 'package:appbook/base/base_bloc.dart';
import 'package:appbook/shared/widget/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LoadingTask extends StatelessWidget {
  final Widget child;
  final BaseBloc bloc;

  const LoadingTask({required this.child, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
        value: bloc.loadingStream,
        initialData: false,
        child: Stack(
          children: [
            child,
            Consumer<bool>(
              builder: (context, isLoading, child) => Center(
                child: isLoading
                    ? ScaleAnimation(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      )
                    ),
                  child: SpinKitPouringHourGlass(
                    color: Colors.white,
                  ),
                  ),
                ) : Container(),
              ),
            )
          ],
        ),
    );
  }
}
