import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lovely_coffee/application/styles/color_styles.dart';
import 'package:lovely_coffee/application/styles/heading_styles.dart';
import 'package:lovely_coffee/core/exceptions/unknown_exception.dart';
import 'package:lovely_coffee/application/widgets/text_field_widget.dart';
import 'package:lovely_coffee/modules/home/presenter/cubits/home_cubit.dart';
import 'package:lovely_coffee/application/widgets/elevated_button_widget.dart';
import 'package:lovely_coffee/modules/home/presenter/cubits/home_states.dart';
import 'package:lovely_coffee/application/models/user_local_storage_model.dart';
import 'package:lovely_coffee/core/exceptions/no_device_connection_exception.dart';
import 'package:lovely_coffee/application/constants/exception_messages_const.dart';
import 'package:lovely_coffee/modules/home/presenter/widgets/product_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeCubit = Modular.get<HomeCubit>();
  late UserLocalStorageEntity _userLocalStorageEntity;

  @override
  void initState() {
    homeCubit.fetchInitialData();
    homeCubit.getUserLocalStorage().then(
      (value) {
        setState(() {
          _userLocalStorageEntity = value;
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 190.0,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 161.0,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0XFF424242), Color(0XFF616161)],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _BuildWelcomeText(
                                  name: _userLocalStorageEntity.name),
                              GestureDetector(
                                onTap: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) => _SignOutModal(
                                    onSignOut: () {
                                      homeCubit.signOut();
                                      Modular.to.navigate('/sign-in');
                                    },
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        _userLocalStorageEntity.imageUrl ?? '',
                                    width: 48.0,
                                    height: 48.0,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(
                                      color: ColorStyles.highlight,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/images/caffee.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFieldWidget(
                          hint: 'Search',
                          onSearch: () {},
                          controller: TextEditingController(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeStates>(
                  bloc: homeCubit,
                  builder: (context, state) {
                    if (state is HomeFailedState) {
                      if (state.exception is NoDeviceConnectionException) {
                        return const Center(
                          child: Text(
                            ExceptionMessagesConst.noConnection,
                            style: HeadingStyles.errorMessage,
                          ),
                        );
                      }

                      if (state.exception is UnknownException) {
                        return const Center(
                          child: Text(
                            ExceptionMessagesConst.unknown,
                            style: HeadingStyles.errorMessage,
                          ),
                        );
                      }
                    }

                    if (state is HomeSucceedState) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.59,
                        ),
                        itemCount: state.productList.length,
                        itemBuilder: (BuildContext context, index) {
                          return ProductWidget(
                            product: state.productList[index],
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildWelcomeText extends StatelessWidget {
  const _BuildWelcomeText({Key? key, this.name}) : super(key: key);

  final String? name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: 'Welcome, ',
            style: HeadingStyles.heading18Normal.copyWith(
              color: ColorStyles.heading3,
            ),
            children: [
              TextSpan(
                text: name?.trim().split(' ')[0] ?? '',
                style: HeadingStyles.heading18Bold.copyWith(
                  color: ColorStyles.heading3,
                ),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'You’re ',
            style: HeadingStyles.heading14Normal.copyWith(
              color: ColorStyles.heading3,
            ),
            children: [
              TextSpan(
                text: 'wonderful ',
                style: HeadingStyles.heading14Bold.copyWith(
                  color: ColorStyles.highlight,
                ),
              ),
              const TextSpan(text: 'today !'),
            ],
          ),
        )
      ],
    );
  }
}

class _SignOutModal extends StatelessWidget {
  const _SignOutModal({Key? key, required this.onSignOut}) : super(key: key);

  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 20,
        children: [
          const SizedBox(height: 65.0, width: double.infinity),
          const Text(
            'Would you like to sign out ?',
            style: HeadingStyles.heading18Bold,
          ),
          const SizedBox(height: 38.0, width: double.infinity),
          ElevatedButtonWidget(
            title: 'Continue in the app',
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(height: 15.0, width: double.infinity),
          ElevatedButton(
            onPressed: onSignOut,
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              minimumSize: const Size(double.infinity, 48.0),
              side: const BorderSide(
                width: 1.5,
                color: ColorStyles.highlight,
              ),
            ),
            child: Text(
              'Sign out',
              style: HeadingStyles.heading18Bold.copyWith(
                color: ColorStyles.highlight,
              ),
            ),
          ),
          const SizedBox(height: 62.0, width: double.infinity),
        ],
      ),
    );
  }
}
