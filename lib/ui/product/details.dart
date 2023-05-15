import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop_project/common/utils.dart';
import 'package:nike_shop_project/data/Models/product.dart';
import 'package:nike_shop_project/theme.dart';
import 'package:nike_shop_project/ui/product/comment/comment_list.dart';
import 'package:nike_shop_project/ui/widgets/cache_image.dart';

class ProductsDetail extends StatelessWidget {
  final ProductEntity product;
  const ProductsDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 48,
        child: FloatingActionButton.extended(
            onPressed: () {}, label: const Text("ثبت نظر")),
      ),
      body: CustomScrollView(
        physics: defaultScrollPhysics,
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.width * 0.8,
            flexibleSpace: ImageLoadingService(
              imageUrl: product.image,
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
                        product.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                      Column(
                        children: [
                          Text(
                            product.previousprice.WithPriceLable,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    decoration: TextDecoration.lineThrough),
                          ),
                          Text(product.price.WithPriceLable)
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
          CommentList(productId: product.id)
        ],
      ),
    );
  }
}
