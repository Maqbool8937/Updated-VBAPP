import 'package:flutter/material.dart';

class ActionTakenScreen extends StatefulWidget {
  const ActionTakenScreen({super.key});

  @override
  State<ActionTakenScreen> createState() => _ActionTakenScreenState();
}

class _ActionTakenScreenState extends State<ActionTakenScreen> {
  final TextEditingController actionController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController officerController = TextEditingController();

  bool issueResolved = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> submitAction() async {
    if (!_formKey.currentState!.validate()) return;

    final data = {
      "action_taken": actionController.text.trim(),
      "officer_name": officerController.text.trim(),
      "notes": notesController.text.trim(),
      "is_resolved": issueResolved,
      "timestamp": DateTime.now().toIso8601String(),
    };

    // TODO: Send data to backend API
    // await ApiService.submitAction(data);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Action submitted successfully")),
    );

    // Optional: Clear form
    actionController.clear();
    notesController.clear();
    officerController.clear();
    setState(() => issueResolved = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Action Taken"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Action Taken
                      const Text(
                        "Describe the Action Taken",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: actionController,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please describe the action";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Write what action you performed...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Officer Name
                      const Text(
                        "Officer Name(s)",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: officerController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter officer name(s)";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter the officer(s) who took action",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Resolved Switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Is the issue resolved?",
                            style: TextStyle(fontSize: 16),
                          ),
                          Switch(
                            value: issueResolved,
                            onChanged: (val) =>
                                setState(() => issueResolved = val),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Additional Notes
                      const Text(
                        "Additional Notes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: notesController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Optional notes...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitAction,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class ActionTakenScreen extends StatefulWidget {
//   const ActionTakenScreen({super.key});

//   @override
//   State<ActionTakenScreen> createState() => _ActionTakenScreenState();
// }

// class _ActionTakenScreenState extends State<ActionTakenScreen> {
//   final TextEditingController actionController = TextEditingController();
//   final TextEditingController notesController = TextEditingController();

//   bool issueResolved = false;
//   final _formKey = GlobalKey<FormState>();

//   Future<void> submitAction() async {
//     if (!_formKey.currentState!.validate()) return;

//     final data = {
//       "action_taken": actionController.text.trim(),
//       "notes": notesController.text.trim(),
//       "is_resolved": issueResolved,
//       "timestamp": DateTime.now().toIso8601String(),
//     };

//     // TODO: Send data to backend API
//     // await ApiService.submitAction(data);

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Action submitted successfully")),
//     );

//     // Optional: Clear form
//     actionController.clear();
//     notesController.clear();
//     setState(() => issueResolved = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Action Taken"),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//       ),
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Describe the Action Taken",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       TextFormField(
//                         controller: actionController,
//                         maxLines: 3,
//                         validator: (value) {
//                           if (value == null || value.trim().isEmpty) {
//                             return "Please describe the action";
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Write what action you performed...",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20),

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Is the issue resolved?",
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Switch(
//                             value: issueResolved,
//                             onChanged: (val) =>
//                                 setState(() => issueResolved = val),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),

//                       const Text(
//                         "Additional Notes",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       TextField(
//                         controller: notesController,
//                         maxLines: 4,
//                         decoration: InputDecoration(
//                           hintText: "Optional notes...",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: submitAction,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     "Submit",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
