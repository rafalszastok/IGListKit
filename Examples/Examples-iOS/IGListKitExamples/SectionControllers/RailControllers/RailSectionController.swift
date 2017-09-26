//
//  RailSectionController.swift
//

import IGListKit

class RailSectionController: ListSectionController {

    var rail: RailViewModel
    let sectionController: TileSectionController

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                  viewController: self.viewController,
                                  workingRangeSize: 0)
        adapter.dataSource = self
        return adapter
    }()

    init(rail: RailViewModel,
         sectionController: TileSectionController) {
        self.rail = rail
        self.sectionController = sectionController
        super.init()
    }

}

extension RailSectionController: ListAdapterDataSource {
    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [DiffBox(value: rail, uniqueIdentifier: NSString(string: rail.railId))]
    }

    func listAdapter(_ listAdapter: ListAdapter,
                     sectionControllerFor object: Any)
        -> ListSectionController {
            return sectionController
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

        //swiftlint:enable force_cast
        adapter.collectionView = cell.collectionView

        return cell
    }

    override func didUpdate(to object: Any) {
        if let obj = object as? DiffBox<RailViewModel> {
            rail = obj.value
        }
    }

    override func didSelectItem(at index: Int) {
    }
}

extension RailSectionController {

    var contentOffset: CGPoint {

        guard let offset = adapter.collectionView?.contentOffset else {
            return .zero
        }

        return offset
    }

    func updateOffset(to offSet: CGPoint) {
        adapter.collectionView?.setContentOffset(offSet, animated: false)
    }
}


