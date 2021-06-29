//
// Evaluation.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
public enum ValueType: Codable, Equatable {
	
    public typealias Value = [String: ValueType]
	case bool(Bool)
	case string(String)
	case int(Int)
	case object(Value)
	
	public init(from decoder: Decoder) throws {
		let singleValueContainer = try decoder.singleValueContainer()
		if let value = try? singleValueContainer.decode(Bool.self) {
			self = .bool(value)
			return
		} else if let value = try? singleValueContainer.decode(String.self) {
			self = .string(value)
			return
		} else if let value = try? singleValueContainer.decode(Int.self) {
			self = .int(value)
			return
		}else if let value = try? singleValueContainer.decode(Value.self) {
			self = .object(value)
			return
		}
		throw CFError.parsingError
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		switch self {
			case .bool(let boolVal): try container.encode(boolVal)
			case .string(let stringVal): try container.encode(stringVal)
			case .int(let intVal): try container.encode(intVal)
			case .object(let objectVal): try container.encode(objectVal)
		}
	}
	
	public var boolValue: Bool? {
		switch self {
			case .bool(let boolVal): return boolVal
			case .string(let stringVal):
				switch stringVal.lowercased() {
					case "true":  return true
					case "false": return false
					default: 	  return nil
				}
			case .int(let intVal):
				switch intVal {
					case 0:  return false
					case 1:  return true
					default: return nil
				}
			default: return nil
		}
	}
	
	public var intValue: Int? {
		switch self {
			case .int(let intVal): return intVal
			case .string(let stringVal): return Int(stringVal)
			case .bool(let boolVal):
				switch boolVal {
					case true:  return 1
					case false: return 0
				}
			default: return nil
		}
	}
	
	public var stringValue: String? {
		switch self {
			case .string(let stringVal): return stringVal
			case .bool(let boolVal): 	 return "\(boolVal)"
			case .int(let intVal): 		 return "\(intVal)"
			case .object(let objectVal): return "\(ValueType.object(objectVal))"
		}
	}
	
	public var objectValue: Value? {
		switch self {
			case .object(let objectVal): return objectVal
			default: return nil
			}
		}
}

public struct Evaluation: Codable {
    
    public var flag: String
    public var identifier: String
    public var value: ValueType

    public init(flag: String, identifier: String, value: ValueType) {
        
        self.flag = flag
        self.identifier = identifier
        self.value = value
    }
    
    public func isValid() -> Bool {
        
        return !identifier.isEmpty
    }
}
