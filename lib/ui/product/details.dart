import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop_project/common/utils.dart';
import 'package:nike_shop_project/data/Models/product.dart';
import 'package:nike_shop_project/data/repo/cart_repository.dart';
import 'package:nike_shop_project/theme.dart';
import 'package:nike_shop_project/ui/product/bloc/product_bloc.dart';
import 'package:nike_shop_project/ui/product/comment/comment_list.dart';
import 'package:nike_shop_project/ui/widgets/cache_image.dart';

class ProductsDetail extends StatefulWidget {
  final ProductEntity product;
  const ProductsDetail({super.key, required this.product});

  @override
  State<ProductsDetail> createState() => _ProductsDetailState();
}

class _ProductsDetailState extends State<ProductsDetail> {
  StreamSubscription<ProductState>? stateSubscription = null;
  final GlobalKey<ScaffoldMessengerState> _scafoldKey = GlobalKey();
  @override
  void dispose() {
    stateSubscription?.cancel();
    _scafoldKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (context) {
        final bloc = ProductBloc(cartRepository);
        stateSubscription = bloc.stream.listen(
          (event) {
            if (event is ProductAddToButtonSuccess) {
              _scafoldKey.currentState?.showSnackBar(const SnackBar(
                  content: Text("با موفقیت به سبد خرید شما اضافه شد ")));
            } else if (event is ProductAddToButtonError) {
              _scafoldKey.currentState
                  ?.showSnackBar(SnackBar(content: Text(event.exception.msg)));
            }
          },
        );
        return bloc;
      },
      child: ScaffoldMessenger(
        key: _scafoldKey,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: MediaQuery.of(context).size.width - 48,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) => FloatingActionButton.extended(
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context)
                        .add(CartAddButtonClicked(widget.product.id));
                  },
                  label: state is ProductAddToButtonLoading
                      ? const CircularProgressIndicator()
                      : const Text("افزودن به سبد خرید")),
            ),
          ),
          body: CustomScrollView(
            physics: defaultScrollPhysics,
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width * 0.8,
                flexibleSpace: ImageLoadingService(
                  imageUrl: widget.product.image,
                  borderRadius: BorderRadius.zero,
                ),
                foregroundColor: LightThemeColor.primaryTextColor,
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            widget.product.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                          Column(
                            children: [
                              Text(
                                widget.product.previousprice.WithPriceLable,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        decoration: TextDecoration.lineThrough),
                              ),
                              Text(widget.product.price.WithPriceLable)
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        "این کتونی شدیدا برای  راه رفتن و دویدن مناسب است و تغریبا هیج فشار مخربی را به  زانو ها  وکف پای شما وارد نمی کند .",
                        style: TextStyle(height: 1.2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "نظرات کاربران ",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text("ثبت نظر "))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CommentList(productId: widget.product.id)
            ],
          ),
        ),
      ),
    );
  }
}
