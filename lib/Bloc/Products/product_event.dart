part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}
class FetchProducts extends ProductEvent{
  final String endingpath;
  FetchProducts({required this.endingpath});
}