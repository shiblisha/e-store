part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}
class FetchCategory extends CategoryEvent{
 final String endingpath;
 FetchCategory({required this.endingpath});
}