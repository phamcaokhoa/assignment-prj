import 'package:bookingpitch5/api/api_sub_pitch_service.dart';
import 'package:bookingpitch5/models/sub_pitch/sub_pitch_model.dart';
import 'package:bookingpitch5/screen/home_screen/footer_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class ListSubPitch extends StatelessWidget {
  final String typeOfPitch;
  const ListSubPitch(this.typeOfPitch,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
            title: const Text("Tìm theo thể loại sân", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            centerTitle: true,
            backgroundColor: Colors.green,
            ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              BookedPitch(typeOfPitch),
              // Text("Lịch sử đặt sân")
            ],
          ),
        );
  }
}
//       BookedItem("Sân A,B,C", "0:00", "23:00", "assets/images/img1.jpg", "Khu Liên Hiệp Thể Thao TNG", "27/311/D To 85 Thống Nhất, Phường 15, Gò Vấp, Thành phố Hồ Chí Minh."),
class BookedPitch extends StatefulWidget {
  final String typeOfPitch;
  const BookedPitch(this.typeOfPitch, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _BookedPitchState(typeOfPitch);
}

class _BookedPitchState extends State<BookedPitch> {

  final String typeOfPitch;
  _BookedPitchState(this.typeOfPitch);
  @override
  Widget build(BuildContext context) {

    var listPitch = SubPitchServce().getListSubPitchByTypeOfPitch(typeOfPitch);
    return SingleChildScrollView(
      child: FutureBuilder<List<SubPitchModel>>(
          future: listPitch,
          builder: (BuildContext context,
              AsyncSnapshot<List<SubPitchModel>> snapshot) {
            List<Widget> children = [];
            SubPitchModel data;
            if (snapshot.hasData) {
              for (int i = 0; i < snapshot.data!.length; i++) {
                data = snapshot.data!.elementAt(i);
                children.add(BookedItem(
                  data.name,
                  data.pitch_name,
                  "",
                  data.img_path,
                  data.SpecialDayPrice.toString()+"/1h",data.normalDay.toString()+"/1h",
                ));
              }
            }else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ];
            }
            return Column(children:children);
          }
      ),
    );
  }
}

class BookedItem extends StatefulWidget {
  var type, time, date, img, name, address;

  BookedItem(this.type, this.time, this.date, this.img, this.name, this.address, {Key? key}) : super(key: key);

  @override
  State<BookedItem> createState() => _BookedItemState();
}

class _BookedItemState extends State<BookedItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
        margin: const EdgeInsets.only(top: 15),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(widget.type, style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.time, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(width: 20),
                    Text(widget.date, style: const TextStyle(color: Colors.grey))
                  ]
              )
            ]
        ),

    GestureDetector(
    onTap:() => Navigator.of(context).pushNamed('/checkLocation'),
    child:
    Container(
    child:
            Row(
              children: [
                Image(
                  image: AssetImage(widget.img),
                  width: 100,
                  height: 100,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  width: 255,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text("Giá ngày cuối tuần", style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.name, ),
                        ],
                      ),
                      const SizedBox(height: 10),Row(
                        children: [
                          Text("Giá ngày thường", style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.address),
                        ],
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
              ],
            ))),
            const Divider(color: Colors.black),
          ],
        ),
      );
  }
}


class CompleteBottomPart extends StatelessWidget {
  const CompleteBottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Image(
          image: AssetImage("assets/images/complete.png"),
          // width: 100,
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/ratePitch');
              },
              child: const Text("Đánh giá", style: TextStyle(fontWeight: FontWeight.bold)),
              style: OutlinedButton.styleFrom(
                primary: Colors.green,
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.green, width: 2)
              )
            ),
            const SizedBox(width: 20),
            FlatButton(
              onPressed: () {},
              child: const Text("Đặt lại", style: TextStyle(fontWeight: FontWeight.bold)),
              color: Colors.green,
              textColor: Colors.white,
            )
          ],
        )
      ],
    );
  }
}

class CancelBottomPart extends StatelessWidget {
  const CancelBottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Image(
          image: AssetImage("assets/images/cancel.png"),
          // width: 100,
          height: 50,
        ),
        FlatButton(
          onPressed: () {},
          child: const Text("Đặt lại", style: TextStyle(fontWeight: FontWeight.bold)),
          color: Colors.green,
          textColor: Colors.white,
        )
      ],
    );
  }
}