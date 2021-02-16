import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: <Widget>[
              Text(
                "Products",
                style: Theme.of(context).textTheme.headline6,
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  print("hello");
                },
                child: Text("More"),
              ),
            ],
          ),
        ),
        Container(
          height: 1800,
          padding: EdgeInsets.symmetric(vertical: 1.0),
          child: GridView.builder(
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                childAspectRatio: 0.58),
            itemBuilder: (_, int index) {
              return Card(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.network(
                        "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/body-image/public/1-corvette-stingray-c8-2019-fd-hr-hero-front_0.jpg?itok=SEYe_vLy",
                        height: 150,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            'Product Category',
                            softWrap: true,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 5),
                      child: Text(
                        'Tomato Paste for Benin 2200g Tomato Paste ...',
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.network(
                                "https://media.istockphoto.com/photos/oil-refinery-chemical-petrochemical-plant-picture-id932140864?k=6&m=932140864&s=612x612&w=0&h=UujqNqhSsXBOHMd2x-X3YmkMOBLv7g1FZCCr52rC6b4=",
                                height: 20,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Manufacturer Company',
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 11),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  'Phone Number',
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 11),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'Product Category',
                        softWrap: true,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
