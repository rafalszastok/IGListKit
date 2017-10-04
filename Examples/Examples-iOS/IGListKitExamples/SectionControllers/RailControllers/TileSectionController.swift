//
//  VideoTileSectionController.swift
//  

import Foundation

import UIKit
import IGListKit

class TileSectionController: ListSectionController {

    var tile: Tile?

    override init() {
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
        return 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: CenterLabelCell.self, for: self, at: index) as? CenterLabelCell else {
            fatalError()
        }
        cell.backgroundColor = UIColor.lightGray
        cell.text = tile?.title
        return cell
    }

    override func didUpdate(to object: Any) {
        guard let obj = object as? DiffBox<Tile> else { return }
        tile = obj.value
    }

    override func didSelectItem(at index: Int) {

    }

}
