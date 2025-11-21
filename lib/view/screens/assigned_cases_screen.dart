import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme _controller.dart';
import 'package:vagrancy_beggars/services/beggar_record_service.dart';
import 'package:vagrancy_beggars/config/api_config.dart';
import 'package:intl/intl.dart';

class AssignedCasesScreen extends StatefulWidget {
  const AssignedCasesScreen({super.key});

  @override
  State<AssignedCasesScreen> createState() => _AssignedCasesScreenState();
}

class _AssignedCasesScreenState extends State<AssignedCasesScreen> {
  final beggarRecordService = BeggarRecordService();
  var cases = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    loadCases();
  }

  Future<void> loadCases() async {
    try {
      isLoading.value = true;
      final results = await beggarRecordService.getMyRecords();
      // Convert BeggarRecord list to Map list for display
      cases.value = results.map((record) => {
        'id': record.id,
        'name': record.fullName,
        'gender': record.gender,
        'age': record.age,
        'address': record.captureLocation,
        'created_at': record.captureDateTime.toIso8601String(),
        'photo': record.photo,
      }).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load cases: ${e.toString().replaceAll('Exception: ', '')}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
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
          title: const Text('Assigned Cases'),
          backgroundColor: isDark ? Colors.grey.shade900 : const Color(0xff140D44),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: loadCases,
              tooltip: 'Refresh',
            ),
          ],
        ),
        body: isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Obx(() {
                if (cases.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No assigned cases',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'You don\'t have any assigned cases yet',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: loadCases,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cases.length,
                    itemBuilder: (context, index) {
                      final caseData = cases[index];
                      final createdAt = caseData['created_at'] != null
                          ? DateTime.parse(caseData['created_at'])
                          : null;

                      return Card(
                        color: cardColor,
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        child: InkWell(
                          onTap: () {
                            Get.snackbar(
                              'Case Details',
                              'Case ID: ${caseData['id']}\nName: ${caseData['name'] ?? 'Unknown'}',
                              backgroundColor: Colors.blue,
                              colorText: Colors.white,
                              duration: const Duration(seconds: 3),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    caseData['photo'] != null
                                        ? CircleAvatar(
                                            radius: 20,
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
                                            radius: 20,
                                            backgroundColor: Colors.redAccent,
                                            child: Text(
                                              caseData['name']?[0]?.toUpperCase() ?? '?',
                                              style: const TextStyle(color: Colors.white),
                                            ),
                                          ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            caseData['name'] ?? 'Unknown',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: textColor,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'ID: ${caseData['id'] ?? 'N/A'}',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                if (caseData['gender'] != null ||
                                    caseData['age'] != null) ...[
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      if (caseData['gender'] != null)
                                        _buildInfoChip(
                                          'Gender: ${caseData['gender']}',
                                          isDark,
                                        ),
                                      if (caseData['age'] != null) ...[
                                        const SizedBox(width: 8),
                                        _buildInfoChip(
                                          'Age: ${caseData['age']}',
                                          isDark,
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                                if (caseData['address'] != null) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          caseData['address'],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (createdAt != null) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        DateFormat('MMM dd, yyyy • hh:mm a')
                                            .format(createdAt),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
      );
    });
  }

  Widget _buildInfoChip(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
    );
  }
}

