import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../Repository/api/CategoryAPi.dart';
import '../Repository/modelclass/ProductsModel.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  late CategoryModel categoryModel;
  CategoryApi categoryApi = CategoryApi();
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategory>((event, emit) async{
      emit(CategoryblocLoading());
      try {
        categoryModel = await categoryApi.getCategory(endingpath: event.endingpath);
        emit(CategoryblocLoaded());
      } catch (e) {
        print(e);
        emit(CategoryblocError());
      }
    });
  }
}
