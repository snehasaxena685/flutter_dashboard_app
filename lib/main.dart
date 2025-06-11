import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const OfficeDashboardApp());
}

class OfficeDashboardApp extends StatelessWidget {
  const OfficeDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Office Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF6F8FC),
      ),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SidebarWidget(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HeaderWidget(),
                  SizedBox(height: 16),
                  TopSectionWidget(),
                  SizedBox(height: 16),
                  MiddleSectionWidget(),
                  SizedBox(height: 16),
                  PerformanceChartWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: const Color(0xFF1F2937),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              'assets/images/logo1.jpeg',
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text('Sneha', style: GoogleFonts.poppins(color: Colors.white)),
          const SizedBox(height: 32),
          const SidebarItem(icon: Icons.home, title: 'Home'),
          const SidebarItem(icon: Icons.people, title: 'Employees'),
          const SidebarItem(icon: Icons.list_alt, title: 'Attendance'),
          const SidebarItem(icon: Icons.summarize, title: 'Summary'),
          const SidebarItem(icon: Icons.info_outline, title: 'Information'),
          const Divider(color: Colors.white54),
          const SidebarItem(icon: Icons.workspaces_outline, title: 'Adstacks'),
          const SidebarItem(icon: Icons.account_balance, title: 'Finance'),
          const Spacer(),
          const SidebarItem(icon: Icons.settings, title: 'Setting'),
          const SidebarItem(icon: Icons.logout, title: 'Logout'),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const SidebarItem({required this.icon, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 12),
          Text(title, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Home', style: Theme.of(context).textTheme.headlineMedium),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
            const CircleAvatar(radius: 16),
          ],
        ),
      ],
    );
  }
}

class TopSectionWidget extends StatefulWidget {
  const TopSectionWidget({super.key});

  @override
  State<TopSectionWidget> createState() => _TopSectionWidgetState();
}

class _TopSectionWidgetState extends State<TopSectionWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> images = [
    'assets/images/project1.png',
    'assets/images/project2.jpg',
    'assets/images/project3.jpeg',
  ];
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final birthdayImages = [
      {'img': 'birthday1.jpg', 'name': 'RON'},
      {'img': 'birthday2.jpg', 'name': 'MAX'},
      {'img': 'birthday3.jpeg', 'name': 'CHARLIE'},
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 16,
                child: Text(
                  'Top Rating Projects',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      const Shadow(
                        blurRadius: 4,
                        color: Colors.black45,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today),
                  label: const Text("Birthday Today"),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 100,
                padding: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: birthdayImages.map((entry) {
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/${entry['img']}',
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(entry['name']!,
                            style: const TextStyle(fontSize: 10)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MiddleSectionWidget extends StatelessWidget {
  const MiddleSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final projectNames = [
      'AI Assistant Bot',
      'E-Commerce Web App',
      'IoT Weather Station',
      'Chat App',
      'Online Course Platform',
      'Finance Tracker App',
      'Portfolio Website',
    ];

    final creators = [
      {'name': 'Sneha', 'artworks': '25', 'rating': '4.8'},
      {'name': 'Rahul', 'artworks': '18', 'rating': '4.5'},
      {'name': 'Nisha', 'artworks': '30', 'rating': '4.9'},
      {'name': 'Riyaa', 'artworks': '30', 'rating': '4.9'},
      {'name': 'Rahul', 'artworks': '30', 'rating': '4.9'},
      {'name': 'Ritika', 'artworks': '30', 'rating': '4.9'},
    ];

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F8FC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('All Projects List',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 12),
                ...projectNames.map((name) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(name,
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.black87)),
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Container(
            height: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Top Creators',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Artworks",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Rating",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(),
                ...creators.map((c) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(c['name']!),
                          Text(c['artworks']!),
                          Text(c['rating']!),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PerformanceChartWidget extends StatefulWidget {
  const PerformanceChartWidget({super.key});

  @override
  State<PerformanceChartWidget> createState() => _PerformanceChartWidgetState();
}

class _PerformanceChartWidgetState extends State<PerformanceChartWidget>
    with SingleTickerProviderStateMixin {
  final List<double> dataDone = [10.0, 20.0, 30.0, 40.0, 45.0, 50.0];
  final List<double> dataPending = [40.0, 35.0, 30.0, 25.0, 20.0, 10.0];
  double animationValue = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {
          animationValue = _controller.value;
        });
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8FC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildLegend(Colors.red, "Project Pending"),
              const SizedBox(width: 16),
              _buildLegend(Colors.green, "Project Done"),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const years = [
                          '2015',
                          '2016',
                          '2017',
                          '2018',
                          '2019',
                          '2020'
                        ];
                        if (value.toInt() >= 0 &&
                            value.toInt() < years.length) {
                          return Text(years[value.toInt()]);
                        } else {
                          return const Text('');
                        }
                      },
                    ),
                  ),
                ),
                minX: 0,
                maxX: 5,
                minY: 0,
                maxY: 50,
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    spots: List.generate(
                        (dataDone.length * animationValue).floor(),
                        (i) => FlSpot(i.toDouble(), dataDone[i])),
                    barWidth: 3,
                    color: Colors.green,
                    dotData: FlDotData(show: false),
                  ),
                  LineChartBarData(
                    isCurved: true,
                    spots: List.generate(
                        (dataPending.length * animationValue).floor(),
                        (i) => FlSpot(i.toDouble(), dataPending[i])),
                    barWidth: 3,
                    color: Colors.red,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
