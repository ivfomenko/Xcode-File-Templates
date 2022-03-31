#!/usr/bin/env xcrun --sdk macosx swift

import Foundation

let relativeLocalizableFolders = "/<Project_name>/Localized"

let defaultStringsFileName = "Localized.strings"

let masterLanguage = "en"

struct Language {
    let name: String
    let path: String
    let data_lines: [String]?

    init(name: String, path: String) {
        self.name = name
        self.path = path
        let location = "\(path)/Localizable.strings"
        let string = try? String(contentsOfFile: location, encoding: .utf8)
        let lines = string?.components(separatedBy: CharacterSet.newlines)
        self.data_lines = lines
    }
}

class GenStrings {
    
    let path = FileManager.default.currentDirectoryPath + relativeLocalizableFolders
    
    var str = "Hello, playground"
    let fileManager = FileManager.default
    let acceptedFileExtensions = ["swift"]
    let excludedFolderNames = ["Carthage"]
    let excludedFileNames = ["genstrings.swift", "Localize.swift"]
    var regularExpresions = [String: NSRegularExpression]()

    let localizedRegex = "(?<=\")([^\"]*)(?=\".(localized|uplocalized|localizedFormat))|(?<=(Localized|NSLocalizedString)\\(\")([^\"]*?)(?=\")"

    enum GenstringsError: Error {
        case Error
    }
    
    // Detect list of supported languages automatically
    func listSupportedLanguages() -> [Language] {
        var sl = [Language]()
        let path = FileManager.default.currentDirectoryPath + relativeLocalizableFolders
        if !FileManager.default.fileExists(atPath: path) {
            print("Invalid configuration: \(path) does not exist.")
            exit(1)
        }
        let enumerator: FileManager.DirectoryEnumerator? = FileManager.default.enumerator(atPath: path)
        let extensionName = "lproj"
        print("Found these languages:")
        while let element = enumerator?.nextObject() as? String {
            // if element.hasSuffix(extensionName) {
                let name = element.replacingOccurrences(of: ".\(extensionName)", with: "")
                let lfile = Language(name: name, path: path + "/" + element)
                sl.append(lfile)
            // }
        }
        return sl
    }

    // Performs the genstrings functionality
    func perform(localizable: [String], lang: Language) {
        print(lang.name)

            if lang.name != masterLanguage {
                print("not master")
            } else {
                print("master")
            }

        var processedStrings = String()
        for string in localizable {
            if lang.name != masterLanguage {
                let processResult = getProcessedString(from: string, lang: lang)
                processedStrings.append(processResult.result)
            } else {
                let processResult = getMassterProcessedString(from: string, lang: lang)
                processedStrings.append(processResult.result)
            }
        }
        saveProcessedStringsToFile(processedStrings, lang: lang)
    }

    // Applies regex to a file at filePath.
    func localizableStringsInFile(filePath: URL) -> Set<String> {
        do {
            let fileContentsData = try Data(contentsOf: filePath)
            guard let fileContentsString = NSString(data: fileContentsData, encoding: String.Encoding.utf8.rawValue) else {
                return Set<String>()
            }
            let localizedStringsArray = try regexMatches(pattern: localizedRegex, string: fileContentsString as String).map({ fileContentsString.substring(with: $0.range) })
            return Set(localizedStringsArray)
        } catch {}
        return Set<String>()
    }

    // MARK: Regex

    func regexWithPattern(pattern: String) throws -> NSRegularExpression {
        var safeRegex = regularExpresions
        if let regex = safeRegex[pattern] {
            return regex
        } else {
            do {
                let currentPattern: NSRegularExpression
                currentPattern = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
                safeRegex.updateValue(currentPattern, forKey: pattern)
                regularExpresions = safeRegex
                return currentPattern
            } catch {
                throw GenstringsError.Error
            }
        }
    }

    func regexMatches(pattern: String, string: String) throws -> [NSTextCheckingResult] {
        do {
            let internalString = string
            let currentPattern = try regexWithPattern(pattern: pattern)
            // NSRegularExpression accepts Swift strings but works with NSString under the hood. Safer to bridge to NSString for taking range.
            let nsString = internalString as NSString
            let stringRange = NSMakeRange(0, nsString.length)
            let matches = currentPattern.matches(in: internalString, options: [], range: stringRange)
            return matches
        } catch {
            throw GenstringsError.Error
        }
    }

    // MARK: File manager

    func fetchFilesInFolder(rootPath: URL) -> [URL] {
        var files = [URL]()
        do {
            let directoryContents = try fileManager.contentsOfDirectory(at: rootPath as URL, includingPropertiesForKeys: [], options: .skipsHiddenFiles)
            for urlPath in directoryContents {
                let stringPath = urlPath.path
                let lastPathComponent = urlPath.lastPathComponent
                let pathExtension = urlPath.pathExtension
                var isDir: ObjCBool = false
                if fileManager.fileExists(atPath: stringPath, isDirectory: &isDir) {
                    if isDir.boolValue {
                        if !excludedFolderNames.contains(lastPathComponent) {
                            let dirFiles = fetchFilesInFolder(rootPath: urlPath)
                            files.append(contentsOf: dirFiles)
                        }
                    } else {
                        if acceptedFileExtensions.contains(pathExtension) && !excludedFileNames.contains(lastPathComponent) {
                            files.append(urlPath)
                        }
                    }
                }
            }
        } catch {}
        return files
    }
    
    // MARK: - Key processing
    func getProcessedString(from key: String, lang: Language) -> (result: String, isPotentiallyIncorrect: Bool) {

        let pattern = "\".*\"(\\s?=\\s?)"
        
        let regex = try! NSRegularExpression(pattern: pattern, options: [])

        if let lines = lang.data_lines {

            for line in lines {
                let range = NSRange(location: 0, length: line.utf16.count)
                
                if let firstMatch = regex.firstMatch(in: line, options: [], range: range) {

                    let findedKey = (line as NSString).substring(with: firstMatch.range(at: 0))

                    if findedKey == ("\"\(key)\" = ") || findedKey == ("\"\(key)\"=") {
                        if lang.name != masterLanguage {
                            return ("\(line) \n\n", false)
                        }
                        return ("\(line) \n\n", false)
                    }
                }
            }
        }

        return ("\"\(key)\" = \"*NOT_TRANSLATED*\";\n\n", false)
    }
    
        // MARK: - Key processing
    func getMassterProcessedString(from key: String, lang: Language) -> (result: String, isPotentiallyIncorrect: Bool) {

        let pattern = "\".*\"(\\s?=\\s?)"
        
        let regex = try! NSRegularExpression(pattern: pattern, options: []) 

        if let lines = lang.data_lines {

            for line in lines {
                let range = NSRange(location: 0, length: line.utf16.count)
                
                if let firstMatch = regex.firstMatch(in: line, options: [], range: range) {

                    let findedKey = (line as NSString).substring(with: firstMatch.range(at: 0))

                    if findedKey == ("\"\(key)\" = ") || findedKey == ("\"\(key)\"=") {
                        if lang.name != masterLanguage {
                            return ("\(line)\n\n", false)
                        }
                        return ("\(line)\n\n", false)
                    }
                }
            }
        }

        return ("\"\(key)\" = \"\(key)\";\n\n", false)
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch {
            return []
        }
    }
    
    // MARK: - Save processed strings
    func saveProcessedStringsToFile(_ string: String, lang: Language) {
        let destination = "\(lang.path)/\(defaultStringsFileName)"
        print("Saving to destination: \(destination) ...")
        try? string.write(toFile: destination, atomically: false, encoding: String.Encoding.utf8)
    }

    func getAllLocalizationString(path: String? = nil) -> [String] {
        let directoryPath = path ?? fileManager.currentDirectoryPath
        let rootPath = URL(fileURLWithPath: directoryPath)
        let allFiles = fetchFilesInFolder(rootPath: rootPath)

        var localizableStrings = Set<String>()
        for filePath in allFiles {
            let stringsInFile = localizableStringsInFile(filePath: filePath)
            localizableStrings = localizableStrings.union(stringsInFile)
        }

        return localizableStrings.sorted(by: { $0 < $1 })
    }
}

let genStrings = GenStrings()

let localization = genStrings.getAllLocalizationString()

for lang in genStrings.listSupportedLanguages() {
    genStrings.perform(localizable: localization, lang: lang)
}
