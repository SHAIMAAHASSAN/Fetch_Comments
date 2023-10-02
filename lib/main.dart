import 'package:flutter/material.dart';
import 'package:news_cloud/model/HandlerHTTP.dart';
import 'model/Article.dart';

void main()  {


  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HTTPHandler httpHandler = HTTPHandler();
  late Future<List<Article>> articleList;

  @override
  void initState() {
    super.initState();
    articleList= httpHandler.fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const  Text("Fetching Data from Json"),
        ),
        body:FutureBuilder(
          future: articleList,
          builder: (context, snapshot)
          {
            if(snapshot.hasData)
            {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index){
                  return Divider();
                },
                itemBuilder: (context, index)
                {
                  if(index ==0)
                  {
                    return Column(
                      children: [
                        const SizedBox(height: 20,),
                        buildCard(snapshot.data![index]),
                      ],
                    );
                  }
                  else {
                    return buildCard(snapshot.data![index]);
                  }
                },
              );

            }
            else if(snapshot.hasError)

            {final error = snapshot.error;
              print(error);
              return const Center(child: Text("something wrong"),);
            }
            else{
              return  Container(child: CircularProgressIndicator(),);
            }
          },
        )
    );
  }

  buildCard(Article article)
  {
    return  Card(
      elevation: 7,
      margin:  const EdgeInsets.all(5),
      child: Container(

        padding: const EdgeInsets.all(8),

        child:Column(
          children: [
           Text(article.id.toString(),style: TextStyle(color: Colors.red),),
            Text("name: "+ article.name),
            Text("email: "+article.email),
            Text("body: "+article.body),

          ],
        )

    ) ,
        );


  }

}
