# Xcode File Templates
Xcode File Templates for automatic files creation

- [Xcode File Templates](#xcode-file-templates)
  * [Templates Contains:](#templates-contains-)
    + [MVVM](#mvvm)
      - [SwiftUI](#swiftui)
      - [UIKit](#uikit)
    + [VIPER](#viper)
    + [Domain Layer](#domain-layer)
    + [Unit Tests](#unit-tests)
      - [Quick & Nimble](#quick---nimble)
      - [XCTest](#xctest)
    + [Tools:](#tools-)
    + [Extensions](#extensions)
  * [Install:](#install-)
    + [Default install](#default-install)
    + [Advanced install](#advanced-install)
    + [Manual | With Saving Folder structure](#manual---with-saving-folder-structure)
  * [Usage:](#usage-)
  * [Xcode Templates Requirements:](#xcode-templates-requirements-)
  * [Project setup Templates](#project-setup-templates)
    + [General](#general)
    + [Automatically localization tools](#automatically-localization-tools)
      - [genstring.swift](#genstringswift)
      - [export-text.py](#export-textpy)
      - [import-text.py](#import-textpy)
    + [SwiftGen](#swiftgen)
    + [SonarQube](#sonarqube)
    + [Swiftlint](#swiftlint)
    + [Periphery](#periphery)

## Templates Contains:

### MVVM

#### SwiftUI
- [View Model + View](/Templates/File%20Template/SwiftUI%20MVVM/MVVM.xctemplate/)

#### UIKit
- [MVVM + Routing](/Templates/File%20Template/UIKit%20MVVM/MVVM+Routing.xctemplate/)
- [MVVM + Storyboard](/Templates/File%20Template/UIKit%20MVVM/MVVM+Storyboard.xctemplate/)

### VIPER
- [VIPER + Rx](/Templates/File%20Template/VIPER/VIPER+Rx.xctemplate/)

### Domain Layer 

- [Repository](/Templates/File%20Template/Domain%20Layer/Repository.xctemplate/)
- [Use Case](/Templates/File%20Template/Domain%20Layer/UseCase.xctemplate/)
- [Network+Moya](/Templates/File%20Template/Domain%20Layer/Network+Moya.xctemplate/)
- [Storage+CombineRealm](/Templates/File%20Template/Domain%20Layer/Storage+CombineRealm.xctemplate/)
- [Storage+RxRealm](/Templates/File%20Template/Domain%20Layer/Storage+RxRealm.xctemplate/)

### Unit Tests

#### Quick & Nimble
- [View Model](/Templates/File%20Template/Tests/QuickSpecVMTests.xctemplate/)
- [Presenter](/Templates/File%20Template/Tests/QuickSpecPresenterTests.xctemplate/)
- [Custom](/Templates/File%20Template/Tests/QuickSpecTests.xctemplate/)

#### XCTest
- [View Model](/Templates/File%20Template/Tests/XCTestVMTests.xctemplate/)
- [Presenter](/Templates/File%20Template/Tests/XCTestPresenterTests.xctemplate/)
- [Custom](/Templates/File%20Template/Tests/XCTestTests.xctemplate/)

### Tools: 
- [`.json`](/Templates/File%20Template/Tools/JSON.xctemplate/)
- [`.stencil`](/Templates/File%20Template/Tools/Stencil.xctemplate/)

### Extensions 
- [Foundation extensions](/Templates/File%20Template/Extensions/Extensions.xctemplate/)
- [Fonts provider](/Templates/File%20Template/Extensions/Fonts.xctemplate/)
- [Realm+Extensions](/Templates/File%20Template/Extensions/Realm+Extensions.xctemplate/)
- [Routing](/Templates/File%20Template/Extensions/Routing.xctemplate/)
- [Rx extensions](/Templates/File%20Template/Extensions/Rx+Extensions.xctemplate/)
- [UIKit extensions](/Templates/File%20Template/Extensions/UIExtensions.xctemplate/)

## Install:

### Default install 

Only need execute next commands in terminal:

```bash
cd ~/Downloads
git clone https://github.com/coreteka-service/iOS-Templates
cd Xcode-File-Templates
sh ./install.sh -a
cd ..
rm -rf Xcode-File-Templates
```

You should see one of such kind of output message:
```bash
✅ All templates installed to : ~/Library/Developer/Xcode/Templates/Project Templates/ 
```

### Advanced install

If you interested in special templates, you can use options for script:

Install all templates:
```bash
sh ./install.sh -a
```

Install Extensions templates:
```bash
sh ./install.sh -e
```

Install Tests templates:
```bash
sh ./install.sh -t
```

Install Tools templates:
```bash
sh ./install.sh -o
```

Install MVVM templates:
```bash
sh ./install.sh -m
```

Install Viper templates:
```bash
sh ./install.sh -v
```

> **Note**: You can combine several options. But keep in mind, in case of `-a` usage, script will install all teamplates and exit from execution no matter to other options.

### Manual | With Saving Folder structure
1. Open folder `Templates/File Template` from downloaded or cloned repository. 
2. Go to direction `~/Library/Developer/Xcode/` and set folders with templates
3. If direction `~/Library/Developer/Xcode/` already has folder Templates and File Templates, just use the following folders and paste it into File Templates folder.

## Usage:
```
- CMD+N //  and select needed Template 
- New -> File -> //  and select needed
```

## Xcode Templates Requirements:

For comfortable use of all templates, it is recommended to install the following dependencies in your projects:

**Mandatory:**
- [Nimble](https://github.com/Quick/Nimble) / Use Nimble to express the expected outcomes of Swift or Objective-C expressions
- [Quick](https://github.com/Quick/Quick) / Quick is a behavior-driven development framework for Swift and Objective-C

**Optional**
- [Moya](https://github.com/Moya/Moya) / Network abstraction layer written in Swift
- [Swinject](https://github.com/Swinject/Swinject) / Dependency injection framework for Swift with iOS/macOS/Linux
- [RxSwift](https://github.com/ReactiveX/RxSwift) / Reactive Programming in Swift
- [Realm](https://github.com/realm/realm-cocoa) / Realm is a mobile database: a replacement for Core Data & SQLite


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