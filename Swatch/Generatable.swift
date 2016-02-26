//
//  RhsValue.swift
//  Swatch
//
//  Created by Alex Usbergo on 19/02/16.
//  Copyright © 2016 Alex Usbergo. All rights reserved.
//

import Foundation

//MARK: Rhs

public var ObjcGeneration = false

internal enum RhsError: ErrorType {
    case MalformedRhsValue(error: String)
    case MalformedCondition(error: String)
    case Internal
}

internal enum RhsValue {
    
    ///A scalar float value
    case Scalar(float: Float)
    
    ///A boolean value
    case Boolean(bool: Bool)
    
    ///A font value
    case Font(font: Rhs.Font)
    
    ///A color value
    case Color(color: Rhs.Color)
    
    ///A redirection to another value
    case Redirect(redirection: RhsRedirectValue)
    
    ///A map between cocndition and
    case Hash(hash: [Condition: RhsValue])
    
    private var isHash: Bool {
        switch self {
        case .Hash: return true
        default: return false
        }
    }
    
    private var isRedirect: Bool {
        switch self {
        case .Redirect: return true
        default: return false
        }
    }
    
    private var redirection: String? {
        switch self {
        case .Redirect(let r): return r.redirection
        default: return nil
        }
    }
    
    ///Returns a enum with the given payload
    
    internal static func valueFrom(scalar: Float) -> RhsValue  {
        return .Scalar(float: Float(scalar))
    }

    internal static func valueFrom(boolean: Bool) -> RhsValue  {
        return .Boolean(bool: boolean)
    }
    
    internal static func valueFrom(hash: [Yaml: Yaml]) throws -> RhsValue  {
        var conditions = [Condition: RhsValue]()
        for (k, value) in hash {
            
            guard let key = k.string else { continue }
            
            do {

                switch value {
                case .Int(let integer): try conditions[Condition(rawString: key)] = RhsValue.valueFrom(Float(integer))
                case .Double(let double): try conditions[Condition(rawString: key)] = RhsValue.valueFrom(Float(double))
                case .String(let string): try conditions[Condition(rawString: key)] = RhsValue.valueFrom(string)
                case .Bool(let boolean): try conditions[Condition(rawString: key)] = RhsValue.valueFrom(boolean)
                default: throw RhsError.Internal
                }
                
            } catch {
                throw RhsError.MalformedCondition(error: "\(conditions) is not well formed")
            }
        }
        return .Hash(hash: conditions)
    }
    
    internal static func valueFrom(string: String) throws  -> RhsValue  {
        
        if let components = argumentsFromString("font", string: string) {
            assert(components.count == 2)
            return .Font(font: Rhs.Font(name: components[0], size:Float(parseNumber(components[1]))))
            
        } else if let components = argumentsFromString("color", string: string) {
            assert(components.count == 1)
            return .Color(color: Rhs.Color(rgba: "#\(components[0])"))
            
        } else if let components = argumentsFromString("redirect", string: string) {
            assert(components.count == 1)
            return .Redirect(redirection: RhsRedirectValue(redirection: components[0], type: "Any"))
        }
        
        throw RhsError.MalformedRhsValue(error: "Unable to parse rhs value")
    }
    
    ///The reuturn value for this expression
    
    internal func returnValue() -> String {

        switch self {
        case .Scalar(_): return "Float"
        case .Boolean(_): return "Bool"
        case .Font(_): return "UIFont"
        case .Color(_): return "UIColor"
        case .Redirect(let r): return r.type
        case .Hash(let hash): for (_, rhs) in hash { return rhs.returnValue() }
        }
        return "Any"
    }
}

internal class RhsRedirectValue {
    private var redirection: String
    private var type: String
    
    init(redirection: String, type: String) {
        self.redirection = redirection
        self.type = type
    }
}


//MARK: Generator

extension RhsValue: Generatable {

    internal func generate() -> String {
        
        switch self {
        case .Scalar(let float): return "\n\t\t\treturn Float(\(float))"
        case .Boolean(let boolean): return "\n\t\t\treturn \(boolean)"
        case .Font(let font): return "\n\t\t\treturn UIFont(name: \(font.fontName), size: \(font.fontSize))!"
        case .Color(let color): return "\n\t\t\treturn UIColor(red: \(color.red), green: \(color.green), blue: \(color.blue), alpha: \(color.alpha))"
        case .Redirect(let redirection): return "\n\t\t\treturn \(redirection.redirection)WithTraitCollection(traitCollection)"
        case .Hash(let hash):
            var string = ""
            for (condition, rhs) in hash {
                if !condition.isDefault() {
                    string += "\n\t\t\tif \(condition.generate()) { \(rhs.generate()) }"
                }
            }
            for (condition, rhs) in hash {
                if condition.isDefault() {
                    string += "\n\t\t\t\(rhs.generate())"
                }
            }
            return string
        }        
    }
}

//MARK: Property

internal class Property {
    
    internal var rhs: RhsValue
    internal let key: String
    internal var isOverride: Bool = false
    
    internal init(key: String, rhs: RhsValue) {
        self.rhs = rhs
        self.key = key
    }
}

extension Property: Generatable {
    
    internal func generate() -> String {
        var method = ""
        method += "\n\n\t\t//MARK: \(self.key) "
        if !self.isOverride {
            method += "\n\t\tprivate var __\(self.key): \(self.rhs.returnValue())?"
        }
        
        let objc = ObjcGeneration ? "@objc " : ""
        let methodPublic = self.rhs.isHash ? "public" : "private"
        let methodArgs = "traitCollection: UITraitCollection? = UIScreen.mainScreen().traitCollection"
        let override = self.isOverride ? "override " : ""
        
        method += "\n\t\t\(override)\(methodPublic) func \(self.key)WithTraitCollection(\(methodArgs)) -> \(self.rhs.returnValue()) {"
        method += "\n\t\t\tif let override = __\(self.key) { return override }"
        method += "\(rhs.generate())"
        method += "\n\t\t}"
        
        if !self.isOverride {
            method += "\n\t\t\(objc)public var \(self.key): \(self.rhs.returnValue()) {"
            method += "\n\t\t\tget { return self.\(self.key)WithTraitCollection() }"
            method += "\n\t\t\tset { __\(self.key) = newValue }"
            method += "\n\t\t}"
        }
        return method
    }
}

//MARK: Style

internal class Style {
    
    internal let name: String
    internal var superclassName: String? = nil
    internal let properties: [Property]
    
    internal init(name: String, properties: [Property]) {
        
        var styleName = name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        //superclass defined
        if let components = Optional(styleName.componentsSeparatedByString("<")) where components.count == 2 {
            styleName = components[0].stringByReplacingOccurrencesOfString(" ", withString: "")
            self.superclassName = components[1].stringByReplacingOccurrencesOfString(" ", withString: "")
        }
        
        self.name = styleName
        self.properties = properties
    }
}

extension Style: Generatable {
    
    internal func generate() -> String {
        var wrapper = ""
        wrapper += "//MARK: - \(self.name)"
        let objc = ObjcGeneration ? "@objc " : ""
        var superclass = ObjcGeneration ? ": NSObject" : ""
        if let s = self.superclassName { superclass = ": \(s)Style" }
        wrapper += "\n\t\(objc)public static let \(self.name) = \(self.name)Style()"
        wrapper += "\n\t\(objc)public class \(self.name)Style\(superclass) {"
        for property in self.properties {
            wrapper += property.generate()
        }
        wrapper += "\n\t}\n"
        return wrapper
    }
}

//MARK: Stylesheet

internal class Stylesheet {
    
    internal let name: String
    internal let styles: [Style]
    
    internal init(name: String, styles: [Style]) {
        
        self.name = name
        self.styles = styles
        
        //resolve the type for the redirected values
        for style in styles {
            for property in style.properties {
                if property.rhs.isRedirect {
                    let redirection = property.rhs.redirection!
                    let type = self.resolveRedirectedType(redirection)
                    property.rhs = RhsValue.Redirect(redirection: RhsRedirectValue(redirection: redirection, type: type))
                }
            }
        }
        
        //mark the overrides
        for style in styles.filter({ return $0.superclassName != nil }) {
            for property in style.properties {
                property.isOverride = self.propertyIsOverride(property.key, superclass: style.superclassName!)
            }
        }
        
    }
    
    //determines if this property is an override or not
    private func propertyIsOverride(property: String, superclass: String) -> Bool {
        let style = self.styles.filter() { return $0.name == superclass}.first!
        if let _ = style.properties.filter({ return $0.key == property }).first {
            return true
        } else {
            if let s = style.superclassName {
                return self.propertyIsOverride(property, superclass: s)
            } else {
                return false
            }
        }
    }
    
    //Recursively resolves the return type for this redirected property
    private func resolveRedirectedType(redirection: String) -> String {
        
        let components = redirection.componentsSeparatedByString(".")
        assert(components.count == 2)
        
        let style = self.styles.filter() { return $0.name == components[0]}.first!
        let property = style.properties.filter() { return $0.key == components[1] }.first!
        
        if property.rhs.isRedirect {
            return self.resolveRedirectedType(property.rhs.redirection!)
        } else {
            return property.rhs.returnValue()
        }
    }
}

extension Stylesheet: Generatable {

    internal func generate() -> String {
        var stylesheet = ""
        
        let objc = ObjcGeneration ? "@objc " : ""
        let superclass = ObjcGeneration ? ": NSObject" : ""

        stylesheet += "///Autogenerated file\n"
        stylesheet += "\nimport UIKit\n\n"
        stylesheet += "///Entry point for the app stylesheet\n"
        stylesheet += "\(objc)public class \(self.name)\(superclass) {\n\n"
        for style in self.styles {
            stylesheet += style.generate()
        }
        stylesheet += "\n}"
        return stylesheet
    }

}


