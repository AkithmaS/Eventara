import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eventara/core/router/app_routes.dart';

// ─── Color tokens ──────────────────────────────────────────────────────────
const _bgDeep = Color(0xFF0D0B1E);
const _bgCard = Color(0xFF151228);
const _purple = Color(0xFF7B5CF6);
const _textPrimary = Color(0xFFFFFFFF);
const _textSecondary = Color(0xFFB0A8D0);
const _accentGreen = Color(0xFF4ECB71);
const _accentOrange = Color(0xFFF59E0B);
const _accentRed = Color(0xFFEF4444);
const _accentBlue = Color(0xFF3B82F6);

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  String _selectedRole = 'All';
  String _selectedStatus = 'All';
  final List<String> _roles = ['All', 'Customers', 'Organizers'];
  final List<String> _statuses = ['All', 'Active', 'Suspended', 'Pending'];
  String _searchQuery = '';

  final List<Map<String, dynamic>> _users = [
    {
      'id': 1,
      'name': 'Elena Vance',
      'email': 'elena.vance@eventara.com',
      'role': 'Customer',
      'status': 'active',
      'joinDate': 'Jan 15, 2024',
      'avatar': 'EV',
    },
    {
      'id': 2,
      'name': 'Marcus Chen',
      'email': 'm.chen@gmail.com',
      'role': 'Organizer',
      'status': 'suspended',
      'joinDate': 'Feb 22, 2024',
      'avatar': 'MC',
    },
    {
      'id': 3,
      'name': 'Sarah Jamlian',
      'email': 'sarah.j@outlook.com',
      'role': 'Customer',
      'status': 'pending',
      'joinDate': 'Mar 10, 2024',
      'avatar': 'SJ',
    },
    {
      'id': 4,
      'name': 'David Ross',
      'email': 'david@pro-productions.co',
      'role': 'Organizer',
      'status': 'active',
      'joinDate': 'Dec 05, 2023',
      'avatar': 'DR',
    },
    {
      'id': 5,
      'name': 'Jennifer Liu',
      'email': 'jen.liu@company.com',
      'role': 'Customer',
      'status': 'active',
      'joinDate': 'Jan 30, 2024',
      'avatar': 'JL',
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return _accentGreen;
      case 'suspended':
        return _accentRed;
      case 'pending':
        return _accentOrange;
      default:
        return _accentBlue;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Icons.check_circle_rounded;
      case 'suspended':
        return Icons.cancel_rounded;
      case 'pending':
        return Icons.schedule_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter users based on search query, role, and status
    final filteredUsers = _users.where((user) {
      final matchesSearch = user['name']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          user['email']
              .toString()
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      final matchesRole =
          _selectedRole == 'All' || user['role'].contains(_selectedRole);
      final matchesStatus =
          _selectedStatus == 'All' ||
          user['status'].toString().toLowerCase() ==
              _selectedStatus.toLowerCase();
      return matchesSearch && matchesRole && matchesStatus;
    }).toList();

    return Scaffold(
      backgroundColor: _bgDeep,
      appBar: AppBar(
        backgroundColor: _bgDeep,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_rounded, color: _textPrimary),
        ),
        title: const Text(
          'User Management',
          style: TextStyle(
            color: _textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.search_rounded, color: _textSecondary, size: 20),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Search Bar ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: _bgCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) => setState(() => _searchQuery = value),
                    style: const TextStyle(color: _textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Search by name or email',
                      hintStyle: const TextStyle(color: _textSecondary),
                      prefixIcon: const Icon(Icons.search_rounded, color: _textSecondary),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),

              // ── Filter Tabs ─────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Role Filter
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _roles.length,
                        itemBuilder: (context, index) {
                          final role = _roles[index];
                          final isSelected = _selectedRole == role;
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index < _roles.length - 1 ? 8 : 0,
                            ),
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedRole = role),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFF7B5CF6),
                                            Color(0xFFE07BB0),
                                          ],
                                        )
                                      : null,
                                  color: isSelected ? null : _bgCard,
                                  borderRadius: BorderRadius.circular(20),
                                  border: isSelected
                                      ? null
                                      : Border.all(
                                          color: Colors.white.withValues(alpha: 0.1),
                                        ),
                                ),
                                child: Center(
                                  child: Text(
                                    role,
                                    style: TextStyle(
                                      color: isSelected ? _textPrimary : _textSecondary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Status Filter
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _statuses.length,
                        itemBuilder: (context, index) {
                          final status = _statuses[index];
                          final isSelected = _selectedStatus == status;
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index < _statuses.length - 1 ? 8 : 0,
                            ),
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedStatus = status),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFF7B5CF6),
                                            Color(0xFFE07BB0),
                                          ],
                                        )
                                      : null,
                                  color: isSelected ? null : _bgCard,
                                  borderRadius: BorderRadius.circular(20),
                                  border: isSelected
                                      ? null
                                      : Border.all(
                                          color: Colors.white.withValues(alpha: 0.1),
                                        ),
                                ),
                                child: Center(
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                      color: isSelected ? _textPrimary : _textSecondary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── Users List ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: List.generate(
                    filteredUsers.length,
                    (index) {
                      final user = filteredUsers[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index < filteredUsers.length - 1 ? 12 : 0,
                        ),
                        child: _UserCard(
                          user: user,
                          statusColor: _getStatusColor(user['status']),
                          statusIcon: _getStatusIcon(user['status']),
                          onTap: () => _showUserDetailsModal(context, user),
                          onAction: (action) =>
                              _handleUserAction(context, user, action),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: _bgCard,
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _BottomNavItem(
                  icon: Icons.dashboard_rounded,
                  label: 'Dashboard',
                  onTap: () => context.go(AppRoutes.adminDashboard),
                ),
                _BottomNavItem(
                  icon: Icons.people_rounded,
                  label: 'Users',
                  isActive: true,
                  onTap: () {},
                ),
                _BottomNavItem(
                  icon: Icons.event_rounded,
                  label: 'Events',
                  onTap: () => context.go(AppRoutes.adminEvents),
                ),
                _BottomNavItem(
                  icon: Icons.settings_rounded,
                  label: 'Settings',
                  onTap: () => context.go(AppRoutes.adminSettings),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showUserDetailsModal(BuildContext context, Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _bgCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              user['name'],
              style: const TextStyle(
                color: _textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user['email'],
              style: const TextStyle(
                color: _textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Role',
                        style: TextStyle(
                          color: _textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        user['role'],
                        style: const TextStyle(
                          color: _textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Join Date',
                        style: TextStyle(
                          color: _textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        user['joinDate'],
                        style: const TextStyle(
                          color: _textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _purple,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _handleUserAction(context, user, 'view_details');
                },
                child: const Text(
                  'View Full Details',
                  style: TextStyle(
                    color: _textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: _accentRed),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _handleUserAction(context, user, 'suspend');
                },
                child: const Text(
                  'Suspend User',
                  style: TextStyle(
                    color: _accentRed,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleUserAction(
    BuildContext context,
    Map<String, dynamic> user,
    String action,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Action: $action on ${user['name']}'),
        backgroundColor: _purple,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// ── User Card Widget ────────────────────────────────────────────────────────
class _UserCard extends StatelessWidget {
  final Map<String, dynamic> user;
  final Color statusColor;
  final IconData statusIcon;
  final VoidCallback onTap;
  final Function(String) onAction;

  const _UserCard({
    required this.user,
    required this.statusColor,
    required this.statusIcon,
    required this.onTap,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _bgCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7B5CF6), Color(0xFFE07BB0)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  user['avatar'],
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user['name'],
                    style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user['email'],
                    style: const TextStyle(
                      color: _textSecondary,
                      fontSize: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(statusIcon, color: statusColor, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    user['status'].toString().toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Bottom Nav Item Widget ──────────────────────────────────────────────────
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? _purple : _textSecondary,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? _purple : _textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
