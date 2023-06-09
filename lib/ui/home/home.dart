import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop_project/common/utils.dart';
import 'package:nike_shop_project/data/Models/product.dart';
import 'package:nike_shop_project/data/repo/banner_repository.dart';
import 'package:nike_shop_project/data/repo/product_repository.dart';
import 'package:nike_shop_project/ui/home/bloc/home_bloc.dart';
import 'package:nike_shop_project/ui/product/product.dart';
import 'package:nike_shop_project/ui/widgets/error.dart';
import 'package:nike_shop_project/ui/widgets/slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homebloc = HomeBloc(
            bannerRepository: bannerRepository,
            productRepository: productRepository);

        homebloc.add(HomeStarted());
        return homebloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: ((context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                    physics: defaultScrollPhysics,
                    itemCount: 6,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Container(
                            height: 56,
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/img/nike_logo.png",
                              fit: BoxFit.fitHeight,
                              height: MediaQuery.of(context).size.height / 32,
                            ),
                          );
                        case 1:
                          return BannerSlider(
                            banners: state.banners,
                          );
                        case 2:
                          return _HorizontalProductList(
                            title: "جدید ترین",
                            products: state.latestProducts,
                            onTap: () {},
                          );
                        case 3:
                          return _HorizontalProductList(
                            title: "پرفروش ترین",
                            products: state.popularProducts,
                            onTap: () {},
                          );
                          case 4:
                            return _HorizontalProductList(
                            title: "اجناس پر بها",
                            products: state.highToLowProducts,
                            onTap: () {},
                          );
                          case 5:
                            return _HorizontalProductList(
                            title: "اجناس کم بها",
                            products: state.lowToHighProducts,
                            onTap: () {},
                          );
                        default:
                          return Container(
                            height: 0,
                          );
                      }
                    });
              } else if (state is HomeLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state is HomeError) {
                return AppErrorWidget(
                    exception: state.exception,
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                    });
              } else {
                throw Exception("state is not supported ");
              }
            }),
          ),
        ),
      ),
    );
  }
}

class _HorizontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductEntity> products;
  const _HorizontalProductList({
    required this.title,
    required this.onTap,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              TextButton(onPressed: onTap, child: const Text("مشاهده همه"))
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              physics: defaultScrollPhysics,
              itemBuilder: ((context, index) {
                final product = products[index];
                return ProductItem(
                  product: product,
                  borderRadius: BorderRadius.zero,
                );
              })),
        )
      ],
    );
  }
}
