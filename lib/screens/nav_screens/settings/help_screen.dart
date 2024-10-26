import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/components/appbar.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Help & Support'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            children: [
              Text(
                "Lorem ipsum odor amet, consectetuer adipiscing elit. Erat metus aliquam enim semper fames ridiculus mi. Dolor fermentum lobortis primis pellentesque dolor tristique sagittis. Mattis convallis ultricies imperdiet rhoncus blandit nisl. Bibendum a elit ex magna sodales nullam habitasse. ",
                style: theme.bodySmall,
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    tileColor: secondary,
                    title: Text(
                      'What information do we collect from you?',
                      style: theme.bodySmall?.copyWith(color: accent),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: accent,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    tileColor: secondary,
                    title: Text(
                      'What information do we collect from you?',
                      style: theme.bodySmall?.copyWith(color: accent),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: accent,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                child: InkWell(
                  onTap: () {},
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r)),
                    tileColor: secondary,
                    title: Text(
                      'What information do we collect from you?',
                      style: theme.bodySmall?.copyWith(color: accent),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: accent,
                    ),
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
