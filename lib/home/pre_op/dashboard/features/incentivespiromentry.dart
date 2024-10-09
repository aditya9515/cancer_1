import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:video_player/video_player.dart';

class IncentiveSpirometryScreen extends StatefulWidget {
  @override
  _IncentiveSpirometryScreenState createState() => _IncentiveSpirometryScreenState();
}

class _IncentiveSpirometryScreenState extends State<IncentiveSpirometryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late VideoPlayerController _videoController;
  final List<String> days = ['Day 1'];
  final Map<String, int> ballsSelected = {'Day 1': 1}; // Store selected balls count for each day.

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _videoController = VideoPlayerController.asset('assets/videos/your_video.mp4')
      ..initialize().then((_) {
        setState(() {}); 
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Incentive Spirometry',
          style: TextStyle(color: const Color.fromARGB(221, 243, 243, 243)),
          
        ),
        backgroundColor: const Color.fromARGB(255, 247, 143, 26),
        centerTitle: true,
        elevation: 1,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Guide'),
            
            Tab(text: 'Feedback'),
          ],
          labelColor: const Color.fromARGB(255, 255, 255, 255), // Use orange accent for tab labels
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.of(context).pop();  // Go back to previous screen
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Guide Tab: Video Player
          _buildGuideTab(),
          // Feedback Tab: DataTable and BarChart
          _buildFeedbackTab(),
        ],
      ),
    );
  }

  Widget _buildGuideTab() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          height: 300,
          child: _videoController.value.isInitialized
              ? Column(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: _videoController.value.aspectRatio,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: VideoPlayer(_videoController),
                        ),
                      ),
                    ),
                    VideoProgressIndicator(
                      _videoController,
                      allowScrubbing: true,
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      colors: VideoProgressColors(playedColor: Colors.orangeAccent), // Orange progress bar
                    ),
                    _buildVideoControls(),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Incentive Spirometry Guide in Kannada',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(
            _videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.orangeAccent, // Use orange accent for play/pause
          ),
          onPressed: () {
            setState(() {
              _videoController.value.isPlaying ? _videoController.pause() : _videoController.play();
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.stop, color: Colors.redAccent),
          onPressed: () {
            setState(() {
              _videoController.pause();
              _videoController.seekTo(Duration.zero);
            });
          },
        ),
      ],
    );
  }

  // Modern Feedback Tab: DataTable and BarChart
  Widget _buildFeedbackTab() {
    return Column(
      children: [
        // DataTable with Ball Selection
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DataTable(
                columns: days.map((day) => DataColumn(label: Text(day, style: TextStyle(fontSize: 16)))).toList(),
                rows: [
                  DataRow(cells: days.map((day) => _buildBallSelectionCell(day)).toList())
                ],
              ),
            ),
          ),
        ),
        // Add Day Button
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent, // Orange accent for button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            ),
            onPressed: () {
              setState(() {
                final newDay = 'Day ${days.length + 1}';
                days.add(newDay);
                ballsSelected[newDay] = 1;
              });
            },
            child: Text('Add Day', style: TextStyle(fontSize: 16)),
          ),
        ),
        // BarChart for Ball Feedback
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: days.length * 100.0,
                  child: BarChart(
                    BarChartData(
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              int index = value.toInt();
                              return Text(index >= 0 && index < days.length ? days[index] : '');
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: _generateBarGroups(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    return List.generate(days.length, (index) {
      final day = days[index];
      final ballCount = ballsSelected[day] ?? 1;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: ballCount.toDouble(),
            color: Colors.orangeAccent, // Use orange for the bars
            width: 16,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      );
    });
  }

  DataCell _buildBallSelectionCell(String day) {
    return DataCell(
      DropdownButton<int>(
        value: ballsSelected[day],
        style: TextStyle(color: Colors.black87, fontSize: 16),
        items: [
          DropdownMenuItem(value: 1, child: Text('Single Ball')),
          DropdownMenuItem(value: 2, child: Text('Two Balls')),
          DropdownMenuItem(value: 3, child: Text('Three Balls')),
        ],
        onChanged: (value) {
          if (value != null) {
            setState(() {
              ballsSelected[day] = value;
            });
          }
        },
      ),
    );
  }
}
