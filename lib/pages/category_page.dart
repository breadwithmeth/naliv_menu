import 'package:flutter/material.dart';
import 'package:naliv_menu/misc/api.dart';
import 'package:shimmer/shimmer.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage(
      {super.key, required this.category, required this.businessId});
  final Map<dynamic, dynamic> category;
  final String businessId;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getItems(widget.businessId, widget.category["category_id"], 1)
          .then((value) {
        setState(() {
          items = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.2),
        title: Row(
          children: [
            const Flexible(
              fit: FlexFit.tight,
              child: Text("NALIV"),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Text(
                widget.category["name"],
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
            items.isEmpty
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
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return DraggableScrollableSheet(
                                  builder: (context, scrollController) {
                                    return Placeholder();
                                  },
                                );
                              },
                            );
                          },
                          onHover: (value) {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Image.network(
                                  items[index]['thumb'],
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
                                fit: FlexFit.tight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: RichText(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: items[index]['name'],
                                          style: const TextStyle(
                                            fontSize: 20,
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
