import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_management/features/home/bloc/home_bloc.dart';
import 'package:product_management/features/home/bloc/home_event.dart';
import 'package:product_management/features/home/bloc/home_state.dart';
import 'package:product_management/features/home/ui/product_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(InitDataFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Products',
          style: TextStyle(),
        ),
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return BottomSheet(
                  onClosing: () {},
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text('Are you sure logout?'),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () => homeBloc
                                .add(OnProfileTappedEvent(context: context)),
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red),
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            icon: const Icon(Icons.person),
          )
        ],
        bottom: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: TextField(
              onChanged: (value) => homeBloc.add(OnSearchEvent(keyword: value)),
              onSubmitted: (value) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            late String productName;
            late double productPrice;
            late int productMeasurement;
            return AlertDialog(
              title: const Text('Add Product'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: 'Product name'),
                    onChanged: (value) => productName = value,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: 'Price'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9]+.?[0-9]*'))
                    ],
                    onChanged: (value) => productPrice = double.parse(value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: const InputDecoration(hintText: 'Measurement'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9]+.?[0-9]*'))
                    ],
                    onChanged: (value) => productMeasurement = int.parse(value),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      homeBloc.add(OnProductAddEvent(
                          productMeasurement: productMeasurement,
                          productName: productName,
                          productPrice: productPrice));

                      Navigator.pop(context);
                    },
                    child: const Text('Add')),
              ],
            );
          },
        ),
        label: const Row(
          children: [
            Text('Add Product'),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.add)
          ],
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          print(state);
          if (state is HomeRefreshDataState) {
            return const CircularProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: homeBloc.products,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('There\'s no products'),
                          );
                        }
                        List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            docList = snapshot.data!.docs;
                        var list = docList
                            .where((element) => (homeBloc.keyword.isEmpty)
                                ? true
                                : element["product_name"]
                                    .toString()
                                    .toLowerCase()
                                    .trim()
                                    .contains(homeBloc.keyword
                                        .toString()
                                        .toLowerCase()
                                        .trim()))
                            .toList();
                        return GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          children: [
                            ...list.map((e) => ProductWidget(
                                  doc: e,
                                  onTap: () => Navigator.pushNamed(
                                      context, '/product-details',
                                      arguments: e),
                                ))
                          ],
                        );
                      }
                      return const Center(
                        child: Text('There\'s no products'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
