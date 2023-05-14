import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_shop_project/data/models/banner.dart';
import 'package:nike_shop_project/data/repo/banner_repository.dart';
import 'package:nike_shop_project/data/repo/product_repository.dart';
import 'package:nike_shop_project/ui/home/bloc/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
