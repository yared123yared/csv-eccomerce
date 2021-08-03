// import 'dart:async';

// import 'package:app/models/product/data.dart';
// import 'package:app/models/product/product.dart';
// import 'package:app/repository/product_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'produt_event.dart';
// part 'produt_state.dart';

// class ProductBloc extends Bloc<ProdutEvent, ProductState> {
//   final ProductRepository productRepository;
//   List<Products> productList=[];
//   int page=0;
//   ProductBloc({required this.productRepository})
//       : assert(productRepository != null),
//         super(ProductLoading());
//   @override
//   Stream<ProductState> mapEventToState(
//     ProdutEvent event,
//   ) async* {
//     // TODO: implement mapEventToState
//     if(event is FetchProduct()){
//       yield ProductLoading();
//       try{
//         page ++;
//         Products products= await  this.productRepository.getProducts(page);
//         if(products.data==null){
//           page --;
//           yield ProductOperationFailure(message: "Failed to fetch products");
//         }else{
//           // productList.addAll(products);
//         }

//       }catch(e){

//       }
//     }
//   }
// }
