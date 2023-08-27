import Foundation

// MARK: - Int
public extension Int {
    
    var second: Int {
        return Int(Double(self) / 1_000.0)
    }
    
    var timeInterval: String {
        let minutes = Int(self / 60)
        let seconds = Int(Double(self).truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d",
                      arguments: [minutes, seconds])
    }
    
    var minutesSeconds: String {
        let minutes = Int(self / 60_000)
        let seconds = Int(self % 60_000) / 1_000
        return String(format: "%02d:%02d", arguments: [minutes, seconds])
    }
    
    var secondsdurationInTime: Time {
        return Time(hours: self / 3_600, minutes: (self % 3_600) / 60, seconds: (self % 3_600) % 60, miliSeconds: self * 1_000)
    }
    
    var dateFromMilliseconds: Date {
        return Date(timeIntervalSince1970: TimeInterval(self) / 1_000.0)
    }
}
