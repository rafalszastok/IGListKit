//
//  RailSectionController.swift
//

import IGListKit

class RailSectionController: ListSectionController {

    var rail: RailViewModel

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController,
                                  workingRangeSize: 0)
        adapter.dataSource = self
        return adapter
    }()

    init(rail: RailViewModel) {
        self.rail = rail
        super.init()
    }

}

extension RailSectionController: ListAdapterDataSource {
    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return rail.tiles.map {
            DiffBox(value: $0, uniqueIdentifier: $0.title as NSString)
        }
    }

    func listAdapter(_ listAdapter: ListAdapter,
                     sectionControllerFor object: Any)
        -> ListSectionController {
            return TileSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension RailSectionController {
    override func numberOfItems() -> Int {
        return 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(
            width: collectionContext!.containerSize.width,
            height: 120)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        //swiftlint:disable force_cast
        guard let cell = collectionContext?.dequeueReusableCell(of: EmbeddedCollectionViewCell.self, for: self, at: index) as? EmbeddedCollectionViewCell else {
            fatalError()
        }
        cell.isAccessibilityElement = false
        cell.backgroundColor = UIColor.red
        //swiftlint:enable force_cast
        adapter.collectionView = cell.collectionView

        return cell
    }

    override func didUpdate(to object: Any) {
        if let obj = object as? DiffBox<RailViewModel> {
            rail = obj.value
            adapter.performUpdates(animated: true, completion: nil)
        }
    }

    override func didSelectItem(at index: Int) {
    }
}
