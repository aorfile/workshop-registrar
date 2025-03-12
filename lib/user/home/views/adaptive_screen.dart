import 'package:flutter/material.dart';


class AdaptiveScaffold extends StatelessWidget {
  final int selectedIndex;
  final List<NavigationDestination> destinations;

  final ValueChanged<int> onDestinationSelected;
  final Widget body;
  final String? title;

  const AdaptiveScaffold({
    super.key,
    required this.selectedIndex,
    required this.destinations,
  
    required this.onDestinationSelected,
    required this.body,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return _WideLayout(
            selectedIndex: selectedIndex,
            destinations: destinations,
            onDestinationSelected: onDestinationSelected,
            body: body,
            title: title,
          );
        }
        return _NarrowLayout(
          selectedIndex: selectedIndex,
          
          onDestinationSelected: onDestinationSelected,
          body: body,
          title: title,
        );
      },
    );
  }
}

class _WideLayout extends StatelessWidget {
  final int selectedIndex;
  final List<NavigationDestination> destinations;
  final ValueChanged<int> onDestinationSelected;
  final Widget body;
  final String? title;

  const _WideLayout({
    Key? key,
    required this.selectedIndex,
    required this.destinations,
    required this.onDestinationSelected,
    required this.body,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            destinations: destinations.map((destination) {
              return NavigationRailDestination(
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
                label: Text(destination.label),
              );
            }).toList(),
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            leading: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                'assets/images/logo.png',
                height: 32,
              ),
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Column(
              children: [
                
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      title!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NarrowLayout extends StatelessWidget {
  final int selectedIndex;
  
  final ValueChanged<int> onDestinationSelected;
  final Widget body;
  final String? title;

  const _NarrowLayout({
    Key? key,
    required this.selectedIndex,
    
    required this.onDestinationSelected,
    required this.body,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
            )
          : null,
      body: Column(
        children: [
    
          Expanded(child: body),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onDestinationSelected,
        currentIndex: selectedIndex,
        items: [  
          BottomNavigationBarItem(icon:Icon(Icons.home_outlined),
      activeIcon:  Icon(Icons.home)),
           BottomNavigationBarItem(icon:Icon(Icons.event_note_outlined), activeIcon:Icon(Icons.event_note)  ),
            BottomNavigationBarItem(icon:Icon(Icons.folder_outlined) ,activeIcon:Icon(Icons.folder) ),
          BottomNavigationBarItem(icon:Icon(Icons.person_outline),activeIcon: Icon(Icons.person)  ),
        ]
       
      ),
    );
  }
}