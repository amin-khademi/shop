part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final AppException exception;

  const HomeError({required this.exception});
  @override
  // TODO: implement props
  List<Object> get props => [exception];
}

class HomeSuccess extends HomeState {
  final List<BannerEntity> banners;
  final List<ProductEntity> latestProducts;
  final List<ProductEntity> popularProducts;
  final List<ProductEntity> highToLowProducts;
  final List<ProductEntity> lowToHighProducts;
  

  const HomeSuccess( 
      {required this.banners,
      required this.latestProducts,
      required this.popularProducts,
      required this.highToLowProducts,required this.lowToHighProducts,});
}
