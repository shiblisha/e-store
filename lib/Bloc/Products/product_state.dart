part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}
class ProductblocLoading extends ProductState{}
class ProductblocLoaded extends ProductState{

}
class ProductblocError extends ProductState{}