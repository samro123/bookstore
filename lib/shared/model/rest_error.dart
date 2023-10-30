class RestError{
  String message;
  RestError({required this.message});
  factory RestError.fromData(String mgs){
    return RestError(message: mgs);
  }
}