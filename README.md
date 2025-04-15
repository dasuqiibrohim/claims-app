# Claims App

This app displays a list of insurance claims and allows users to search and view details. Built using SwiftUI with MVVM architecture and async/await networking.


## Results

### Claim List

This screen displays a list of insurance claims. Each claim item shows:

- Claim title (bold)
- Claim description (max 2 lines)
- Optional: Claim ID and Claimant ID

Below are the different UI states for the Claim List screen:

| Initial View | Scroll View | Loading State |
|--------------|-------------|----------------|
| Shows the first set of claims when the screen loads. | Displays additional claims when the user scrolls. | Shows a loading spinner while fetching claim data from the server. |
| <img width="256" alt="Screenshot 2025-04-15 at 11 43 58" src="https://github.com/user-attachments/assets/0ab546d5-c218-4b18-a6eb-e009cf44753f" />  | <img width="256" alt="Screenshot 2025-04-15 at 12 37 27" src="https://github.com/user-attachments/assets/7f0d0a88-b888-442a-96b0-1209b21c698a" />  | <img width="256" alt="Screenshot 2025-04-15 at 11 57 51" src="https://github.com/user-attachments/assets/b5e53c47-4544-4c7d-b792-e4cfe066fa06" />  |

### Claim Detail 

This screen shows detailed information about a selected claim. It displays:

- Claim Title
- Full Claim Description
- Optional fields: Claim ID and Claimant ID

Users can access this view by tapping on a claim item from the Claim List.

<img width="256" alt="Screenshot 2025-04-15 at 12 05 04" src="https://github.com/user-attachments/assets/9f72a2d9-0998-4b04-a6d3-1a690272aad4" /> <img width="256" alt="Screenshot 2025-04-15 at 12 05 15" src="https://github.com/user-attachments/assets/3c51d0d7-1921-4c3a-83ed-f4180ac86284" />

### Search Claim Data

This screen displays a list of insurance claims based on the user's search. There are two possible UI states on the Claim List screen:

| Found Data | No Data Found | 
|--------------|-------------|
| Displays a list of claims when search results are found. The initial screen also shows the first set of available claims. | Displays a message or empty state when no claims match the search query. |
| <img width="256" alt="Screenshot 2025-04-15 at 12 45 39" src="https://github.com/user-attachments/assets/2b08a0d4-1216-4df5-8a41-caac4b16074b" />  | <img width="256" alt="Screenshot 2025-04-15 at 12 44 36" src="https://github.com/user-attachments/assets/15dc86f9-b8d5-4a08-967a-b435d6a98916" /> |

### Error Handling

The ClaimServiceError enum defines custom error types used to handle API-related issues in the claims service. It supports meaningful error messages for different failure scenarios:

| Invalid URL | Invalid Server Response | Decoding Failure |
|--------------|-------------|----------------|
| Unsupportable URL. | Invalid server response. | Failed to read data from server. |
| <img width="256" alt="Screenshot 2025-04-15 at 11 52 23" src="https://github.com/user-attachments/assets/4b3c1ddd-e507-4d92-a47b-0d5d422cd78b" />  | <img width="256" alt="Screenshot 2025-04-15 at 11 51 43" src="https://github.com/user-attachments/assets/dc61ddba-2f64-403d-b777-230cbdee2ebd" />  | <img width="298" alt="Screenshot 2025-04-15 at 11 51 09" src="https://github.com/user-attachments/assets/6696ebed-1b86-4df5-b6c6-6292f149414f" /> |

Each case provides a localized error description to ensure clear communication of the issue to the user or developer. Unknown errors are wrapped in a .custom case for flexibility.

### Unit Test Result

All unit tests for the ClaimsApp project have passed successfully. The test suite includes:

1. ClaimListViewModelTests:

   - testFilteringSearchText: Validates claim filtering logic based on search text.
     
   - testFetchErrorHandling: Ensures proper handling of data fetch errors.
     
3. ClaimServiceTests:
   
   - testFetchClaimsSuccess: Confirms successful data fetching from the claims service.
     
   - testFetchClaimsFailure: Tests system behavior on failed data fetch.
     
   - testLiveClaimAPI(): Verifies the integration with the live claim API.

<img width="272" alt="Screenshot 2025-04-15 at 14 31 10" src="https://github.com/user-attachments/assets/18433db1-7a1c-451b-8ebb-92a23d583304" />


## Setup Instructions

1. Clone the repository

   ```bash
   git clone https://github.com/dasuqiibrohim/claims-app.git
   
2. Open the project in Xcode
   > open ClaimsApp.xcodeproj
   
3. Run the app on any iOS Simulator (iOS 15.0 or later)


## Features

- List of claims with title, description, and optional IDs
- Search and filter claims by title or description
- Claim detail screen with full information
- Loading indicator and error alert
- Offline-safe data model parsing
- Unit tests for core logic


