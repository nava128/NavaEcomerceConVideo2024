import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/category.dart';
import '../utils/screen_utils.dart';
import '../widgets/custom_nav_bar.dart';
import '../widgets/deal_card.dart';
import '../widgets/indi_deal_card.dart';
import '../widgets/tab_title.dart';
import './search_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
      Category(
        'Vegetables',
        'assets/images/vegetable_home.png',
        kAccentGreen,
      ),
      Category(
        'Fruits',
        'assets/images/fruit_home.png',
        kAccentRed,
      ),
      Category(
        'Milks & Egg',
        'assets/images/egg_home.png',
        kAccentYellow,
      ),
      Category(
        'Meat',
        'assets/images/meat_home.png',
        kAccentPurple,
      ),
    ];
    ScreenUtils().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            HomeAppBar(),
            Spacer(),
            CategoryTab(categories: categories),
            Spacer(),
            DealsTab(),
            Spacer(),
            PopularDealTab(),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}

class PopularDealTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Column(
        children: [
          TabTitle('Popular Deals', () {}),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: getProportionateScreenWidth(8),
              ),
              children: [
                IndiDealCard(
                  isLeft: true,
                  isSelected: true,
                ),
                IndiDealCard(
                  isLeft: false,
                  isSelected: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DealsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabTitle('Special Deals for You', () {}),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DealCard(),
              DealCard(),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    Key key,
    @required this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(16.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              TextButton(
                onPressed: () {
                  /// TODO: add routes
                },
                child: Text(
                  'See All',
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              categories.length,
              (index) => CategoryCard(categories[index]),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard(
    this.category,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: getProportionateScreenWidth(24),
          backgroundColor: category.color,
          child: SizedBox(
            width: getProportionateScreenWidth(28),
            child: Image.asset(
              category.catIcon,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(category.catName)
      ],
    );
  }
}

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(
          16,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Planet Namex 989',
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  'Norristown, Pennsyvlvania, 19403',
                  style: TextStyle(
                    color: kTextColorAccent,
                    fontSize: getProportionateScreenWidth(
                      12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
            child: Icon(
              Icons.search,
              color: kPrimaryGreen,
            ),
          ),
        ],
      ),
    );
  }
}