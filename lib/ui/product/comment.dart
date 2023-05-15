import 'package:flutter/material.dart';
import 'package:nike_shop_project/data/Models/comments.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity data;
  const CommentItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.titile),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    data.email,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              Text(
                data.date,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            data.content,
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
