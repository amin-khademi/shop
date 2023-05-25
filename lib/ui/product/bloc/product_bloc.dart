import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_shop_project/common/exception.dart';
import 'package:nike_shop_project/data/repo/cart_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ICartRepository cartRepository;
  ProductBloc(this.cartRepository) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      if (event is CartAddButtonClicked) {
        try {
          emit(ProductAddToButtonLoading());
          final result = cartRepository.add(event.productId);
          emit(ProductAddToButtonSuccess());
        } catch (e) {
          emit(ProductAddToButtonError(AppException()));
        }
      }
    });
  }
}
