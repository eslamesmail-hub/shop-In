import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_in/cubit/cubit.dart';
import 'package:shop_in/cubit/states.dart';
import 'package:shop_in/models/favorites_model.dart';
import 'package:shop_in/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ShopCubit.get(context).favoritesModel.data.data.length == 0
            ? Center(
                child: Text(
                  'No Favorites yet! try adding some..',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )
            : ConditionalBuilder(
                condition: state is! ShopLoadingGetFavoritesState,
                builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildFavItem(
                    ShopCubit.get(context).favoritesModel.data.data[index],
                    context,
                  ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount:
                      ShopCubit.get(context).favoritesModel.data.data.length,
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(
                    color: defaultColor,
                    backgroundColor: defaultColor.withOpacity(0.3),
                  ),
                ),
              );
      },
    );
  }
}

Widget buildFavItem(
  FavoritesData model,
  context,
) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 100,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: NetworkImage(
                      model.product.image,
                    ),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                if (model.product.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.product.price.toString(),
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (model.product.oldPrice != 0)
                        Text(
                          model.product.oldPrice.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFavorites(model.product.id);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.product.id]
                                  ? defaultColor
                                  : Colors.grey,
                          radius: 15.0,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
