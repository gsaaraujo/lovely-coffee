import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lovely_coffee/application/styles/color_styles.dart';
import 'package:lovely_coffee/application/styles/heading_styles.dart';
import 'package:lovely_coffee/application/widgets/text_field_widget.dart';
import 'package:lovely_coffee/modules/home/presenter/cubits/home_cubit.dart';
import 'package:lovely_coffee/modules/home/presenter/widgets/products_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final _homeCubit = Modular.get<HomeCubit>();

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
                              const _BuildWelcomeText(name: 'Gabriel'),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "http://via.placeholder.com/350x150",
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
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.59,
                  ),
                  // itemCount: myProducts.length,
                  itemBuilder: (BuildContext context, index) {
                    return const ProductsWidget();
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
