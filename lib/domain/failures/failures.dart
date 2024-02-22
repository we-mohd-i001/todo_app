import 'package:equatable/equatable.dart';

abstract class Failure{}

class ServerFailure extends Failure with EquatableMixin{
  ServerFailure({this.stackTrace});
  final String? stackTrace;

  @override
  // TODO: implement props
  List<Object?> get props => [stackTrace];

}