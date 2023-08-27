import UIKit

public extension UIFont {
    
    convenience init?(font: Font, size: CGFloat) {
        let fontIdentifier: String = font.rawValue
        self.init(name: fontIdentifier, size: size)
    }
    
    convenience init?(font: CustomFont, size: CGFloat) {
        let fontIdentifier: String = font.rawValue
        self.init(name: fontIdentifier, size: size)
    }
}
