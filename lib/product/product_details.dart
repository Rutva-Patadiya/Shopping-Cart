import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/favorite_page/favorite_page.dart';
import 'package:shopping_cart/l10n/translation_extension.dart';
import 'package:shopping_cart/product/bloc/product_event.dart';
import 'package:shopping_cart/product/bloc/product_state.dart';
import 'package:shopping_cart/product/domain/entities/product.dart';
import 'package:shopping_cart/product/select_size_list.dart';

import '../cart/cart_page.dart';
import '../core/utils/theme/text_theme.dart';
import '../core/utils/theme/theme.dart';
import 'bloc/product_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  static const route = "product_details";

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
    if (widget.product.categoryName == "Clothing") {
      context.read<ProductBloc>().add(ProductSizeLoaded(widget.product));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey, width: 1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 12),
                        child: Text(
                          context.loc.totalPrice,
                          style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
                            color: Colors.black54,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          "\$${widget.product.price.toString()} ",
                          style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 32),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(220, 50),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, CartPage.route);
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Icon(Icons.shopping_bag_rounded, size: 20),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            context.loc.addToCart,
                            textAlign: TextAlign.center,
                            style: TTextTheme.lightTextTheme.headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  height: 0.5,
                                  letterSpacing: 0,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            widget.product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 64,
                          left: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 64,
                          right: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  FavoritePage.route,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32, left: 16),
                      child: Row(
                        children: [
                          Text(
                            widget.product.productContext,
                            style: TTextTheme.lightTextTheme.bodyMedium
                                ?.copyWith(color: Colors.black45),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.amber,
                                  size: 24,
                                ),
                                Text(
                                  widget.product.rating.toString(),
                                  style: TTextTheme.lightTextTheme.bodyMedium
                                      ?.copyWith(color: Colors.black38),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            widget.product.name,
                            style: TTextTheme.lightTextTheme.headlineSmall
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16),
                          child: Text(
                            context.loc.productDetails,
                            style: TTextTheme.lightTextTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: 8, top: 8),
                      child: Text(
                        widget.product.productDetails,
                        style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
                          color: Colors.black54,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black12,
                      endIndent: 16,
                      indent: 16,
                      height: 28,
                    ),

                    if (widget.product.categoryName == "Clothing")
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is ProductSizeLoadSuccess) {
                            return SelectedSize(
                              product: widget.product,
                              sizes: state.productSize,
                              selectedSize:
                                  state.selectedSize, // Pass the list of sizes
                            );
                          } else if (widget.product.categoryName !=
                              "Clothing") {
                            return const Center(
                              child: Text("Your category is not matched"),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 2),
                          child: Text(
                            context.loc.selectColor,
                            style: TTextTheme.lightTextTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 16),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.brown,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.cream,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.creamColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightBrown,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightYellow,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 12),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   String? selectedSize;
//   CategoryModel? _selectedCategory;
//   List<String>? _availableSizes;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchCategoryAndSizes();
//   }
//
//   Future<void> _fetchCategoryAndSizes() async {
//     try {
//       print(
//         "--- STARTING FETCH FOR PRODUCT: ${widget.product.name} (Category: ${widget.product.categoryName}) ---",
//       );
//
//       // 1. Fetch the main category document
//       final categoryQuerySnapshot =
//           await FirebaseFirestore.instance
//               .collection('categories')
//               .where('name', isEqualTo: widget.product.categoryName)
//               .limit(1)
//               .get();
//
//       if (categoryQuerySnapshot.docs.isNotEmpty) {
//         final categoryDoc = categoryQuerySnapshot.docs.first;
//         final category = CategoryModel.fromFirestore(categoryDoc);
//
//         print(
//           "ProductDetailsPage: Main category fetched. ID: ${category.id}, Name: ${category.name}",
//         );
//
//         // 2. Now fetch from the 'product_size' subcollection using the category ID
//         // Your screenshot shows 'product_size' as the subcollection name, and then a document within it
//         // which contains the 'size' array.
//         final productSizeSnapshot =
//             await FirebaseFirestore.instance
//                 .collection('categories')
//                 .doc(category.id)
//                 .collection('product_size') // This is the subcollection name
//                 .limit(
//                   1,
//                 ) // Assuming there's only one document in 'product_size' subcollection
//                 .get();
//
//         List<String> fetchedSizes = [];
//         if (productSizeSnapshot.docs.isNotEmpty) {
//           print(
//             "ProductDetailsPage: Found ${productSizeSnapshot.docs.length} documents in 'product_size' subcollection.",
//           );
//           final productSizeDoc = productSizeSnapshot.docs.first;
//           print(
//             "  - Product Size Document ID: ${productSizeDoc.id}, Data: ${productSizeDoc.data()}",
//           );
//           try {
//             // Use the updated ProductSizeModel which now expects 'size' field
//             final productSizeModel = ProductSizeModel.fromFirestore(
//               productSizeDoc,
//             );
//             fetchedSizes = productSizeModel.sizes;
//             print(
//               "ProductDetailsPage: Successfully extracted sizes: $fetchedSizes",
//             );
//           } catch (e) {
//             print(
//               "  - ERROR parsing product_size document ${productSizeDoc.id}: $e",
//             );
//             print(
//               "    Make sure the document in 'product_size' subcollection has a field named 'size' that is an array.",
//             );
//           }
//         } else {
//           print(
//             "ProductDetailsPage: No documents found in 'product_size' subcollection for category ID: ${category.id}",
//           );
//         }
//
//         setState(() {
//           _selectedCategory = category;
//           _availableSizes = fetchedSizes;
//         });
//         print(
//           "ProductDetailsPage: _selectedCategory updated. _availableSizes updated: $_availableSizes",
//         );
//       } else {
//         setState(() {
//           _selectedCategory = null;
//           _availableSizes = null;
//         });
//         print(
//           "ProductDetailsPage: NO MAIN CATEGORY FOUND for name: ${widget.product.categoryName}",
//         );
//       }
//     } catch (e) {
//       print("ProductDetailsPage: CRITICAL ERROR during fetch: $e");
//       setState(() {
//         _selectedCategory = null;
//         _availableSizes = null;
//       });
//     } finally {
//       print("--- FETCH COMPLETED ---");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Container(
//         height: 100,
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.grey, width: 1),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Container(
//           padding: EdgeInsets.zero,
//           child: Row(
//             children: [
//               Column(
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16, left: 12),
//                         child: Text(
//                           context.loc.totalPrice,
//                           style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
//                             color: Colors.black54,
//                             height: 1.2,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 12),
//                         child: Text(
//                           "\$${widget.product.price.toString()} ",
//                           style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 32),
//               Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 16,
//                     ),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: const Size(220, 50),
//                       ),
//                       onPressed: () {
//                         Navigator.pushNamed(context, CartPage.route);
//                       },
//                       child: Row(
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.only(bottom: 8),
//                             child: Icon(Icons.shopping_bag_rounded, size: 20),
//                           ),
//                           const SizedBox(width: 10),
//                           Text(
//                             context.loc.addToCart,
//                             textAlign: TextAlign.center,
//                             style: TTextTheme.lightTextTheme.headlineSmall
//                                 ?.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                   height: 0.5,
//                                   letterSpacing: 0,
//                                 ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: Stack(
//                       children: [
//                         Positioned.fill(
//                           child: Image.network(
//                             widget.product.imageUrl,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Positioned(
//                           top: 64,
//                           left: 16,
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             child: IconButton(
//                               icon: const Icon(
//                                 Icons.arrow_back,
//                                 color: Colors.black,
//                               ),
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 64,
//                           right: 16,
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             child: IconButton(
//                               icon: const Icon(Icons.favorite_border),
//                               onPressed: () {
//                                 Navigator.pushNamed(
//                                   context,
//                                   FavoritePage.route,
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 32, left: 16),
//                       child: Row(
//                         children: [
//                           Text(
//                             widget.product.productContext,
//                             style: TTextTheme.lightTextTheme.bodyMedium
//                                 ?.copyWith(color: Colors.black45),
//                           ),
//                           const Spacer(),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Icons.star_rate_rounded,
//                                   color: Colors.amber,
//                                   size: 24,
//                                 ),
//                                 Text(
//                                   widget.product.rating.toString(),
//                                   style: TTextTheme.lightTextTheme.bodyMedium
//                                       ?.copyWith(color: Colors.black38),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 8),
//                           child: Text(
//                             widget.product.name,
//                             style: TTextTheme.lightTextTheme.headlineSmall
//                                 ?.copyWith(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 16),
//                           child: Text(
//                             context.loc.productDetails,
//                             style: TTextTheme.lightTextTheme.bodyLarge
//                                 ?.copyWith(fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(left: 16, right: 8, top: 8),
//                       child: Text(
//                         widget.product.productDetails,
//                         style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
//                           color: Colors.black54,
//                           height: 1.2,
//                         ),
//                       ),
//                     ),
//                     const Divider(
//                       thickness: 1,
//                       color: Colors.black12,
//                       endIndent: 16,
//                       indent: 16,
//                       height: 28,
//                     ),
//                     // Check if sizes are available before rendering SelectedSize
//                     if (widget.product.categoryName == "Clothing" &&
//                         _availableSizes != null)
//                       SelectedSize(
//                         product: widget.product,
//                         sizes: _availableSizes!, // Pass the list of sizes
//                       )
//                     else if (widget.product.categoryName != "Clothing")
//                       const Center(child: Text("Your category is not matched"))
//                     else
//                       const Center(child: CircularProgressIndicator()),
//
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 2),
//                           child: Text(
//                             context.loc.selectColor,
//                             style: TTextTheme.lightTextTheme.bodyLarge
//                                 ?.copyWith(fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 16),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.brown,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.cream,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.creamColor,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.lightBrown,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.lightYellow,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.orange,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProductDetailsPage extends StatefulWidget {
//   final Product product;
//
//   const ProductDetailsPage({super.key, required this.product});
//
//   static const route = "product_details";
//
//   @override
//   State<ProductDetailsPage> createState() => _ProductDetailsPageState();
// }
//
// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   String? selectedSize;
//   CategoryModel? _selectedCategory;
//   List<String>? _availableSizes; // New variable to hold the fetched sizes list
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchCategoryAndSizes(); // Consolidated fetch method
//   }
//
//   Future<void> _fetchCategoryAndSizes() async {
//     try {
//       // 1. Fetch the main category document
//       final categorySnapshot =
//           await FirebaseFirestore.instance
//               .collection('categories')
//               .where('name', isEqualTo: widget.product.categoryName)
//               .limit(1)
//               .get();
//
//       if (categorySnapshot.docs.isNotEmpty) {
//         final category = CategoryModel.fromFirestore(
//           categorySnapshot.docs.first,
//         );
//
//         // 2. Now fetch from the 'product_size' subcollection using the category ID
//         // Assuming there's one document in 'product_size' subcollection that holds the list.
//         // You might need to adjust the query if there are multiple documents
//         // or a specific document ID.
//         final productSizeSnapshot =
//             await FirebaseFirestore.instance
//                 .collection('categories')
//                 .doc(category.id) // Use the ID of the fetched category
//                 .collection('product_size')
//                 .limit(1) // Assuming one document holds the sizes
//                 .get();
//
//         List<String> fetchedSizes = [];
//         if (productSizeSnapshot.docs.isNotEmpty) {
//           final productSizeModel = ProductSizeModel.fromFirestore(
//             productSizeSnapshot.docs.first,
//           );
//           fetchedSizes = productSizeModel.sizes;
//         }
//
//         setState(() {
//           _selectedCategory = category;
//           _availableSizes = fetchedSizes;
//         });
//         print(
//           "ProductDetailsPage: Fetched Category: ${category.name}, Available Sizes: $_availableSizes",
//         );
//       } else {
//         setState(() {
//           _selectedCategory = null;
//           _availableSizes = null; // No sizes if no category
//         });
//         print(
//           "ProductDetailsPage: No category found for ${widget.product.categoryName}",
//         );
//       }
//     } catch (e) {
//       print("ProductDetailsPage: ERROR fetching category or sizes: $e");
//       setState(() {
//         _selectedCategory = null;
//         _availableSizes = null;
//       });
//       // Handle error, e.g., show a SnackBar
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Container(
//         height: 100,
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.grey, width: 1),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Container(
//           padding: EdgeInsets.zero,
//           child: Row(
//             children: [
//               Column(
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16, left: 12),
//                         child: Text(
//                           context.loc.totalPrice,
//                           style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
//                             color: Colors.black54,
//                             height: 1.2,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 12),
//                         child: Text(
//                           "\$${widget.product.price.toString()} ",
//                           style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 32),
//               Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 16,
//                     ),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: const Size(220, 50),
//                       ),
//                       onPressed: () {
//                         Navigator.pushNamed(context, CartPage.route);
//                       },
//                       child: Row(
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.only(bottom: 8),
//                             child: Icon(Icons.shopping_bag_rounded, size: 20),
//                           ),
//                           const SizedBox(width: 10),
//                           Text(
//                             context.loc.addToCart,
//                             textAlign: TextAlign.center,
//                             style: TTextTheme.lightTextTheme.headlineSmall
//                                 ?.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                   height: 0.5,
//                                   letterSpacing: 0,
//                                 ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: Stack(
//                       children: [
//                         Positioned.fill(
//                           child: Image.network(
//                             widget.product.imageUrl,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Positioned(
//                           top: 64,
//                           left: 16,
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             child: IconButton(
//                               icon: const Icon(
//                                 Icons.arrow_back,
//                                 color: Colors.black,
//                               ),
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 64,
//                           right: 16,
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             child: IconButton(
//                               icon: const Icon(Icons.favorite_border),
//                               onPressed: () {
//                                 Navigator.pushNamed(
//                                   context,
//                                   FavoritePage.route,
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 32, left: 16),
//                       child: Row(
//                         children: [
//                           Text(
//                             widget.product.productContext,
//                             style: TTextTheme.lightTextTheme.bodyMedium
//                                 ?.copyWith(color: Colors.black45),
//                           ),
//                           const Spacer(),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Icons.star_rate_rounded,
//                                   color: Colors.amber,
//                                   size: 24,
//                                 ),
//                                 Text(
//                                   widget.product.rating.toString(),
//                                   style: TTextTheme.lightTextTheme.bodyMedium
//                                       ?.copyWith(color: Colors.black38),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 8),
//                           child: Text(
//                             widget.product.name,
//                             style: TTextTheme.lightTextTheme.headlineSmall
//                                 ?.copyWith(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 16),
//                           child: Text(
//                             context.loc.productDetails,
//                             style: TTextTheme.lightTextTheme.bodyLarge
//                                 ?.copyWith(fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(left: 16, right: 8, top: 8),
//                       child: Text(
//                         widget.product.productDetails,
//                         style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
//                           color: Colors.black54,
//                           height: 1.2,
//                         ),
//                       ),
//                     ),
//                     const Divider(
//                       thickness: 1,
//                       color: Colors.black12,
//                       endIndent: 16,
//                       indent: 16,
//                       height: 28,
//                     ),
//                     // Check if sizes are available before rendering SelectedSize
//                     if (widget.product.categoryName == "Clothing" &&
//                         _availableSizes != null)
//                       SelectedSize(
//                         product: widget.product,
//                         sizes: _availableSizes!, // Pass the list of sizes
//                       )
//                     else if (widget.product.categoryName != "Clothing")
//                       const Center(child: Text("Your category is not matched"))
//                     else
//                       const Center(child: CircularProgressIndicator()),
//
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 2),
//                           child: Text(
//                             context.loc.selectColor,
//                             style: TTextTheme.lightTextTheme.bodyLarge
//                                 ?.copyWith(fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 16),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.brown,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.cream,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.creamColor,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.lightBrown,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.lightYellow,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.orange,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// shopping_cart/product/product_details_page.dart
// import 'package:flutter/material.dart';
// import 'package:shopping_cart/favorite_page/favorite_page.dart';
// import 'package:shopping_cart/l10n/translation_extension.dart';
// import 'package:shopping_cart/product/domain/entities/product.dart';
// import 'package:shopping_cart/product/select_size_list.dart'; // Ensure this path is correct
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
//
// import '../cart/cart_page.dart';
// import '../core/utils/theme/text_theme.dart';
// import '../core/utils/theme/theme.dart';
// import 'data/models/category_model.dart'; // Ensure this path is correct
//
// class ProductDetailsPage extends StatefulWidget {
//   final Product product;
//
//   const ProductDetailsPage({
//     super.key,
//     required this.product,
//   });
//
//   static const route = "product_details";
//
//   @override
//   State<ProductDetailsPage> createState() => _ProductDetailsPageState();
// }
//
// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   String? selectedSize; // For highlight the selected size (if needed here, otherwise remove)
//   CategoryModel? _selectedCategory; // Variable to hold the fetched category
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchCategory(); // Fetch category when the widget initializes
//   }
//
//   Future<void> _fetchCategory() async {
//     try {
//       final categorySnapshot = await FirebaseFirestore.instance
//           .collection('categories')
//           .where('name', isEqualTo: widget.product.categoryName)
//           .limit(1)
//           .get();
//
//       if (categorySnapshot.docs.isNotEmpty) {
//         setState(() {
//           _selectedCategory = CategoryModel.fromFirestore(categorySnapshot.docs.first);
//         });
//       }
//     } catch (e) {
//       print("Error fetching category: $e");
//       // Optionally show a user-friendly error message
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Container(
//         height: 100,
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.grey, width: 1),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Container(
//           padding: EdgeInsets.zero,
//           child: Row(
//             children: [
//               Column(
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16, left: 12),
//                         child: Text(
//                           context.loc.totalPrice,
//                           style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
//                             color: Colors.black54,
//                             height: 1.2,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 12),
//                         child: Text(
//                           "\$${widget.product.price.toString()} ",
//                           style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(width: 32),
//               Column(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(220, 50),
//                       ),
//                       onPressed: () {
//                         Navigator.pushNamed(context, CartPage.route);
//                       },
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 8),
//                             child: Icon(Icons.shopping_bag_rounded, size: 20),
//                           ),
//                           SizedBox(width: 10),
//                           Text(
//                             context.loc.addToCart,
//                             textAlign: TextAlign.center,
//                             style: TTextTheme.lightTextTheme.headlineSmall
//                                 ?.copyWith(
//                               fontWeight: FontWeight.w600,
//                               height: 0.5,
//                               letterSpacing: 0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: Stack(
//                       children: [
//                         Positioned.fill(
//                           child: Image.network(
//                             widget.product.imageUrl,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Positioned(
//                           top: 64,
//                           left: 16,
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             child: IconButton(
//                               icon: Icon(Icons.arrow_back, color: Colors.black),
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 64,
//                           right: 16,
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             child: IconButton(
//                               icon: Icon(Icons.favorite_border),
//                               onPressed: () {
//                                 Navigator.pushNamed(
//                                   context,
//                                   FavoritePage.route,
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 32, left: 16),
//                       child: Row(
//                         children: [
//                           Text(
//                             widget.product.productContext,
//                             style: TTextTheme.lightTextTheme.bodyMedium
//                                 ?.copyWith(color: Colors.black45),
//                           ),
//                           Spacer(),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.star_rate_rounded,
//                                   color: Colors.amber,
//                                   size: 24,
//                                 ),
//                                 Text(
//                                   widget.product.rating.toString(),
//                                   style: TTextTheme.lightTextTheme.bodyMedium
//                                       ?.copyWith(color: Colors.black38),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 8),
//                           child: Text(
//                             widget.product.name,
//                             style: TTextTheme.lightTextTheme.headlineSmall
//                                 ?.copyWith(
//                               color: Colors.black,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 16),
//                           child: Text(
//                             context.loc.productDetails,
//                             style: TTextTheme.lightTextTheme.bodyLarge
//                                 ?.copyWith(fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(left: 16, right: 8, top: 8),
//                       child: Text(
//                         widget.product.productDetails,
//                         style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
//                           color: Colors.black54,
//                           height: 1.2,
//                         ),
//                       ),
//                     ),
//                     Divider(
//                       thickness: 1,
//                       color: Colors.black12,
//                       endIndent: 16,
//                       indent: 16,
//                       height: 28,
//                     ),
//                     // Conditionally render SelectedSize based on category and fetched data
//                     if (widget.product.categoryName == "Clothing" && _selectedCategory != null)
//                       SelectedSize(
//                         product: widget.product,
//                         category: _selectedCategory!, // Pass the fetched category model
//                       )
//                     else if (widget.product.categoryName != "Clothing")
//                       Center(child: Text("Your category is not matched"))
//                     else
//                       Center(child: CircularProgressIndicator()), // Show loading while category is fetched
//
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 2),
//                           child: Text(
//                             context.loc.selectColor,
//                             style: TTextTheme.lightTextTheme.bodyLarge
//                                 ?.copyWith(fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 16),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.brown,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.cream,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.creamColor,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.lightBrown,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.lightYellow,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.orange,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:shopping_cart/favorite_page/favorite_page.dart';
// import 'package:shopping_cart/l10n/translation_extension.dart';
// import 'package:shopping_cart/product/domain/entities/product.dart';
// import 'package:shopping_cart/product/select_size_list.dart';
//
// import '../cart/cart_page.dart';
// import '../core/utils/theme/text_theme.dart';
// import '../core/utils/theme/theme.dart';
// import 'data/models/category_model.dart';
//
// class ProductDetailsPage extends StatefulWidget {
//   final Product product;
//   // final CategoryModel category;
//
//   const ProductDetailsPage({
//     super.key,
//     required this.product,
//     // required this.category,
//   });
//
//   static const route = "product_details";
//
//   @override
//   State<ProductDetailsPage> createState() => _ProductDetailsPageState();
// }
//
// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   //for highlight the selected size
//   String? selectedSize;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Container(
//         height: 100,
//         decoration: BoxDecoration(
//           border: Border.all(color: AppColors.grey, width: 1),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Container(
//           padding: EdgeInsets.zero,
//           child: Row(
//             children: [
//               Column(
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 16, left: 12),
//                         child: Text(
//                           context.loc.totalPrice,
//                           style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
//                             color: Colors.black54,
//                             height: 1.2,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 12),
//                         child: Text(
//                           "\$${widget.product.price.toString()} ",
//                           style: TTextTheme.lightTextTheme.bodyLarge?.copyWith(
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//
//               SizedBox(width: 32),
//               Column(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(220, 50),
//                         // textStyle: TextStyle(height: 0.8),
//                       ),
//                       onPressed: () {
//                         Navigator.pushNamed(context, CartPage.route);
//                       },
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 8),
//                             child: Icon(Icons.shopping_bag_rounded, size: 20),
//                           ),
//                           SizedBox(width: 10),
//                           Text(
//                             context.loc.addToCart,
//                             textAlign: TextAlign.center,
//                             style: TTextTheme.lightTextTheme.headlineSmall
//                                 ?.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                   height: 0.5,
//                                   letterSpacing: 0,
//                                 ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           // SliverAppBar(
//           //   centerTitle: true,
//           //   pinned: true,
//           //   actions: [
//           //     Padding(
//           //       padding: const EdgeInsets.all(8),
//           //       child: CircleAvatar(
//           //         radius: 20,
//           //         backgroundColor: Colors.white,
//           //         child: IconButton(
//           //           icon: Icon(Icons.favorite_border),
//           //           onPressed: () {},
//           //         ),
//           //       ),
//           //     ),
//           //   ],
//           //   title: Text(
//           //     context.loc.productDetails,
//           //     style: TTextTheme.lightTextTheme.headlineSmall?.copyWith(
//           //       fontWeight: FontWeight.w500,
//           //     ),
//           //   ),
//           //   backgroundColor: AppColors.cream,
//           //   leading: Padding(
//           //     padding: const EdgeInsets.all(8),
//           //     child: CircleAvatar(
//           //       backgroundColor: Colors.white,
//           //       child: IconButton(
//           //         icon: Icon(Icons.arrow_back, color: Colors.black),
//           //         onPressed: () => Navigator.pop(context),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: Stack(
//                       children: [
//                         Positioned.fill(
//                           child: Image.network(
//                             widget.product.imageUrl,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Positioned(
//                           top: 64,
//                           left: 16,
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             child: IconButton(
//                               icon: Icon(Icons.arrow_back, color: Colors.black),
//                               onPressed: () => Navigator.pop(context),
//                             ),
//                           ),
//                         ),
//
//                         Positioned(
//                           top: 64,
//                           right: 16,
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             child: IconButton(
//                               icon: Icon(Icons.favorite_border),
//                               onPressed: () {
//                                 Navigator.pushNamed(
//                                   context,
//                                   FavoritePage.route,
//                                 );
//                                 // Your favorite action
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 32, left: 16),
//                       child: Row(
//                         children: [
//                           Text(
//                             widget.product.productContext,
//                             style: TTextTheme.lightTextTheme.bodyMedium
//                                 ?.copyWith(color: Colors.black45),
//                           ),
//
//                           Spacer(),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.star_rate_rounded,
//                                   color: Colors.amber,
//                                   size: 24,
//                                 ),
//                                 Text(
//                                   widget.product.rating.toString(),
//                                   style: TTextTheme.lightTextTheme.bodyMedium
//                                       ?.copyWith(color: Colors.black38),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 8),
//                           child: Text(
//                             widget.product.name,
//                             style: TTextTheme.lightTextTheme.headlineSmall
//                                 ?.copyWith(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 16),
//                           child: Text(
//                             context.loc.productDetails,
//                             style: TTextTheme.lightTextTheme.bodyLarge
//                                 ?.copyWith(fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     Container(
//                       margin: const EdgeInsets.only(left: 16, right: 8, top: 8),
//                       child: Text(
//                         widget.product.productDetails,
//                         style: TTextTheme.lightTextTheme.bodyMedium?.copyWith(
//                           color: Colors.black54,
//                           height: 1.2,
//                         ),
//                       ),
//                     ),
//
//                     Divider(
//                       thickness: 1,
//                       color: Colors.black12,
//                       endIndent: 16,
//                       indent: 16,
//                       height: 28,
//                     ),
//
//                     (widget.product.categoryName == "Clothing")
//                         ? SelectedSize(
//                           product: widget.product,
//                           // category: widget.category,
//                         )
//                         : Center(child: Text("your category is not matched")),
//
//                     // Row(
//                     //   children: [
//                     //     Padding(
//                     //       padding: const EdgeInsets.only(left: 16, top: 2),
//                     //       child: Text(
//                     //         context.loc.selectSize,
//                     //         style: TTextTheme.lightTextTheme.bodyLarge
//                     //             ?.copyWith(fontWeight: FontWeight.w500),
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                     //
//                     // Padding(
//                     //   padding: const EdgeInsets.symmetric(
//                     //     horizontal: 4,
//                     //     vertical: 8,
//                     //   ),
//                     //   child: Row(
//                     //     children: [
//                     //       SizedBox(width: 4),
//                     //       CustomChips(
//                     //         onTap:
//                     //             () => setState(() {
//                     //               selectedSize = "S";
//                     //             }),
//                     //         label: Text(
//                     //           "S",
//                     //           style: TTextTheme.lightTextTheme.labelSmall
//                     //               ?.copyWith(
//                     //                 fontWeight: FontWeight.w500,
//                     //                 // height: -0.8,
//                     //                 color:
//                     //                     selectedSize == "S"
//                     //                         ? Colors.white
//                     //                         : Colors.black,
//                     //               ),
//                     //         ),
//                     //         backgroundColor:
//                     //             selectedSize == "S"
//                     //                 ? AppColors.brown
//                     //                 : Colors.white,
//                     //         height: 32,
//                     //       ),
//                     //       CustomChips(
//                     //         onTap:
//                     //             () => setState(() {
//                     //               selectedSize = "M";
//                     //             }),
//                     //         label: Text(
//                     //           "M",
//                     //           style: TTextTheme.lightTextTheme.labelSmall
//                     //               ?.copyWith(
//                     //                 fontWeight: FontWeight.w500,
//                     //                 // height: -0.8,
//                     //                 color:
//                     //                     selectedSize == "M"
//                     //                         ? Colors.white
//                     //                         : Colors.black,
//                     //               ),
//                     //         ),
//                     //         backgroundColor:
//                     //             selectedSize == "M"
//                     //                 ? AppColors.brown
//                     //                 : Colors.white,
//                     //         height: 32,
//                     //       ),
//                     //       CustomChips(
//                     //         onTap:
//                     //             () => setState(() {
//                     //               selectedSize = "L";
//                     //             }),
//                     //         label: Text(
//                     //           "L",
//                     //           style: TTextTheme.lightTextTheme.labelSmall
//                     //               ?.copyWith(
//                     //                 fontWeight: FontWeight.w500,
//                     //                 // height: -0.8,
//                     //                 color:
//                     //                     selectedSize == "L"
//                     //                         ? Colors.white
//                     //                         : Colors.black,
//                     //               ),
//                     //         ),
//                     //         backgroundColor:
//                     //             selectedSize == "L"
//                     //                 ? AppColors.brown
//                     //                 : Colors.white,
//                     //         height: 32,
//                     //       ),
//                     //
//                     //       CustomChips(
//                     //         onTap:
//                     //             () => setState(() {
//                     //               selectedSize = "XL";
//                     //             }),
//                     //         label: Text(
//                     //           "XL",
//                     //           style: TTextTheme.lightTextTheme.labelSmall
//                     //               ?.copyWith(
//                     //                 fontWeight: FontWeight.w500,
//                     //                 // height: -0.8,
//                     //                 color:
//                     //                     selectedSize == "XL"
//                     //                         ? Colors.white
//                     //                         : Colors.black,
//                     //               ),
//                     //         ),
//                     //         backgroundColor:
//                     //             selectedSize == "XL"
//                     //                 ? AppColors.brown
//                     //                 : Colors.white,
//                     //         height: 32,
//                     //       ),
//                     //       // SizedBox(width: 8),
//                     //       CustomChips(
//                     //         onTap:
//                     //             () => setState(() {
//                     //               selectedSize = "XXL";
//                     //             }),
//                     //         label: Text(
//                     //           "XXL",
//                     //           style: TTextTheme.lightTextTheme.labelSmall
//                     //               ?.copyWith(
//                     //                 fontWeight: FontWeight.w500,
//                     //                 // height: -0.9,
//                     //                 color:
//                     //                     selectedSize == "XXL"
//                     //                         ? Colors.white
//                     //                         : Colors.black,
//                     //               ),
//                     //         ),
//                     //         backgroundColor:
//                     //             selectedSize == "XXL"
//                     //                 ? AppColors.brown
//                     //                 : Colors.white,
//                     //         height: 32,
//                     //       ),
//                     //       // SizedBox(width: 14),
//                     //       CustomChips(
//                     //         onTap:
//                     //             () => setState(() {
//                     //               selectedSize = "XXXL";
//                     //             }),
//                     //         label: Text(
//                     //           "XXXL",
//                     //           style: TTextTheme.lightTextTheme.labelSmall
//                     //               ?.copyWith(
//                     //                 fontWeight: FontWeight.w500,
//                     //                 // height: -0.9,
//                     //                 color:
//                     //                     selectedSize == "XXXL"
//                     //                         ? Colors.white
//                     //                         : Colors.black,
//                     //               ),
//                     //         ),
//                     //         backgroundColor:
//                     //             selectedSize == "XXXL"
//                     //                 ? AppColors.brown
//                     //                 : Colors.white,
//                     //         height: 32,
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, top: 2),
//                           child: Text(
//                             context.loc.selectColor,
//                             style: TTextTheme.lightTextTheme.bodyLarge
//                                 ?.copyWith(fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 16),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.brown,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.cream,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.creamColor,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.lightBrown,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.lightYellow,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8, left: 12),
//                           child: Container(
//                             height: 28,
//                             width: 28,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.orange,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
