# Xcode File Templates
Xcode File Templates for automatic files creation

# Table of Contains
- [Included Templates:](#included-templates-)
- [Xcode Templates](#xcode-templates)
  * [Xcode Templates Requirements:](#xcode-templates-requirements-)
  * [Xcode Templates Contains:](#xcode-templates-contains-)
    + [Base Project Setup:](#base-project-setup-)
    + [Base MVVM Templates:](#base-mvvm-templates-)
    + [MVVM with Repositories:](#mvvm-with-repositories-)
    + [Repository:](#repository-)
    + [UseCase:](#usecase-)
    + [Viper with Rx usage:](#viper-with-rx-usage-)
    + [Unit Tests Templates:](#unit-tests-templates-)
  * [Xcode Teamplated Setup Guide:](#xcode-teamplated-setup-guide-)
    + [Using script | With adding templates in one folder](#using-script---with-adding-templates-in-one-folder)
    + [Manual | With Saving Folder structure](#manual---with-saving-folder-structure)
  * [Xcode Templates ssage guide:](#xcode-templates-ssage-guide-)
- [Project setup Templates](#project-setup-templates)
  * [General](#general)
  * [Automatically localization tools](#automatically-localization-tools)
    + [genstring.swift](#genstringswift)
    + [export-text.py](#export-textpy)
    + [import-text.py](#import-textpy)
  * [SwiftGen](#swiftgen)
  * [SonarQube](#sonarqube)
  * [Swiftlint](#swiftlint)
  * [Periphery](#periphery)

## Included Templates:
- Xcode files Templates
  * Base Project Templates
  * Base MVVM Templates
  * MVVM with Repository & UseCases usage
  * MVVM Repository & UseCases
  * VIPER pattern with Rx and Routers usage
  * Unit Tests for ViewModel based in XCTestsCase
  * Unit Tests for Presenter based on XCTestCase
  * Unit Tests for Presenter based on Nimble and Quick
  * Unit Tests for ViewModel based on Nimble and Quick
- Project setup Templates
  * Templated fastlane 
  * Templated SonarQube
  * Templated SwiftGen
  * Templates for Project
    + gitignore
    + periphery configs
    + swiftlint configs
    + strings generation and export scripts

## Xcode Templates

### Xcode Templates Requirements:
- [Swinject](https://github.com/Swinject/Swinject) / Dependency injection framework for Swift with iOS/macOS/Linux
- [RxSwift](https://github.com/ReactiveX/RxSwift) / Reactive Programming in Swift
- [Realm](https://github.com/realm/realm-cocoa) / Realm is a mobile database: a replacement for Core Data & SQLite
- [Moya](https://github.com/Moya/Moya) / Network abstraction layer written in Swift
- [Nimble](https://github.com/Quick/Nimble) / Use Nimble to express the expected outcomes of Swift or Objective-C expressions
- [Quick](https://github.com/Quick/Quick) / Quick is a behavior-driven development framework for Swift and Objective-C

### Xcode Templates Contains:

#### Base Project Setup:
- Common and useful Extension
- Base Network Layer
- Realm Storage Manager
- Realm-Combine Storage Manager
- Routing system (including animators & transitions)
- StoryboardInitializable & CellInizializable

---------------------

#### Base MVVM Templates:
- ViewModel.swift
- ViewController.swift
- View.storyboard
- Builder.swift

---------------------

#### MVVM with Repositories:
- ViewModel.swift
- ViewController.swift
- View.storyboard
- Builder.swift
- Router.swift
- Route.swift
- ViewModelUseCases.swift

---------------------

#### Repository:
- Repository.swift

---------------------

#### UseCase:
- UseCase.swift

---------------------

#### Viper with Rx usage:
- Presenter.swift
- ViewController.swift
- View.storyboard
- Builder.swift
- Router.swift
- Route.swift
- Iteractor.swift

---------------------

#### Unit Tests Templates: 
- PresenterTests.swift based on XCTests
- ViewModelTests.swift based on XCTests
- PresetnerTests.swift based on Quick&Spec
- ViewModelTests.swift based on Quick&Spec


### Xcode Teamplated Setup Guide:

#### Using script | With adding templates in one folder
Only need execute next commands in terminal:

```
cd ~/Downloads
git clone https://github.com/coreteka-service/iOS-Templates
cd Xcode-File-Templates
sh ./install.sh
cd ..
rm -rf Xcode-File-Templates
```

You should see one of such kind of output message:
``` 
✅ Templates installed to: ~/Library/Developer/Xcode/Templates/Project Templates/ 
```

#### Manual | With Saving Folder structure
1. Open folder `Templates/File Template` from downloaded or cloned repository. 
2. Go to direction `~/Library/Developer/Xcode/` and set folders with templates
3. If direction `~/Library/Developer/Xcode/` already has folder Templates and File Templates, just use the following folders and paste it into File Templates folder.


### Xcode Templates ssage guide:
```
- CMD+N //  and select needed Template 
- New -> File -> //  and select needed
```

## Project setup Templates

### General
For starting new project you mandatory need to create all files from CommonServices folder.

### Automatically localization tools
Repository containt folder lang_exports. This Folder containt 3 scripts for automatic work with localizaiton files.

#### genstring.swift
Script will get all strings with extensions .localize from project and add them into localization files (.strings files for all avaialble localizations). If keys is exist in .strings file, should not add it.
**For run:**
```
cd <project_root_folder>
cd lang_export
swift genstring.swift
```

#### export-text.py
Script will parse .strings files and generate .xlsx (lang.xlsx file will be output) file with keys and their values for all avaialable language
**For run:**
```
cd <project_root_folder>
cd lang_export
python3 export-text.py // or python export-text.py
```

#### import-text.py
Script will parse input lang.xlsx file and update keys and their values in .string files for all avaialble langugages 
> lang.xlsx must be in one folder with import-text.py file

**For run:**
```
cd <project_root_folder>
cd lang_export
python3 import-text.py // or python import-text.py
```
### SwiftGen
SwiftGen is a tool to automatically generate Swift code for resources of your projects (like images, localised strings, etc), to make them type-safe to use.

Setup guide: https://github.com/SwiftGen/SwiftGen#installation 

### SonarQube
Setup your Sonar Qube project in your CI and inject config file named `sonar-project.properties` to the root folder of your project. Edit it according to your project needs.

### Swiftlint
Setup swiftlint in your project by guide: https://github.com/realm/SwiftLint#installation. Finish configuration of your swiftlint settings by injecting `.swiftlint.yml` file into root folder of your project. Edit it according to your project needs.

### Periphery
A tool to identify unused code in Swift projects. Setup periphery in your project by guide: https://github.com/peripheryapp/periphery#installation. Finish configuration of periphery by inject file named `.periphery.yml` to the root folder of your project. Edit it according to your project needs.