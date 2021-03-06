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

//MARK: - FooView
	open static let FooView = FooViewAppearanceProxy()
	open class FooViewAppearanceProxy {
		public init() {}

		//MARK: aPoint 
		public var _aPoint: CGPoint?
		open func aPointProperty() -> CGPoint {
			if let override = _aPoint { return override }
			return CGPoint(x: 10.0, y: 10.0)
		}
		public var aPoint: CGPoint {
			get { return self.aPointProperty() }
			set { _aPoint = newValue }
		}

		//MARK: compound_property 
		public var _compound_property: CGFloat?
		open func compound_propertyProperty() -> CGFloat {
			if let override = _compound_property { return override }
			return CGFloat(10.0)
		}
		public var compound_property: CGFloat {
			get { return self.compound_propertyProperty() }
			set { _compound_property = newValue }
		}

		//MARK: opaque 
		public var _opaque: Bool?
		open func opaqueProperty() -> Bool {
			if let override = _opaque { return override }
			return true
		}
		public var opaque: Bool {
			get { return self.opaqueProperty() }
			set { _opaque = newValue }
		}

		//MARK: textAlignment 
		public var _textAlignment: NSTextAlignment?
		open func textAlignmentProperty() -> NSTextAlignment {
			if let override = _textAlignment { return override }
			return NSTextAlignment.center
		}
		public var textAlignment: NSTextAlignment {
			get { return self.textAlignmentProperty() }
			set { _textAlignment = newValue }
		}

		//MARK: aRect 
		public var _aRect: CGRect?
		open func aRectProperty() -> CGRect {
			if let override = _aRect { return override }
			return CGRect(x: 10.0, y: 10.0, width: 100.0, height: 100.0)
		}
		public var aRect: CGRect {
			get { return self.aRectProperty() }
			set { _aRect = newValue }
		}

		//MARK: font 
		public var _font: NSFont?
		open func fontProperty() -> NSFont {
			if let override = _font { return override }
			return Typography.smallProperty()
		}
		public var font: NSFont {
			get { return self.fontProperty() }
			set { _font = newValue }
		}

		//MARK: aSize 
		public var _aSize: CGSize?
		open func aSizeProperty() -> CGSize {
			if let override = _aSize { return override }
			return CGSize(width: 100.0, height: 100.0)
		}
		public var aSize: CGSize {
			get { return self.aSizeProperty() }
			set { _aSize = newValue }
		}

		//MARK: image 
		public var _image: NSImage?
		open func imageProperty() -> NSImage {
			if let override = _image { return override }
			return NSImage(named: "myimage")!
		}
		public var image: NSImage {
			get { return self.imageProperty() }
			set { _image = newValue }
		}

		//MARK: margin 
		public var _margin: CGFloat?
		open func marginProperty() -> CGFloat {
			if let override = _margin { return override }
			return CGFloat(12.0)
		}
		public var margin: CGFloat {
			get { return self.marginProperty() }
			set { _margin = newValue }
		}
		public func apply(view: FooView) {
			view.aPoint = self.aPoint
			view.compound.property = self.compound_property
			view.opaque = self.opaque
			view.textAlignment = self.textAlignment
			view.aRect = self.aRect
			view.font = self.font
			view.aSize = self.aSize
			view.image = self.image
			view.margin = self.margin
		}

	}
//MARK: - Typography
	public static let Typography = TypographyAppearanceProxy()
	public class TypographyAppearanceProxy {

		//MARK: small 
		fileprivate var _small: NSFont?
		public func smallProperty() -> NSFont {
			if let override = _small { return override }
			return NSFont.systemFont(ofSize: 12.0)
		}
		public var small: NSFont {
			get { return self.smallProperty() }
			set { _small = newValue }
		}

		//MARK: medium 
		fileprivate var _medium: NSFont?
		public func mediumProperty() -> NSFont {
			if let override = _medium { return override }
			return NSFont.systemFont(ofSize: 18.0, weight: NSFontWeightSemibold)
		}
		public var medium: NSFont {
			get { return self.mediumProperty() }
			set { _medium = newValue }
		}
	}
//MARK: - Blue
	public static let Blue = BlueAppearanceProxy()
	public class BlueAppearanceProxy {

		//MARK: backgroundColor 
		fileprivate var _backgroundColor: NSColor?
		public func backgroundColorProperty() -> NSColor {
			if let override = _backgroundColor { return override }
			return Color.blueProperty()
		}
		public var backgroundColor: NSColor {
			get { return self.backgroundColorProperty() }
			set { _backgroundColor = newValue }
		}
		public func apply(view: NSView) {
			view.backgroundColor = self.backgroundColor
		}

	}
//MARK: - Color
	public static let Color = ColorAppearanceProxy()
	public class ColorAppearanceProxy {

		//MARK: red 
		fileprivate var _red: NSColor?
		public func redProperty() -> NSColor {
			if let override = _red { return override }
			if (NSApplication.shared().mainWindow?.frame.size ?? CGSize.zero).width < 300.0 { 
			return NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
			}
			if (NSApplication.shared().mainWindow?.frame.size ?? CGSize.zero).width > 300.0 { 
			return NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
			}
			
			return NSColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
		}
		public var red: NSColor {
			get { return self.redProperty() }
			set { _red = newValue }
		}

		//MARK: blue 
		fileprivate var _blue: NSColor?
		public func blueProperty() -> NSColor {
			if let override = _blue { return override }
			return NSColor(red: 0.666667, green: 0.733333, blue: 0.8, alpha: 0.12549)
		}
		public var blue: NSColor {
			get { return self.blueProperty() }
			set { _blue = newValue }
		}
	}
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

extension DefaultButton: AppearaceProxyComponent {

	public typealias ApperanceProxyType = S.DefaultButtonAppearanceProxy
	public var appearanceProxy: ApperanceProxyType {
		get {
			guard let proxy = objc_getAssociatedObject(self, &__ApperanceProxyHandle) as? ApperanceProxyType else { return S.DefaultButton }
			return proxy
		}
		set {
			objc_setAssociatedObject(self, &__ApperanceProxyHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			didChangeAppearanceProxy()
		}
	}
}
