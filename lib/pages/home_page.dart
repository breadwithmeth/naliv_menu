import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naliv_menu/misc/api.dart';
import 'package:naliv_menu/pages/category_page.dart';
import 'package:shimmer/shimmer.dart';

// Uri.base.queryParametersAll

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String businessId =
      "1"; //! TODO: CHANGE HARDCDED VALUE, IT WILL BE SET VIA URI MODULE
  List<dynamic> categories = [];
  List<dynamic> businesses = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getCategories(businessId).then((value) {
        setState(() {
          categories = value;
        });
      });
      await getBusinesses().then((value) {
        if (value != null) {
          setState(() {
            businesses = value;
          });
        } else {
          print("No businesses found");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: Placeholder(),
      ),
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        title: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: businesses.isEmpty
                  ? const Text("NALIV")
                  : Image.network(
                      businesses[int.parse(businessId)]["logo"],
                    ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Text(
                businesses.isEmpty
                    ? ""
                    : businesses[int.parse(businessId)]["address"],
                textAlign: TextAlign.end,
                style: const TextStyle(
                  letterSpacing: 2,
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        titleTextStyle: const TextStyle(
          letterSpacing: 5,
          fontSize: 32,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [
            categories.isEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 4 / 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 9,
                    itemBuilder: (BuildContext ctx, index) {
                      return Shimmer.fromColors(
                        baseColor: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.05),
                        highlightColor: Theme.of(context).colorScheme.secondary,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                            color: Colors.white,
                          ),
                          child: null,
                        ),
                      );
                    },
                  )
                : Center(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 4 / 5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CategoryPage(
                                    category: categories[index],
                                    businessId: businessId,
                                  );
                                },
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                flex: 4,
                                child: Image.network(
                                  categories[index]['photo'],
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      alignment: Alignment.center,
                                      child: const Text("No image"),
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    double loadingDouble = 0.0;
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      if (loadingProgress.expectedTotalBytes !=
                                          null) {
                                        loadingDouble = loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!;
                                      }
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingDouble,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: categories[index]['name'],
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
