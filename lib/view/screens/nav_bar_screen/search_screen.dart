import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme _controller.dart';
import 'package:vagrancy_beggars/services/beggar_record_service.dart';
import 'package:vagrancy_beggars/config/api_config.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  final beggarRecordService = BeggarRecordService();
  var searchResults = <Map<String, dynamic>>[].obs;
  var isSearching = false.obs;
  var hasSearched = false.obs;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> performSearch(String query) async {
    if (query.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a search term',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isSearching.value = true;
      hasSearched.value = true;
      // Get all records and filter locally (or implement search endpoint)
      final allRecords = await beggarRecordService.getMyRecords();
      final filtered = allRecords.where((record) {
        final searchLower = query.toLowerCase();
        return record.fullName.toLowerCase().contains(searchLower) ||
            (record.cnic?.toLowerCase().contains(searchLower) ?? false) ||
            record.captureLocation.toLowerCase().contains(searchLower);
      }).toList();
      
      searchResults.value = filtered.map((record) => {
        'id': record.id,
        'name': record.fullName,
        'created_at': record.captureDateTime.toIso8601String(),
        'photo': record.photo,
      }).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to search: ${e.toString().replaceAll('Exception: ', '')}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      searchResults.value = [];
    } finally {
      isSearching.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDark.value;
      final bgColor = Theme.of(context).scaffoldBackgroundColor;
      final cardColor = Theme.of(context).cardColor;
      final textColor = Theme.of(context).textTheme.bodyLarge!.color;

      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: const Text('Search Cases'),
          backgroundColor: isDark ? Colors.grey.shade900 : const Color(0xff140D44),
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        hintText: 'Search by name, ID, location...',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: cardColor,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  searchResults.clear();
                                  hasSearched.value = false;
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: performSearch,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Obx(() => isSearching.value
                      ? const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: CircularProgressIndicator(),
                        )
                      : IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => performSearch(searchController.text),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(16),
                          ),
                        )),
                ],
              ),
            ),

            // Results
            Expanded(
              child: Obx(() {
                if (isSearching.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!hasSearched.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Search for cases',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (searchResults.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No cases found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final caseData = searchResults[index];
                    return Card(
                      color: cardColor,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: caseData['photo'] != null
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                  ApiConfig.getImageUrl(caseData['photo']),
                                ),
                                onBackgroundImageError: (_, __) {},
                                child: caseData['photo'] == null
                                    ? Text(
                                        caseData['name']?[0]?.toUpperCase() ?? '?',
                                        style: const TextStyle(color: Colors.white),
                                      )
                                    : null,
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: Text(
                                  caseData['name']?[0]?.toUpperCase() ?? '?',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                        title: Text(
                          caseData['name'] ?? 'Unknown',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              'ID: ${caseData['id'] ?? 'N/A'}',
                              style: TextStyle(color: Colors.grey),
                            ),
                            if (caseData['created_at'] != null)
                              Text(
                                'Date: ${DateFormat('MMM dd, yyyy').format(DateTime.parse(caseData['created_at']))}',
                                style: TextStyle(color: Colors.grey),
                              ),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // Navigate to case details
                          Get.snackbar(
                            'Case Details',
                            'Case ID: ${caseData['id']}',
                            backgroundColor: Colors.blue,
                            colorText: Colors.white,
                          );
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
