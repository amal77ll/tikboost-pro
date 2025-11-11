import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher_string.dart';

void main() => runApp(TikBoostProApp());

class TikBoostProApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikBoost Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF160033),
        primaryColor: Color(0xFF7B2CFF),
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TikBoost Pro', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.settings_outlined))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(child: _BrandCard()),
          SizedBox(height: 20),
          _QuickActions(),
          SizedBox(height: 20),
          _VipStarsCard(),
        ],
      ),
    );
  }
}

class _BrandCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120, height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(colors: [Color(0xFF7B2CFF), Color(0xFF2BE0FF)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0,6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Image.asset('assets/images/tikboost_pro_artwork.jpg', fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 12),
        Text('TikBoost Pro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        Text('VIP growth • Smart boosts • Real accounts', style: TextStyle(color: Colors.white70)),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ActionTile(icon: Icons.person_add, title: 'Get Followers'),
        _ActionTile(icon: Icons.trending_up, title: 'Boost Views'),
        _ActionTile(icon: Icons.star, title: 'VIP Stars'),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  _ActionTile({required this.icon, required this.title});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          if(title=='VIP Stars'){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>VipStarsPage()));
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 6),
          padding: EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: Color(0xFF1B002D),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            children: [
              Icon(icon, size: 28, color: Color(0xFF7B2CFF)),
              SizedBox(height: 8),
              Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 12))
            ],
          ),
        ),
      ),
    );
  }
}

class _VipStarsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF120019),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Color(0xFFFFC857)),
              SizedBox(width: 8),
              Text('VIP Stars', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Spacer(),
              Text('Premium', style: TextStyle(color: Colors.white60))
            ],
          ),
          SizedBox(height: 12),
          Text('Exclusive features for VIP members: automated boosts, priority support, and analytics.', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF7B2CFF)),
            onPressed: (){},
            child: Text('Join VIP Stars')
          )
        ],
      ),
    );
  }
}

class VipStarsPage extends StatefulWidget {
  @override
  _VipStarsPageState createState() => _VipStarsPageState();
}

class _VipStarsPageState extends State<VipStarsPage> {
  List vip = [];

  @override
  void initState() {
    super.initState();
    loadVip();
  }

  Future<void> loadVip() async {
    try {
      final s = await rootBundle.loadString('assets/data/vip_stars.json');
      final data = json.decode(s);
      setState(() => vip = data);
    } catch (e) {
      setState(() => vip = []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VIP Stars')),
      body: vip.isEmpty ? Center(child: Text('No VIP stars found', style: TextStyle(color: Colors.white70))) :
      ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: vip.length,
        itemBuilder: (context, i) {
          final item = vip[i];
          return GestureDetector(
            onTap: () async {
              final url = item['url'] ?? '';
              if (url.isNotEmpty) {
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cannot open link')));
                }
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical:8),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Color(0xFF0E001A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10)
              ),
              child: Row(
                children: [
                  CircleAvatar(radius: 28, backgroundColor: Color(0xFF7B2CFF), child: Text((item['name'] ?? ' ')[0], style: TextStyle(color: Colors.white))),
                  SizedBox(width:12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(item['name'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height:6),
                    Text('${item['platform'] ?? ''} • ${item['followers'] ?? ''}', style: TextStyle(color: Colors.white70)),
                  ])),
                  Text(item['badge'] ?? '', style: TextStyle(fontWeight: FontWeight.bold))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}