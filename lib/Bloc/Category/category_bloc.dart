

import 'package:bloc/bloc.dart';
import 'package:e_store/Repository/api/CategoryApi.dart';
import 'package:meta/meta.dart';

import '../../Repository/modelclass/CategoryModel.dart';



part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  late CategoryModel categoryModel;
  CategoryApi categoryApi = CategoryApi();
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategory>((event, emit)async {
      emit(CategoryblocLoading());
      try {
        categoryModel=await categoryApi.getCategory();
        emit(CategoryblocLoaded());
      } catch (e) {
        print(e);
        emit(CategoryblocError());
      }
      // TODO: implement event handler
    });
  }
}
