import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lovely_coffee/application/styles/color_styles.dart';
import 'package:lovely_coffee/application/styles/heading_styles.dart';
import 'package:lovely_coffee/modules/home/presenter/cubits/home_cubit.dart';
import 'package:lovely_coffee/modules/home/domain/entities/product_entity.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key, required this.product}) : super(key: key);

  final ProductEntity product;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool isFavorite = false;
  final homeCubit = Modular.get<HomeCubit>();

  @override
  void initState() {
    isFavorite = widget.product.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.product.imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      width: constraints.minWidth,
                      height: constraints.minHeight * 0.59,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => SizedBox(
                      width: constraints.minWidth,
                      height: constraints.minHeight * 0.59,
                      child: const Padding(
                        padding: EdgeInsets.all(60.0),
                        child: CircularProgressIndicator(
                          color: Color(0XFFD17843),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/no-image.png'),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: LikeButton(
                          onTap: (isFavorite) async {
                            final bool isSuccess =
                                await homeCubit.addOrRemoveProductToFavorites(
                              widget.product.id,
                            );

                            if (isSuccess) {
                              return !isFavorite;
                            }

                            return isFavorite;
                          },
                          circleColor: const CircleColor(
                            start: Color(0XFFEB5757),
                            end: Color(0XFFEB5757),
                          ),
                          bubblesColor: const BubblesColor(
                            dotPrimaryColor: Color(0XFFEB5757),
                            dotSecondaryColor: Color(0XFFEB5757),
                          ),
                          likeBuilder: (isFavorite) {
                            return Icon(
                              Icons.favorite,
                              color: isFavorite
                                  ? const Color(0XFFEB5757)
                                  : Colors.grey,
                              size: 30,
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                widget.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: HeadingStyles.heading18Bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                widget.product.additionalInfo,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: HeadingStyles.heading16Medium.copyWith(
                  color: ColorStyles.heading2,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: '\$ ',
                  style: HeadingStyles.heading20Bold.copyWith(
                    color: ColorStyles.highlight,
                  ),
                  children: [
                    TextSpan(
                      text: '${widget.product.price}',
                      style: HeadingStyles.heading20Bold,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
