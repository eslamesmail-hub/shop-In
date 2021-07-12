import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_in/models/search_model.dart';
import 'package:shop_in/search/cubit/cubit.dart';
import 'package:shop_in/search/cubit/states.dart';
import 'package:shop_in/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter text to search';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        border: OutlineInputBorder(
                          // on error only
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      onFieldSubmitted: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState)
                      LinearProgressIndicator(
                        color: defaultColor,
                        backgroundColor: defaultColor.withOpacity(0.3),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildSearchItem(
                            SearchCubit.get(context).model.data.data[index],
                            context,
                          ),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount:
                              SearchCubit.get(context).model.data.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildSearchItem(
  Datum model,
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
                      model.image,
                    ),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
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
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
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
