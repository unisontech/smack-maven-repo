smack-maven-repo
================

This project is build environment for smack artifacts maven repository.


Building
================
After clonning the project first thing you need to do is:
```
make init
```
to initialize submodules with smack and asmack projects.

After it you may use one of:
```
make install
make REPO="my-repo" REPO_ID="my-repo-id" deploy
```
First one is for creating in-project repository with artifacts, while second allows you to deploy them to the custom location.
