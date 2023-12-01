//
//  Extensions.swift
//  Travio
//
//  Created by Oğuz on 14.10.2023.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

// MARK: - Format Type
enum FormatType: String {
    case longFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case longWithoutZone = "yyyy-MM-dd'T'HH:mm:ss"
    case withoutYear = "dd MMMM"
    case localeStandard = "dd.MM.yyyy"
    case standard = "yyyy-MM-dd"
    case dateAndTime = "dd.MM.yyyy'T'HH:mm"
    case time = "HH:mm"
    case stringFormat = "dd MMMM yyyy"
    case customFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
}

// MARK: - Font Type
enum FontType:String {
    case bold = "Bold"
    case medium = "Medium"
}

// MARK: - UIStack View
extension UIStackView {
    func addArrangedSubviews(_ view: UIView...) {
        view.forEach({ v in
            self.addArrangedSubview(v)
        })
    }
}

// MARK: - UIView
extension UIView {
    /// Add multiple subview to a view.
    /// - Parameter view: It is a subviews array which add to parent view
    func addSubviews(_ view: UIView...) {
        view.forEach({ v in
            self.addSubview(v)
        })
    }
    
    @available(iOS 13, *)
    private struct Preview: UIViewRepresentable {
        typealias UIViewType = UIView
        let view: UIView
        func makeUIView(context: Context) -> UIView {
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {
            //
        }
    }
    
    @available(iOS 13, *)
    func showPreview() -> some View {
        // inject self (the current UIView) for the preview
        Preview(view: self)
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.duration = 0.4
        animation.values = [-10.0, 5.0, -5.0, 0.0]
        
        layer.add(animation, forKey: "shake")
    }
    
    func addView() ->UIView{
        let view = UIView()
        self.addSubview(view)
        return view
    }
    
}

// MARK: - UIViewController
extension UIViewController {
    
    @available(iOS 13, *)
    private struct Preview: UIViewControllerRepresentable {
        
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            
        }
    }
    
    @available(iOS 13, *)
    func showPreview() -> some View {
        Preview(viewController: self)
    }
    
    func addChild(this child: UIViewController, contentView:UIView ) {
        addChild(child)
        contentView.addSubview(child.view)
        
        UIView.transition(with: contentView, duration: 0.5, options: .curveLinear, animations: {
            child.didMove(toParent: self)
        }, completion: nil)
        
        
    }
    
    func removeChildFromParent() {
        
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}



// MARK: - User Defaults
extension UserDefaults {
    
    enum Keys: String, CaseIterable {
        case tokenObject
        case currentUser
    }
    
    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
    
    func setEncodedObject<T:Codable>(object:T,key:Keys) {
        
        if let encoded = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(encoded, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    func getEncodedObject<T:Codable>(key:Keys, object:T.Type) -> T?{
        if let data = UserDefaults.standard.data(forKey: key.rawValue), let dataObject = try? JSONDecoder().decode(object, from: data) {
            return dataObject
        }
        return nil
    }
}

// MARK: - UIDatePicker
extension UIDatePicker {
    
    public var roundedDate: Date {
        let referenceTimeInterval = self.date.timeIntervalSinceReferenceDate
        let remainingSeconds = referenceTimeInterval.truncatingRemainder(dividingBy: TimeInterval(minuteInterval*60))
        let timeRoundedToInterval = referenceTimeInterval - remainingSeconds
        return Date(timeIntervalSinceReferenceDate: timeRoundedToInterval)
    }
}

// MARK: - Array
extension Array {
    
    public subscript(safe index: Int) -> Element? {
        guard startIndex <= index && index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}

extension UIImageView{
    func animateImage(_ image: UIImage?, animated: Bool = true) {
        let duration = animated ? 0.3 : 0.0
        UIView.transition(with: self, duration: duration, options: .curveEaseIn, animations: {
            self.image = image
        }, completion: nil)
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                return windowScene.windows.first { $0.isKeyWindow }
            }
        } else {
            return UIApplication.shared.keyWindow
        }
        return nil
    }
}


extension UIView {
    func dropShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowRadius = 5
    }
}

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

extension DateFormatter {
    static func formattedDate(from originalDateString: String? = nil, originalDate: Date? = nil, originalFormat: FormatType, targetFormat: FormatType, localeIdentifier: String? = "tr-TR") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = originalFormat.rawValue
        
        if let localeIdentifier = localeIdentifier {
            dateFormatter.locale = Locale(identifier: localeIdentifier)
        }
        
        if let originalDateString = originalDateString {
            if let date = dateFormatter.date(from: originalDateString) {
                dateFormatter.dateFormat = targetFormat.rawValue
                return dateFormatter.string(from: date)
            } else {
                print("Invalid date format")
                return nil
            }
        } else if let originalDate = originalDate {
            dateFormatter.dateFormat = targetFormat.rawValue
            return dateFormatter.string(from: originalDate)
        } else {
            print("Invalid input")
            return nil
        }
    }
    
    static func formattedString(from date: Date = Date(), timeZone: TimeZone = .current, formatOptions: ISO8601DateFormatter.Options = [.withInternetDateTime, .withFractionalSeconds]) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.timeZone = timeZone
        isoFormatter.formatOptions = formatOptions
        return isoFormatter.string(from: date)
    }
}



extension Data {
    init?(base64URLEncoded: String) {
        var base64 = base64URLEncoded
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")

        let paddedLength = (4 - base64.count % 4) % 4
        base64 += String(repeating: "=", count: paddedLength)

        guard let data = Data(base64Encoded: base64) else { return nil }
        self = data
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}










