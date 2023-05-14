import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop_project/common/utils.dart';
import 'package:nike_shop_project/data/Models/product.dart';
import 'package:nike_shop_project/data/repo/banner_repository.dart';
import 'package:nike_shop_project/data/repo/product_repository.dart';
import 'package:nike_shop_project/ui/home/bloc/home_bloc.dart';
import 'package:nike_shop_project/ui/widgets/cache_image.dart';
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
                    itemCount: 5,
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
                        default:
                          return Container();
                      }
                    });
              } else if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(state.exception.msg),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(HomeRefresh());
                          },
                          child: const Text("تلاش دوباره "))
                    ],
                  ),
                );
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
    super.key,
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
                return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: 176,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: 176,
                                height: 189,
                                child: ImageLoadingService(
                                    imageUrl: product.image,
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: const Icon(
                                    CupertinoIcons.heart,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              products[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              products[index].previousprice.WithPriceLable,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      decoration: TextDecoration.lineThrough),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(products[index].price.WithPriceLable),
                          )
                        ],
                      ),
                    ));
              })),
        )
      ],
    );
  }
}
