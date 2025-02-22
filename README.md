# PST SpaceX - Flutter App
 **Flutter SDK:** 3.29.0  

This Flutter application displays SpaceX launches using the SpaceX API.
Users can **view launch details, sort, search, and navigate to a detailed page** for each mission.
The project follows **Clean Architecture** and uses **BLoC for state management**.

---
## 🚀 Features Implemented  

✅ **BLoC State Management** (flutter_bloc)  
✅ **Displays launch list with relevant fields** (Mission Name, Date, Status, etc.)  
✅ **Launch detail page with extended information** (Rocket, Crew, Launchpad)  
✅ **Sorting options** (Sort by Name, Date - Newest to Oldest, Oldest to Newest)  
✅ **Search functionality** (Filter launches dynamically)  
✅ **Multi-flavor support** (mock & prod) - Mock uses local JSON  
✅ **Responsive** UI: Mobile & Tablet 
✅ **Uses SpaceX API endpoints**:  
   - **POST** `/v5/launches/query` (Pagination, Sorting)  
   - **GET** `/v4/rockets/{id}` (Rocket Info)  
   - **GET** `/v4/launchpads/{id}` (Launchpad Info)  

### 🔹 **Unfinished Due to Time Constraints:**
❌ **Unit Tests** (Datasource Tests)  
❌ **UI Tests**  
❌ **BLoC Tests**  
❌ **Golden Tests**  
❌ **Smooth Page Transitions**  

---

## 📦 Dependencies Used  

- `flutter_bloc` - State Management  
- `dio` - API Networking  
- `json_serializable` - JSON Parsing  
- `get_it` - Dependency Injection  
- `intl` - Date Formatting  
- `flutter_test` - Testing Framework  


## 📜 Project Setup Instructions
### 🔹 **1. Clone the repository**
```sh
git clone https://github.com/your-repo/spacex-launches.git
cd spacex-launches
fvm flutter use 3.29.0
fvm flutter pub get
sh initial.sh
```


## Project Structure
```
lib/
├── common/
│   ├── utils/
│   │   └── responsive.dart  # Handles UI responsiveness
│   └── widgets/images/
│       └── app_image.dart  # Widget for displaying images
│
├── core/
│   ├── api/
│   │   ├── api_config.dart  # API configurations
│   │   └── api_service.dart  # API service for fetching data
│   └── configuration/
│       └── app_flavor.dart  # App flavor settings (mock/prod)
│
├── di/
│   └── app_module.dart  # Dependency Injection setup
│
├── extension/
│   └── date_extension.dart  # Helper for formatting dates
│
├── features/
│   └── launch/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── launch_remote_data_source.dart  # Fetches launch data from API
│       │   │   ├── mock_launch_remote_data_source.dart  # Mock API data source
│       │   ├── models/
│       │   │   ├── launch_model.dart  # Launch data model
│       │   │   ├── launchpad_model.dart  # Launchpad data model
│       │   │   ├── rocket_model.dart  # Rocket data model
│       │   ├── repositories/
│       │   │   └── launch_repository_impl.dart  # Implements repository pattern
│       │
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── launch.dart  # Launch entity
│       │   │   ├── launchpad.dart  # Launchpad entity
│       │   │   ├── rocket.dart  # Rocket entity
│       │   ├── repositories/
│       │   │   └── launch_repository.dart  # Repository interface
│       │   ├── usecases/
│       │       ├── get_launchpad_id.dart  # Fetches launchpad details
│       │       ├── get_query_launches.dart  # Fetches launches with query
│       │       ├── get_rocket_id.dart  # Fetches rocket details
│       │
│       ├── presentation/
│       │   ├── bloc/
│       │   │   ├── launch_bloc.dart  # Main BLoC for launches
│       │   │   ├── launch_event.dart  # Events for launch BLoC
│       │   │   ├── launch_state.dart  # States for launch BLoC
│       │   │   ├── detail/
│       │   │   │   ├── launch_detail_bloc.dart  # Handles launch detail state
│       │   ├── pages/
│       │   │   ├── launch_page.dart  # Launch list screen
│       │   │   ├── launch_detail_page.dart  # Launch detail screen
│       │   ├── widgets/
│       │   │   ├── launch_list_item.dart  # Widget for launch list items
│       │   │   ├── search_bar_widget.dart  # Search bar widget
│       │   │   ├── sort_options_widget.dart  # Sorting options widget
│
├── generator/
│   └── assets.gen.dart  # Manages assets
│
├── main.dart  # Application entry point
│
assets/
├── .env-mock  # Mock environment configuration
└── .env-prod  # Production environment configuration
│
test/
├── features/
│   └── launch/
│       ├── data/
│       │   ├── launch_remote_data_source_test.dart  # Tests API data source
│       │   ├── mock_launch_data.json  # Mock test data
│       ├── domain/
│       │   ├── get_launchpad_id_test.dart  # Tests fetching launchpad data
│       │   ├── get_rocket_id_test.dart  # Tests fetching rocket data
│       ├── presentation/bloc/
│       │   ├── launch_bloc_test.dart  # Tests for launch BLoC
│
└── widget_test.dart  # General UI tests
```
```
📂 features/launch/ - Main module for SpaceX launches
🔹 data/ (Handles API calls & data conversion)
datasources/
  launch_remote_data_source.dart - Fetches launch data from API
  mock_launch_remote_data_source.dart - Mock API data source for testing
models/
  launch_model.dart - Defines API response for launch data
  launch_query_request.dart - Defines API request structure
repositories/
  launch_repository_impl.dart - Converts API models to entities & provides data to the domain layer

🔹 domain/ (Business logic layer)
entities/
  launch.dart - Core entity representing a launch
  launchpad.dart - Core entity representing a launchpad
  
repositories/
  launch_repository.dart - Interface defining launch data methods
usecases/
  get_launchpad_id.dart - Fetches launchpad details
  get_query_launches.dart - Fetches launches with pagination & sorting

🔹 presentation/ (UI layer)
BLoC (State Management)
  launch_bloc.dart - Handles launch list state
  launch_event.dart - Defines actions users can take
  launch_state.dart - Defines UI states (loading, success, error)
Pages (UI Screens)
  launch_page.dart - Displays a list of launches
Widgets (UI Components)
  launch_list_item.dart - UI component for each launch
  search_bar_widget.dart - Search bar for filtering launches
  sort_options_widget.dart - Dropdown for sorting launches
📂 test/ - Unit and widget tests
Unit Tests
  launch_remote_data_source_test.dart - Tests API data source
  mock_launch_data.json - Mock test data
Use Case Tests
  get_launchpad_id_test.dart - Tests fetching launchpad details
  get_rocket_id_test.dart - Tests fetching rocket details
BLoC Tests
  launch_bloc_test.dart - Tests for launch BLoC
```


## 📸 UI Showcase  

### **📌 Mobile View**  
![Mobile Main](assets/images/m_flow.gif)
![Mobile Main](assets/images/ipad_flow.gif)

| Main Screen | Detail Page | Search | Sort |
|------------|------------|--------|------|
| ![Mobile Main](assets/images/m1.png) | ![Mobile Detail](assets/images/mdetail.png) | ![Mobile Search](assets/images/msearch.png) | ![Mobile Sort](assets/images/msort.png) |
|| ![Mobile Detail 1](assets/images/mdetail1.png) |  | ![Mobile Search 1](assets/images/msearch1.png) | ![Mobile Sort 1](assets/images/msort2.png) |

---

### **📌 Tablet View (iPad UI)**  
| Main Screen | Detail Page | More Info | Search | Sort |
|------------|------------|------------|--------|------|
| ![iPad Main](assets/images/ipad.png) | ![iPad Detail](assets/images/ipaddetail.png) | ![iPad More](assets/images/ipadmore.png) | ![iPad Search](assets/images/ipadsearch.png) | ![iPad Sort](assets/images/ipadsort1.png) |
|| ![iPad Detail 1](assets/images/ipaddetail1.png) |  |  | ![iPad Search 1](assets/images/ipadsearch1.png) | ![iPad Sort 2](assets/images/ipadsort2.png) |

---
