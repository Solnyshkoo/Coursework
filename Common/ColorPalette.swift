import Foundation
import SwiftUI

class ColorPalette {
    @Environment(\.colorScheme) var colorScheme
    // используется
    static var mainBackground: Color {
        Color(
            UIColor { colorScheme in
                switch colorScheme.userInterfaceStyle {
                case .dark:
                    return UIColor(.black)
                default:
                    return UIColor(.white)
                }
            }
        )
    }

    // используется
    static var secondBackground: Color {
        Color(
            UIColor { colorScheme in
                switch colorScheme.userInterfaceStyle {
                case .dark:
                    return UIColor(red: 34 / 255, green: 34 / 255, blue: 34 / 255, alpha: 1)
                default:
                    return UIColor(Color(.systemGray5).opacity(0.75))
                }
            }
        )

        
    }

    static var lightGray: Color {
        Color(red: 140 / 255, green: 140 / 255, blue: 140 / 255)
    }

    static var lightGray2: Color {
        Color(red: 69 / 255, green: 69 / 255, blue: 72 / 255)
    }

    // используется
    static var acсentColor: Color {
        Color(red: 58 / 255, green: 81 / 255, blue: 151 / 255)
    }

    // используется
    static var navigationBarItem: Color {
        Color.secondary
    }

    // используется
    static var activeText: Color {
        Color.blue
    }

    static var warningColor: Color {
        Color.red
    }
    
    static var buttonText: Color {
        Color.white
    }

    static var text: Color {
        Color(
            UIColor { colorScheme in
                switch colorScheme.userInterfaceStyle {
                case .dark:
                    return UIColor(.white)
                default:
                    return UIColor(.black)
                }
            }
        )
      //  Color.white
    }

    // используется
    static var disableButtom: Color {
        Color.gray
    }

    // используется
    static var subtitle: Color {
        Color.white
    }
}
