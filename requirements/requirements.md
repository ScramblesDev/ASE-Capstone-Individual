
# Requirements

### Landing Page
- **Description:** The landing page serves as the initial interface for users when they first visit the app. It features a clean and intuitive design that presents two primary options: "Sign In" and "Register." This page is designed to guide new and returning users to the appropriate sections of the app quickly.
- **Status**: Completed

### Sign In Authentication
- **Description**: This feature allows returning users to securely log into their accounts by entering their registered email and password. The authentication process is handled through Firebase, ensuring secure handling of credentials and session management. Error handling is implemented to provide feedback on incorrect inputs or failed login attempts.
- **Status**: Completed

### Register Authentication
- **Description**: New users can create an account using this feature by providing their full name, a valid email address, and a password. The registration process includes checks for input validity, such as email format verification and password strength assessment. Upon successful account creation, users are redirected to the login screen to access their new account.
- **Status**: Completed

### Homepage for Insights
- **Description**: After logging in, users are directed to the homepage, which offers a comprehensive overview of their financial health. The page displays current funds, budget insights, and recent transaction history. Insights provide personalized financial advice based on the user's spending patterns and savings goals.
- **Status**: Completed

### Chart for Budget Viewing
- **Description**: The homepage features an interactive bar chart that visualizes each budget item against the user's financial goals. The chart updates dynamically as users add or modify budget items or as their overall funds change. It serves as a visual tool to help users quickly assess their progress toward their financial goals.
- **Status**: Completed

### Overall Amount
- **Description**: Prominently displayed at the top of the homepage, this feature shows the user's total available funds. This amount is updated in real-time as users record new transactions or adjust their budget, ensuring that users always have access to up-to-date financial information.
- **Status**: Completed

### Calculation of Budget
- **Description**: This backend function calculates the percentage of each budget goal achieved based on the user's overall funds. These calculations are used to populate the bar chart on the homepage and are crucial for generating accurate financial insights and progress tracking.
- **Status**: Completed

### Financial Recommendation Message
- **Description**: Based on the analysis of the user's spending habits and savings progress, personalized financial recommendations are generated. These messages might encourage users to save more, congratulate them on reaching a financial milestone, or suggest adjustments to their budgeting strategy. The goal is to provide actionable advice that helps users improve their financial well-being.
- **Status**: Completed

### Update Current Funds Button
- **Description:** This feature provides users with the ability to update their total available funds. Accessible from the homepage, the button triggers a dialog where users can enter a new amount. The update is immediately reflected in the user's account balance displayed on the homepage and used in calculating financial insights and budget progress.
- **Status:** Completed

### Add New Budget Item Button
- **Description:** This button allows users to add new budget goals. When clicked, it opens a dialog asking the user to input a budget item name and a goal amount. Once submitted, the new budget item is added to the Firestore database, displayed in the budget chart, and included in financial calculations. This feature helps users expand their financial management and tracking.
- **Status:** Completed