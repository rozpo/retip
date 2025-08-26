import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Main Library Page with Tab Navigation
class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar with Search
            _buildAppBar(),
            // Tab Bar
            _buildTabBar(),
            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  PlaylistsTab(),
                  GenresTab(),
                  ArtistsTab(),
                  AlbumsTab(),
                  TracksTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (!_isSearching) ...[
            const Text(
              'Library',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
          ] else ...[
            Expanded(
              child: TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search library...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                ),
              ),
            ),
          ],
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.white),
            onPressed: () => _showSortOptions(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[900]!, width: 1)),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: const Color(0xFF1DB954),
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'Playlists'),
          Tab(text: 'Genres'),
          Tab(text: 'Artists'),
          Tab(text: 'Albums'),
          Tab(text: 'Tracks'),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _sortOption('Recently Added', Icons.access_time),
            _sortOption('Name (A-Z)', Icons.sort_by_alpha),
            _sortOption('Artist', Icons.person),
            _sortOption('Album', Icons.album),
            _sortOption('Duration', Icons.timer),
          ],
        ),
      ),
    );
  }

  Widget _sortOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () => Navigator.pop(context),
    );
  }
}

// Playlists Tab
class PlaylistsTab extends StatelessWidget {
  final List<Map<String, dynamic>> playlists = [
    {'name': 'Favorites', 'tracks': 42, 'color': const Color(0xFFE91E63)},
    {'name': 'Recently Played', 'tracks': 28, 'color': const Color(0xFF2196F3)},
    {'name': 'Workout Mix', 'tracks': 35, 'color': const Color(0xFFFF9800)},
    {'name': 'Chill Vibes', 'tracks': 56, 'color': const Color(0xFF4CAF50)},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Create Playlist Button
        Padding(
          padding: const EdgeInsets.all(16),
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Create Playlist',
              style: TextStyle(color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white54),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ),
        // Playlists Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return _PlaylistCard(
                name: playlist['name'],
                trackCount: playlist['tracks'],
                color: playlist['color'],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PlaylistCard extends StatelessWidget {
  final String name;
  final int trackCount;
  final Color color;

  const _PlaylistCard({
    required this.name,
    required this.trackCount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.8), color.withOpacity(0.4)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$trackCount tracks',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Genres Tab
class GenresTab extends StatelessWidget {
  final List<Map<String, dynamic>> genres = [
    {'name': 'Rock', 'color': const Color(0xFFF44336)},
    {'name': 'Pop', 'color': const Color(0xFFE91E63)},
    {'name': 'Electronic', 'color': const Color(0xFF00BCD4)},
    {'name': 'Hip Hop', 'color': const Color(0xFF9C27B0)},
    {'name': 'Jazz', 'color': const Color(0xFF3F51B5)},
    {'name': 'Classical', 'color': const Color(0xFF795548)},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: genres.length,
      itemBuilder: (context, index) {
        final genre = genres[index];
        return _GenreCard(name: genre['name'], color: genre['color']);
      },
    );
  }
}

class _GenreCard extends StatelessWidget {
  final String name;
  final Color color;

  const _GenreCard({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Artists Tab
class ArtistsTab extends StatelessWidget {
  final List<Map<String, String>> artists = [
    {'name': 'Arctic Monkeys', 'tracks': '48'},
    {'name': 'The Beatles', 'tracks': '127'},
    {'name': 'Radiohead', 'tracks': '89'},
    {'name': 'Pink Floyd', 'tracks': '64'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[800],
            child: Text(
              artist['name']![0],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            artist['name']!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            '${artist['tracks']} tracks',
            style: TextStyle(color: Colors.grey[600]),
          ),
          trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
          onTap: () {},
        );
      },
    );
  }
}

// Albums Tab
class AlbumsTab extends StatelessWidget {
  final List<Map<String, dynamic>> albums = [
    {'title': 'AM', 'artist': 'Arctic Monkeys', 'year': '2013'},
    {'title': 'Abbey Road', 'artist': 'The Beatles', 'year': '1969'},
    {'title': 'OK Computer', 'artist': 'Radiohead', 'year': '1997'},
    {'title': 'The Wall', 'artist': 'Pink Floyd', 'year': '1979'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return _AlbumCard(
          title: album['title'],
          artist: album['artist'],
          year: album['year'],
        );
      },
    );
  }
}

class _AlbumCard extends StatelessWidget {
  final String title;
  final String artist;
  final String year;

  const _AlbumCard({
    required this.title,
    required this.artist,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Album Cover Placeholder
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.album, size: 64, color: Colors.white24),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '$artist • $year',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// Tracks Tab
class TracksTab extends StatelessWidget {
  final List<Map<String, String>> tracks = [
    {
      'title': 'Do I Wanna Know?',
      'artist': 'Arctic Monkeys',
      'duration': '4:32',
    },
    {'title': 'Come Together', 'artist': 'The Beatles', 'duration': '4:19'},
    {'title': 'Karma Police', 'artist': 'Radiohead', 'duration': '4:21'},
    {'title': 'Wish You Were Here', 'artist': 'Pink Floyd', 'duration': '5:34'},
    {'title': 'R U Mine?', 'artist': 'Arctic Monkeys', 'duration': '3:21'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        final track = tracks[index];
        return ListTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.music_note, color: Colors.white24),
          ),
          title: Text(
            track['title']!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          subtitle: Text(
            track['artist']!,
            style: TextStyle(color: Colors.grey[600]),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                track['duration']!,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(width: 8),
              Icon(Icons.more_vert, color: Colors.grey[600]),
            ],
          ),
          onTap: () {},
        );
      },
    );
  }
}
