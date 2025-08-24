import 'package:flutter/material.dart';
import 'package:what_s_up_app/core/extensions/ext.dart';

class ArchivedSection extends StatelessWidget {
  const ArchivedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () => {},
      child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.archive_outlined, 
                      color: Colors.grey, size: 20),
                  ),
                  12.wSpace,
                  const Text(
                    'Archived',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
    );
          
  }
} 