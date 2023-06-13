part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}
class CategoryblocLoading extends CategoryState{}
class CategoryblocLoaded extends CategoryState{

}
class CategoryblocError extends CategoryState{}