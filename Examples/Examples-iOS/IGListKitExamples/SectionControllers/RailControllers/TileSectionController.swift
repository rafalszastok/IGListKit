//
//  VideoTileSectionController.swift
//  

import Foundation

import UIKit
import IGListKit

class TileSectionController: ListSectionController {

    var tiles: [Tile] = []
    let railIdentifier: String

    init(tiles: [Tile],
         railIdentifier: String) {

        self.tiles = tiles
        self.railIdentifier = railIdentifier
        super.init()

        self.inset = UIEdgeInsets(
            top: 0,
            left: 20,
            bottom: 0,
            right: 20)
        minimumLineSpacing = 20
    }

}

extension TileSectionController {

    override func numberOfItems() -> Int {
        return tiles.count
    }

    override func sizeForItem(at index: Int) -> CGSize {
        // Fix for crash sizeForItem (will crash if you scroll to the end of changing rail).
        guard index < tiles.count else {
            print("sizeForItem: Index is out of bounds")
            assertionFailure()
            return CGSize(width: 100, height: 100)
        }
        return CGSize(width: 100, height: 100)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {

        // Fix for crash sizeForItem (will crash if you scroll to the end of changing rail).
        if index >= tiles.count {
            print("Error. Index \(index) is out of viewModel.count=\(tiles.count)")
            assertionFailure()
            return UICollectionViewCell()
        } else {
            guard let cell = collectionContext?.dequeueReusableCell(of: CenterLabelCell.self, for: self, at: index) as? CenterLabelCell else {
                fatalError()
            }
            cell.backgroundColor = UIColor.lightGray
            cell.text = tiles[index].title
            return cell
        }
    }

    override func didUpdate(to object: Any) {
        guard let obj = object as? DiffBox<RailViewModel> else { return }
        let value = obj.value
        tiles = value.tiles
    }

    override func didSelectItem(at index: Int) {

    }

}
