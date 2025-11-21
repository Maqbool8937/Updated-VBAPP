import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/theme _controller.dart';
import 'package:vagrancy_beggars/services/beggar_record_service.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final beggarRecordService = BeggarRecordService();
  var cases = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    loadCases();
  }

  Future<void> loadCases() async {
    try {
      isLoading.value = true;
      final results = await beggarRecordService.getMyRecords();
      cases.value = results.map((record) => {
        'id': record.id,
        'name': record.fullName,
        'created_at': record.captureDateTime.toIso8601String(),
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

  List<Map<String, dynamic>> getCasesForDate(DateTime date) {
    return cases.where((caseData) {
      if (caseData['created_at'] == null) return false;
      final caseDate = DateTime.parse(caseData['created_at']);
      return caseDate.year == date.year &&
          caseDate.month == date.month &&
          caseDate.day == date.day;
    }).toList();
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
          title: const Text('Calendar'),
          backgroundColor: isDark ? Colors.grey.shade900 : const Color(0xff140D44),
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            // Calendar Widget
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          setState(() {
                            selectedDate = DateTime(
                              selectedDate.year,
                              selectedDate.month - 1,
                            );
                          });
                        },
                      ),
                      Text(
                        DateFormat('MMMM yyyy').format(selectedDate),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {
                          setState(() {
                            selectedDate = DateTime(
                              selectedDate.year,
                              selectedDate.month + 1,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Simple calendar grid
                  _buildCalendarGrid(selectedDate, isDark, textColor),
                ],
              ),
            ),

            // Cases for selected date
            Expanded(
              child: isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : Obx(() {
                      final dateCases = getCasesForDate(selectedDate);
                      if (dateCases.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.event_busy,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No cases for this date',
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
                        itemCount: dateCases.length,
                        itemBuilder: (context, index) {
                          final caseData = dateCases[index];
                          return Card(
                            color: cardColor,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: CircleAvatar(
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
                              subtitle: Text(
                                'ID: ${caseData['id'] ?? 'N/A'}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
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

  Widget _buildCalendarGrid(DateTime month, bool isDark, Color? textColor) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    final firstWeekday = firstDay.weekday;

    return Column(
      children: [
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
              .map((day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        // Calendar days
        ...List.generate(
          (lastDay.day + firstWeekday - 1) ~/ 7 + 1,
          (week) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (day) {
              final dayIndex = week * 7 + day - firstWeekday + 2;
              if (dayIndex < 1 || dayIndex > lastDay.day) {
                return const Expanded(child: SizedBox());
              }
              final date = DateTime(month.year, month.month, dayIndex);
              final hasCases = getCasesForDate(date).isNotEmpty;
              final isSelected = date.year == selectedDate.year &&
                  date.month == selectedDate.month &&
                  date.day == selectedDate.day;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.redAccent
                          : hasCases
                              ? Colors.redAccent.withOpacity(0.2)
                              : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$dayIndex',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : hasCases
                                  ? Colors.redAccent
                                  : textColor,
                          fontWeight: isSelected || hasCases
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
