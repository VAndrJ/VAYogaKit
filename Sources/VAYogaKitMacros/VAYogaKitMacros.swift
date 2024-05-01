//
//  VAYogaKitMacros.swift
//
//
//  Created by VAndrJ on 29.04.2024.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

public struct LayoutMacro: AccessorMacro {

    public static func expansion<Context, Declaration>(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: Declaration,
        in context: Context
    ) throws -> [AccessorDeclSyntax] where Context: MacroExpansionContext, Declaration: DeclSyntaxProtocol {
        guard let varDecl = declaration.as(VariableDeclSyntax.self),
              varDecl.isVar,
              varDecl.isInstance,
              let binding = varDecl.bindings.first,
              binding.pattern.as(IdentifierPatternSyntax.self)?.identifier != nil else {
            throw VAYogaKitMacroError.notVariable
        }

        return [
            AccessorDeclSyntax(accessorSpecifier: .keyword(.didSet)) {
                "setNeedsUpdateLayout()"
            },
        ]
    }
}

public struct ScrollLayoutMacro: AccessorMacro {

    public static func expansion<Context, Declaration>(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: Declaration,
        in context: Context
    ) throws -> [AccessorDeclSyntax] where Context: MacroExpansionContext, Declaration: DeclSyntaxProtocol {
        guard let varDecl = declaration.as(VariableDeclSyntax.self),
              varDecl.isVar,
              varDecl.isInstance,
              let binding = varDecl.bindings.first,
              binding.pattern.as(IdentifierPatternSyntax.self)?.identifier != nil else {
            throw VAYogaKitMacroError.notVariable
        }

        return [
            AccessorDeclSyntax(accessorSpecifier: .keyword(.didSet)) {
                "scrollView.setNeedsUpdateLayout()"
            },
        ]
    }
}

public struct DistinctLayoutMacro: AccessorMacro {

    public static func expansion<Context, Declaration>(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: Declaration,
        in context: Context
    ) throws -> [AccessorDeclSyntax] where Context: MacroExpansionContext, Declaration: DeclSyntaxProtocol {
        guard let varDecl = declaration.as(VariableDeclSyntax.self),
              varDecl.isVar,
              varDecl.isInstance,
              let binding = varDecl.bindings.first,
              let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.trimmed else {
            throw VAYogaKitMacroError.notVariable
        }

        return [
            AccessorDeclSyntax(accessorSpecifier: .keyword(.didSet)) {
                """
                    guard oldValue != \(identifier) else {
                        return
                    }

                    setNeedsUpdateLayout()
                """
            }
        ]
    }
}

public struct ScrollDistinctLayoutMacro: AccessorMacro {

    public static func expansion<Context, Declaration>(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: Declaration,
        in context: Context
    ) throws -> [AccessorDeclSyntax] where Context: MacroExpansionContext, Declaration: DeclSyntaxProtocol {
        guard let varDecl = declaration.as(VariableDeclSyntax.self),
              varDecl.isVar,
              varDecl.isInstance,
              let binding = varDecl.bindings.first,
              let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.trimmed else {
            throw VAYogaKitMacroError.notVariable
        }

        return [
            AccessorDeclSyntax(accessorSpecifier: .keyword(.didSet)) {
                """
                    guard oldValue != \(identifier) else {
                        return
                    }

                    scrollView.setNeedsUpdateLayout()
                """
            }
        ]
    }
}

extension VariableDeclSyntax {
    public var isVar: Bool { bindingSpecifier.tokenKind == .keyword(.var) }
    public var isStatic: Bool { modifiers.contains { $0.name.tokenKind == .keyword(.static) } }
    public var isClass: Bool { modifiers.contains { $0.name.tokenKind == .keyword(.class) } }
    public var isInstance: Bool { !isClass && !isStatic }
}

public enum VAYogaKitMacroError: Error, CustomStringConvertible {
    case notVariable
    case notEnum
    case associatedValue

    public var description: String {
        switch self {
        case .notVariable: "Must be `var` declaration"
        case .notEnum: "Must be `enum`"
        case .associatedValue: "Must not have associated values"
        }
    }
}

@main
struct VAYogaKitMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        LayoutMacro.self,
        DistinctLayoutMacro.self,
        ScrollLayoutMacro.self,
        ScrollDistinctLayoutMacro.self,
    ]
}
