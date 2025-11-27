import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vagrancy_beggars/controllers/getxController/action_take_controller.dart';

class ActionTakenWidget extends StatefulWidget {
  final ActionTakController controller = Get.find<ActionTakController>();

  ActionTakenWidget({super.key});

  @override
  State<ActionTakenWidget> createState() => _ActionTakenWidgetState();
}

class _ActionTakenWidgetState extends State<ActionTakenWidget> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool isDropdownOpen = false;

  void _toggleDropdown() {
    if (isDropdownOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      isDropdownOpen = false;
    } else {
      _overlayEntry = _createOverlay();
      Overlay.of(context).insert(_overlayEntry!);
      isDropdownOpen = true;
    }
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, size.height + 5),
          showWhenUnlinked: false,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: SingleChildScrollView(
                child: Column(
                  children: widget.controller.languages.map((lang) {
                    return InkWell(
                      onTap: () {
                        widget.controller.changeLanguage(lang);
                        _toggleDropdown();
                      },
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                        child: Text(
                          lang,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------ DROPDOWN ------------------
          CompositedTransformTarget(
            link: _layerLink,
            child: GestureDetector(
              onTap: _toggleDropdown,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.controller.selectedLanguage.value,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down, color: Color(0xff644983)),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ------------------ FIR FIELDS ------------------
          if (widget.controller.showFIRFields.value) ...[
            Text(
              "FIR Number",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                labelText: "FIR Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                widget.controller.firNumber.value = value;
              },
            ),

            SizedBox(height: 12),

            Text(
              "Police Station",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                labelText: "Police Station",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                widget.controller.policeStation.value = value;
              },
            ),
          ],

          // ------------------ ORGANIZATION FIELD ------------------
          if (widget.controller.showOrganizationField.value) ...[
            Text(
              "Organization Name",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                labelText: "Enter organization name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                widget.controller.organizationName.value = value;
              },
            ),
          ],
        ],
      ),
    );
  }
}



