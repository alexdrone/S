/// Autogenerated file

// swiftlint:disable type_body_length
// swiftlint:disable type_name

import Cocoa

fileprivate var __ApperanceProxyHandle: UInt8 = 0

/// Your view should conform to 'AppearaceProxyComponent'.
public protocol AppearaceProxyComponent: class {
	associatedtype ApperanceProxyType
	var appearanceProxy: ApperanceProxyType { get }
	func didChangeAppearanceProxy()
}

/// Entry point for the app stylesheet
public class S {

//MARK: - DefaultButton
	public static let DefaultButton = DefaultButtonAppearanceProxy()
	public class DefaultButtonAppearanceProxy: FooViewAppearanceProxy {

		//MARK: color 
		fileprivate var _color: NSColor?
		public func colorProperty() -> NSColor {
			if let override = _color { return override }
			return Color.blueProperty()
		}
		public var color: NSColor {
			get { return self.colorProperty() }
			set { _color = newValue }
		}

		//MARK: opaque 
		override public func opaqueProperty() -> Bool {
			if let override = _opaque { return override }
			return false
		}

		//MARK: margin 
		override public func marginProperty() -> CGFloat {
			if let override = _margin { return override }
			return CGFloat(12.0)
		}
	}
//MARK: - Typography
	public static let Typography = TypographyAppearanceProxy()
	public class TypographyAppearanceProxy {

		//MARK: small 
		fileprivate var _small: NSFont?
		public func smallProperty() -> NSFont {
			if let override = _small { return override }
			return NSFont(name: ""Helvetica"", size: 12.0)!
		}
		public var small: NSFont {
			get { return self.smallProperty() }
			set { _small = newValue }
		}

		//MARK: medium 
		fileprivate var _medium: NSFont?
		public func mediumProperty() -> NSFont {
			if let override = _medium { return override }
			return NSFont(name: ""Helvetica"", size: 18.0)!
		}
		public var medium: NSFont {
			get { return self.mediumProperty() }
			set { _medium = newValue }
		}
	}
//MARK: - Color
	public static let Color = ColorAppearanceProxy()
	public class ColorAppearanceProxy {

		//MARK: red 
		fileprivate var _red: NSColor?
		public func redProperty() -> NSColor {
			if let override = _red { return override }
			if NSApplication.shared().mainWindow?.frame.size.width < 300.0 { 
			return NSColor(red: 0.666667, green: 0.0, blue: 0.0, alpha: 1.0)
			}
			
			return NSColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
		}
		public var red: NSColor {
			get { return self.redProperty() }
			set { _red = newValue }
		}

		//MARK: blue 
		fileprivate var _blue: NSColor?
		public func blueProperty() -> NSColor {
			if let override = _blue { return override }
			return NSColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
		}
		public var blue: NSColor {
			get { return self.blueProperty() }
			set { _blue = newValue }
		}
	}
//MARK: - FooView
	public static let FooView = FooViewAppearanceProxy()
	public class FooViewAppearanceProxy {

		//MARK: backgroundColor 
		fileprivate var _backgroundColor: NSColor?
		public func backgroundColorProperty() -> NSColor {
			if let override = _backgroundColor { return override }
			return Color.redProperty()
		}
		public var backgroundColor: NSColor {
			get { return self.backgroundColorProperty() }
			set { _backgroundColor = newValue }
		}

		//MARK: font 
		fileprivate var _font: NSFont?
		public func fontProperty() -> NSFont {
			if let override = _font { return override }
			return Typography.smallProperty()
		}
		public var font: NSFont {
			get { return self.fontProperty() }
			set { _font = newValue }
		}

		//MARK: opaque 
		fileprivate var _opaque: Bool?
		public func opaqueProperty() -> Bool {
			if let override = _opaque { return override }
			return true
		}
		public var opaque: Bool {
			get { return self.opaqueProperty() }
			set { _opaque = newValue }
		}

		//MARK: margin 
		fileprivate var _margin: CGFloat?
		public func marginProperty() -> CGFloat {
			if let override = _margin { return override }
			return CGFloat(12.0)
		}
		public var margin: CGFloat {
			get { return self.marginProperty() }
			set { _margin = newValue }
		}
	}

}
extension FooView: AppearaceProxyComponent {

	public typealias ApperanceProxyType = S.FooViewAppearanceProxy
	public var appearanceProxy: ApperanceProxyType {
		get {
			guard let proxy = objc_getAssociatedObject(self, &__ApperanceProxyHandle) as? ApperanceProxyType else { return S.FooView }
			return proxy
		}
		set {
			objc_setAssociatedObject(self, &__ApperanceProxyHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			didChangeAppearanceProxy()
		}
	}
}
