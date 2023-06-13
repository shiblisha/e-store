import 'package:e_store/Bloc/Products/product_bloc.dart';
import 'package:e_store/Repository/modelclass/ProductsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Product extends StatefulWidget {
  final String categoryName;

  const Product({super.key, required this.categoryName});

  @override
  State<Product> createState() => _ProductState();
}
late ProductModel products;
class _ProductState extends State<Product> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(FetchProducts(endingpath: widget.categoryName));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductBloc, ProductState>(
  builder: (context, state) {
      if (state is ProductblocLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ProductblocLoaded) {
        products=BlocProvider.of<ProductBloc>(context).productModel;
    return ListView.separated(itemCount:products.products!.length ,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: mwidth * 0.95,
            height: mheight * 0.05,
            color: Colors.red,
            child: Center(child: Text(products.products![index].title.toString()),),
          );
        }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: mheight*0.02,); },
      );}
      if (state is ProductblocError) {
        return Center(
          child: Text("ERROR"),
        );
      } else {
        return SizedBox();
      }
  },
),
    );
  }
}
