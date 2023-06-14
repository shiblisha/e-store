import 'package:e_store/Bloc/Products/product_bloc.dart';
import 'package:e_store/Repository/modelclass/ProductsModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Product extends StatefulWidget {
  final String categoryName;

  const Product({super.key, required this.categoryName});

  @override
  State<Product> createState() => _ProductState();
}

List<bool> liked = [];
late ProductModel products;

class _ProductState extends State<Product> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context)
        .add(FetchProducts(endingpath: widget.categoryName));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName.toString(),
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductblocLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductblocLoaded) {
            products = BlocProvider.of<ProductBloc>(context).productModel;
            for (int i=0;i<products.products!.length;i++){
              liked.add(false);
            }
            return ListView.separated(
              itemCount: products.products!.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Container(
                    width: mwidth * 0.95,
                    height: mheight * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff95BDC6).withOpacity(0.22),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: mheight * 0.15,
                          width: mwidth * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              ),
                          child: Image.network(
                            products.products![index].images![0].toString(),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: mwidth * 0.02, top: mheight * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: mheight * 0.05,
                                  width: mwidth * 0.4,
                                  child: Text(
                                    products.products![index].title.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xff0E697C),
                                    ),
                                  )),
                              SizedBox(
                                width: mwidth * 0.02,
                              ),
                              RatingBar.builder(
                                  itemCount: 5,
                                  initialRating: products
                                      .products![index].rating!
                                      .toDouble(),
                                  allowHalfRating: true,
                                  itemSize: 15,
                                  itemBuilder: (ctx, index) => Icon(
                                        Icons.star,
                                        color: Color(0xffFFC113),
                                      ),
                                  onRatingUpdate: (value) {
                                    if (kDebugMode) {
                                      print(value);
                                    }
                                  }),
                              SizedBox(height: mheight * 0.02),
                              Text(
                                '₹${products.products![index].price.toString()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color(0xff0E697C),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: mwidth * 0.05, top: mheight * 0.02),
                          child: IconButton(
                            icon: liked[index] == false
                                ? Icon(Icons.favorite_border,
                                    color: Color(0xff0E697C))
                                : Icon(
                                    Icons.favorite,
                                    color: Color(0xff0E697C),
                                  ),
                            onPressed: () {setState(() {
                              liked[index]=!liked[index];
                            });},
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: mheight * 0.002,
                );
              },
            );
          }
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
