import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Repository/api/ProductApi.dart';
import '../../Repository/modelclass/ProductsModel.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  late ProductModel productModel;
  ProductApi productApi = ProductApi();
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>((event, emit)async {
      emit(ProductblocLoading());
      try {
        productModel = await productApi.getProducts(endingpath: event.endingpath);
        emit(ProductblocLoaded());
      } catch (e) {
        print(e);
        emit(ProductblocError());
      }
      // TODO: implement event handler
    });
  }
}
