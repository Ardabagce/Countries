//
//  OptionalExtensions.swift
//  Countries
//
//  Created by Arda Bağçe on 27.09.2022.
//

import UIKit

protocol EmptyValueRepresentable {
    static var emptyValue: Self { get }
}

extension String: EmptyValueRepresentable {
    static var emptyValue: String { return "" }
}

extension Array: EmptyValueRepresentable {
    static var emptyValue: [Element] { return [] }
}

extension ArraySlice: EmptyValueRepresentable {
    static var emptyValue: ArraySlice { return [] }
}

extension Set: EmptyValueRepresentable {
    static var emptyValue: Set<Element> { return Set() }
}

extension Dictionary: EmptyValueRepresentable {
    static var emptyValue: [Key: Value] { return [:] }
}

extension Optional where Wrapped: EmptyValueRepresentable {
    /// Returns unwrapped value if optional is not nil; returns predefined empty value otherwise.
    var orEmpty: Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return Wrapped.emptyValue
        }
    }
}

extension Optional where Wrapped == Bool {
    
    var orTrue: Bool {
        guard let self = self else { return true }
        
        return self
    }
    
    var orFalse: Bool {
        guard let self = self else { return false }
        
        return self
    }
    
    func isEqualTo(_ bool: Bool?) -> Bool {
        guard let self = self, let bool = bool else { return false }
        
        return self == bool
    }
}

extension Optional {
    
    struct FoundNilWhileUnwrappingError: Error { }
    
    func unwrap() throws -> Wrapped {
        switch self {
        case .some(let wrapped):
            return wrapped
        case .none:
            throw FoundNilWhileUnwrappingError()
        }
    }
}
