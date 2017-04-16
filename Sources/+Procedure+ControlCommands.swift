//
//  Tortoise+ControlCommands.swift
//  TortoiseGraphics
//
//  Created by temoki on 2016/08/11.
//  Copyright © 2016 temoki. All rights reserved.
//

import Foundation

/// Procedure: Control commands
public extension Procedure {

    // MARK: - done

    /// Done
    public func done() {
        // end of method chain
    }

    // MARK: - showTortoise

    /// Show the tortoise if it is hidden.
    /// - returns: self
    public func showTortoise() -> Procedure {
        add(command: CommandShowTortoise(show: true))
        return self
    }

    // MARK: - hideTortoise

    /// Hide the tortoise. Its position remains the same.
    /// Drawing happens in the same way, and the tortoiseʼs position is affected by drawing commands
    /// in the same way as when it is showing.
    public func hideTortoise() -> Procedure {
        add(command: CommandShowTortoise(show: false))
        return self
    }

    // MARK: - define (Procedure)

    /// Define a procedure.
    /// Create procedure name with parameters parameters and statements statements.
    /// - parameter procedureName: Procedure name
    /// - parameter parameterNames: Parameter names
    /// - parameter statements: Procedure statements
    /// - returns: self
    public func define(_ procedureName: String,
                       _ parameterNames: [String],
                       _ statements: (Procedure) -> Procedure) -> Procedure {
        let procedure = Procedure()
        parameterNames.forEach { (parameterName) in
            procedure.variables[parameterName] = 0
        }
        add(command: CommandDefine(name: procedureName, procedure: statements(procedure)))
        return self
    }

    // MARK: - call (Procedure)

    /// Call a procedure with parameters.
    /// - parameter procedureName: Procedure name
    /// - parameter parameters: Parameters
    /// - returns: self
    public func call(_ procedureName: String, _ parameters: [String: NumberOutput]) -> Procedure {
        add(command: CommandCall(name: procedureName, parameters: parameters))
        return self
    }

    /// Call a procedure with parameters.
    /// - parameter procedureName: Procedure name
    /// - parameter parameters: Parameters
    /// - returns: self
    public func call(_ procedureName: String, _ parameters: [String: Number]) -> Procedure {
        var newParameters: [String: NumberOutput] = [:]
        parameters.forEach { (keyValue) in
            newParameters[keyValue.key] = {_ in keyValue.value}
        }
        return call(procedureName, newParameters)
    }

    // MARK: - repeat

    /// Run statements statements number times.
    /// - parameter number: Repeat times
    /// - parameter statements: Repeat statements
    /// - returns: self
    public func `repeat`(_ number: @escaping NumberOutput,
                         _ statements: (Procedure) -> Procedure) -> Procedure {
        let procedure = statements(Procedure())
        add(command: CommandRepeat(number: number, procedure: procedure))
        return self
    }

    /// Run statements statements number times.
    /// - parameter number: Repeat times
    /// - parameter statements: Repeat statements
    /// - returns: self
    public func `repeat`(_ number: Number,
                         _ statements: (Procedure) -> Procedure) -> Procedure {
        return `repeat`({_ in number}, statements)
    }

    // MARK: - while

    /// Run statements statements while condition is true.
    /// - parameter condition: condition
    /// - parameter statements: Repeat statements
    /// - returns: self
    public func `while`(_ condition: @escaping BoolOutput,
                        _ statements: (Procedure) -> Procedure) -> Procedure {
        let procedure = statements(Procedure())
        add(command: CommandWhile(condition: condition, procedure: procedure))
        return self
    }

    // MARK: - if

    /// If condition condition is true, execute true-statements, otherwise execute false-statements.
    /// - parameter condition: condition
    /// - parameter Then: True-statements
    /// - parameter Else: False-statements
    /// - returns: self
    public func `if`(_ condition: @escaping BoolOutput,
                     then: (Procedure) -> Procedure,
                     else: ((Procedure) -> Procedure)? = nil) -> Procedure {
        let thenProcedure = then(Procedure())
        let elseProcedure = `else`?(Procedure())
        add(command: CommandIf(condition: condition,
                               thenProcedure: thenProcedure,
                               elseProcedure: elseProcedure))
        return self
    }

    /// If condition condition is true, execute true-statements, otherwise execute false-statements.
    /// - parameter condition: condition
    /// - parameter Then: True-statements
    /// - parameter Else: False-statements
    /// - returns: self
    public func `if`(_ condition: Bool,
                     then: (Procedure) -> Procedure,
                     else: ((Procedure) -> Procedure)?) -> Procedure {
        return `if`({_ in condition}, then: then, else: `else`)
    }

    // MARK: - make (Variable)

    /// Give variable name the value object.
    /// Creates the variable if it doesnʼt exist.
    /// - parameter variableName: Variable name
    /// - parameter number: Number
    /// - returns: self
    public func make(_ variableName: String, _ number: @escaping NumberOutput) -> Procedure {
        add(command: CommandMake(variableName: variableName, number: number))
        return self
    }

    /// Give variable name the value object.
    /// Creates the variable if it doesnʼt exist.
    /// - parameter variableName: Variable name
    /// - parameter number: Number
    /// - returns: self
    public func make(_ variableName: String, _ number: Number) -> Procedure {
        return make(variableName, {_ in number})
    }

    // MARK: - local (Variable)

    /// Declare a name as local to a procedure - effectively a local variable.
    /// - parameter variableName: Variable name
    /// - parameter number: Number
    /// - returns: self
    public func local(_ variableName: String, _ number: @escaping NumberOutput) -> Procedure {
        add(command: CommandLocal(variableName: variableName, number: number))
        return self
    }

    /// Declare a name as local to a procedure - effectively a local variable.
    /// - parameter variableName: Variable name
    /// - parameter number: Number
    /// - returns: self
    public func local(_ variableName: String, _ number: Number) -> Procedure {
        return local(variableName, {_ in number})
    }

    // MARK: - print

    /// Prints out a number to the debug console.
    /// - parameter number: Number
    /// - returns: self
    public func print(_ number: @escaping NumberOutput) -> Procedure {
        add(command: CommandPrint(number: number))
        return self
    }

    /// Prints out a number to the debug console.
    /// - parameter number: Number
    /// - returns: self
    public func print(_ number: Number) -> Procedure {
        return print({_ in number})
    }

    /// Prints out a boolean to the debug console.
    /// - parameter number: Number
    /// - returns: self
    public func print(_ boolean: @escaping BoolOutput) -> Procedure {
        add(command: CommandPrint(boolean: boolean))
        return self
    }

    /// Prints out a boolean to the debug console.
    /// - parameter number: Number
    /// - returns: self
    public func print(_ boolean: Bool) -> Procedure {
        return print({_ in boolean})
    }

}
