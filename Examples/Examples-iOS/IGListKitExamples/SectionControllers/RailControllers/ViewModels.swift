//
//  DiffableBox.swift
//  

import Foundation
import IGListKit

public final class DiffBox<T: Equatable>: ListDiffable {

    let value: T
    let uniqueIdentifier: NSObjectProtocol
    let equal: (T, T) -> Bool

    init(value: T, uniqueIdentifier: NSObjectProtocol, equal: @escaping (T, T) -> Bool = (==)) {
        self.value = value
        self.uniqueIdentifier = uniqueIdentifier
        self.equal = equal
    }

    public func diffIdentifier() -> NSObjectProtocol {
        return uniqueIdentifier
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {

        if object === self {
            return true
        }
        if let other = object as? DiffBox {
            return equal(value, other.value)
        }
        return false
    }

    public func isEqual(toValue value: T) -> Bool {
        return equal(value, self.value)
    }
}

struct Tile: Equatable {
    public var title: String = ""

    public static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.title == rhs.title
    }
}


final class RailViewModel: Equatable, ListDiffable {
    let railId: String
    let tiles: [Tile]

    func diffIdentifier() -> NSObjectProtocol {
        return railId as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let rail = object as? RailViewModel {
            return rail == self
        }
        return false
    }
    init(railId: String, tiles: [Tile]) {
        self.railId = railId
        self.tiles = tiles
    }

    public static func ==(lhs: RailViewModel, rhs: RailViewModel) -> Bool {
        return lhs.railId == rhs.railId
            && lhs.tiles == rhs.tiles
    }
}
