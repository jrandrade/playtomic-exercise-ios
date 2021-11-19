#  Playtomic assignment - Architecture


## Assignment

Given the current project's code, transform the code to move from a plain Model View Controller architecture to some other of your choice

**Existing Product Features to be kept**:

- Load current user
- Load user friends
- Reload data
- Name base search
- Basic loading/error handling


**Expected changes to be added**:

- Architecture refactor
- Unit testing
- Navigate to UserDetailViewController when selecting user

**Additional information**:

- All code must be written using **Swift**
- You can create as many files or modify any of the included ones as needed
- Data must come from the `UserService` included in the project. Data is fetched asynchronously and must be fetched in order (first the current user, then the user friends) as shown in the example, but minor API changes are allowed (for example for changing the way we deal with async calls or for allowing test mocks). The included service returns errors every 3 calls, keep this behavior if you modify the code.
- Usage of third party libraries is allowed and/or expected, but try to keep dependencies in a bare minimum. Usage of cocoapods, carthage, SPM or any other dependency manager allowed

## Timebox

Timebox the development time to **exactly 2hrs**. Do not worry if the exercise is not complete within the 2hr timebox (we are aware that 2hrs is not enough). At the end of the 2hrs make sure the project runs, and send it as it is.


## Evaluation points

- Proper implementation of the chosen architecture
- Proper separation of concerns for each part
- Good handling of asynchronoys calls and errors
- Good general coding principles
- Inclusion of some example unit tests with sense

*IMPORTANT NOTE: With this assignment we will not evaluate anything related to UI appearance other than architectural decissions. Do not spend time improving the layout or design of the screens*

