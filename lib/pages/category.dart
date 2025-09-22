import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/widgets/categoryScreen.dart';
class categoryPage extends StatefulWidget {
  const categoryPage({super.key});

  @override
  State<categoryPage> createState() => _categoryPageState();
}

class _categoryPageState extends State<categoryPage> {
   final List<String> category=["Cityscapes & Skylines","Night","Cherry Blossom","Cars & Automobiles","Space & Galaxy","Sports","Dark & Aesthetic","Under Water"];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Category",style: GoogleFonts.acme(textStyle:TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold)),),
        backgroundColor: Colors.black,
        elevation: 15,
        actions: [
          IconButton(
            icon:Icon(Icons.search,color: Colors.white,size: 30,),
            onPressed: (){},
          )
        ],
      ),
      body:Center(
        child:Column(
            children:[
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child:GridView.builder(
                      itemCount: category.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio:4/3,),
                      itemBuilder: (context,index){
                        return  InkWell(
                          onTap: () {
                            // Handle category tap
                            // You can navigate to a new page or perform any action you want
                            print("Category tapped: ${category[index]}");
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => categoryWidget(query: category[index], category: category[index],)));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage("assets/${category[index]}.webp"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Wrap(
                                // direction: Axis.vertical,
                                children: [
                                  Center(
                                    child: Text(category[index],style: GoogleFonts.acme(textStyle:TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),),
                                  ),
                                ],
                              )
                              ),
                        );
                      }),

                ),
              )
            ]
        ),
      ),

    );
  }
}
