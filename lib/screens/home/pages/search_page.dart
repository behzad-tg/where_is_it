import 'package:flutter/material.dart';
import 'package:wheretoeat/animation/left_to_right_fade.dart';
import 'package:wheretoeat/animation/up_to_down_fade.dart';
import 'package:wheretoeat/const.dart';
import 'package:wheretoeat/data.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          UpToDownFade(
            delay: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Row(
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'شهر، خیابان، کوچه...',
                          border: InputBorder.none),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 35,
            alignment: Alignment.centerRight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: categorys.length,
              itemBuilder: (context, index) => LeftToRightFade(
                delay: (0.4 + (index * 0.1)),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.only(right: index == 0 ? 20 : 0, left: 10),
                  decoration: BoxDecoration(
                    color: index == 0
                        ? primaryLightBlue.withOpacity(0.6)
                        : primaryLightBlue.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      categorys[index].title.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(80, 120, 200, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off_sharp,
                  size: 80,
                  color: Colors.grey.withOpacity(0.3),
                ),
                const Text(
                  'مکانی مشخص نشده',
                  style: TextStyle(color: Colors.black12, fontSize: 25),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
