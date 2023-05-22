part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductAddToButtonLoading extends ProductState {}

class ProductAddToButtonError extends ProductState {
  final AppException exception;

  const ProductAddToButtonError(this.exception);
  @override
  
  List<Object> get props => [exception];
}

class ProductAddToButtonSuccess extends ProductState{
  
 }
