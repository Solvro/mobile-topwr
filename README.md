# topwr-mobile

- ToPWR Backend Registration Link: https://to-pwr.solvro.pl/admin/login
- ToPWR Figma: https://www.figma.com/file/y51BgMlrSDipXPceEHHZt4/ToPWR?type=design&node-id=964-1703&mode=design&t=7ibW653dM6z0TZ1J-0

# topwr

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Working with git
### Building new feature
1. git checkout main -> checkout main branch
2. git pull origin main -> pull current changes from main branch
3. git fetch -> be up to date with remote branches
4. git checkout -b MOBILE-x_my_feature_branch -> x - stands for issue number; it is going to checkout and create new branch name MOBILE-x_my_feature_branch
(... working on the feature, we are still on our branch named MOBILE-x_my_feature_branch)
5. git add . -> add all changes we have made
6. git commit -m "My changes description" -> commit made changes with proper description
7. git push origin MOBILE-x_my_feature_branch -> pushing our changes to remote branch
8. On Github we are going to make Pull Request (PR) from our remote branch
### Remarks
* Do not push directly to main branch!!! This is bad practice!
* local branch - is our branch on our computer not on the server if we do some chagnes and do checkout to diffrent branch without saving them(commiting) we might loose them, commit before checkout to different branch!
* remote branch - this is branch with our code in github's servers
* After code review which was successful, we can merge from our feature branch to main branch. After merging we should clean after ourself.
1. git branch -d  MOBILE-x_my_feature_branch -> deletes our local branch
2. git push origin --delete  MOBILE-x_my_feature_branch -> deletes our remote branch
 

