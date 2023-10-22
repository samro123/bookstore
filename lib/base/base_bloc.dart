import 'dart:async';

import 'package:appbook/base/base_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc{
  StreamController<BaseEvent> _eventStreamCotroller = StreamController<BaseEvent>();
  Sink<BaseEvent> get event => _eventStreamCotroller.sink;


  BaseBloc(){
    _eventStreamCotroller.stream.listen((event) {
      if(event is! BaseEvent){
        throw Exception("Invaild event");
      }
      dispatchEvnet(event);
    });
  }
  //loading UI event
  StreamController<bool> _loadingStreamController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingStreamController.stream;
  Sink<bool> get loadingSink => _loadingStreamController.sink;

  //process Event
  StreamController<BaseEvent> _processEventSubject = BehaviorSubject<BaseEvent>();
  Stream<BaseEvent> get processEventStream => _processEventSubject.stream;
  Sink<BaseEvent> get processEventSink => _processEventSubject.sink;

  void dispatchEvnet(BaseEvent event);
  @mustCallSuper
  void dispose(){
    _eventStreamCotroller.close();
    _loadingStreamController.close();
    _processEventSubject.close();
  }
}