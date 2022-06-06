import 'dart:math';

import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final Map data;
  const ProfileCard({Key? key, required this.data}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.blueGrey,
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        Random().nextInt(10).toString(),
                        style: const TextStyle(
                          color: Colors.lightBlue,
                        ),
                      ),
                      const Text(
                        'Plans',
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        Random().nextInt(20).toString(),
                        style: const TextStyle(
                          color: Colors.lightBlue,
                        ),
                      ),
                      const Text('People'),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          NetworkImage('https://source.unsplash.com/random'),
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Colors.lightBlue,
                      ),
                      Text(Random().nextDouble().toStringAsFixed(2)),
                      const SizedBox(
                        height: 6,
                      ),
                      Icon(
                        widget.data['gender'] == 'female'
                            ? Icons.female
                            : Icons.male,
                        color: Colors.lightBlue,
                      ),
                      Text(widget.data['gender']),
                    ],
                  ),
                ],
              ),
              Center(
                child: Text(
                  '${widget.data['name']}, ${widget.data['age']}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Center(
                child: Text(
                  '${widget.data['about']}',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Interests',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue)),
                    const SizedBox(height: 4.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: ['sports', 'fruits', 'food'].map<Widget>((e) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                'https://source.unsplash.com/random/?$e',
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "WALL OF FAVOURITES",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.lightBlue),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: ['sports', 'fruits', 'food'].map<Widget>((e) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                'https://source.unsplash.com/random/?$e',
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
