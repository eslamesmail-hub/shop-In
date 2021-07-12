import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_in/layout/home_layout.dart';
import 'package:shop_in/login/login_screen.dart';
import 'package:shop_in/register/cubit/cubit.dart';
import 'package:shop_in/register/cubit/states.dart';
import 'package:shop_in/shared/components/components.dart';
import 'package:shop_in/shared/components/constants.dart';
import 'package:shop_in/shared/network/local/cache_helper.dart';
import 'package:shop_in/shared/styles/colors.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
           if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return HomeLayout();
                }), (route) => false);
              });
            } else {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          // ignore: missing_return
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Name must not be empty';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
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
                        ),
                        SizedBox(height: height * 0.02),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          // ignore: missing_return
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Email must not be empty';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
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
                        ),
                        SizedBox(height: height * 0.02),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          // ignore: missing_return
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Password must not be empty';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
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
                            suffixIcon: InkWell(
                              onTap: () {
                                ShopRegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              child: Icon(
                                ShopRegisterCubit.get(context).suffix,
                                color: Colors.grey,
                              ),
                            ),
                          ),

                          obscureText: ShopRegisterCubit.get(context).isPassword,
                        ),
                        SizedBox(height: height * 0.02),
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          // ignore: missing_return
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Phone must not be empty';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            prefixIcon: Icon(Icons.phone),
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
                          onFieldSubmitted: (value) {
                            if (formKey.currentState.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                            }
                          },
                        ),
                        SizedBox(height: height * 0.03),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (BuildContext context) {
                            return InkWell(
                              onTap: () {
                                if (formKey.currentState.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              child: Container(
                                height: 50,
                                color: defaultColor,
                                width: double.infinity,
                                child: Center(
                                    child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )),
                              ),
                            );
                          },
                          fallback: (BuildContext context) => Center(
                            child: CircularProgressIndicator(
                              color: defaultColor,
                        backgroundColor: defaultColor.withOpacity(0.3),
                              
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Do have an account?',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              child: Text(' '),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ));
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: defaultColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
