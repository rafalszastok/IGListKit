/**
 Copyright (c) 2016-present, Facebook, Inc. All rights reserved.

 The examples provided by Facebook are for non-commercial testing and evaluation
 purposes only. Facebook reserves all rights not expressly granted.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit
import IGListKit

class NestedAdapterViewModel: ListDiffable {
    let identifier: NSString
    let value: Int

    func diffIdentifier() -> NSObjectProtocol {
        return identifier
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let viewModel = object as? NestedAdapterViewModel {
            return viewModel.identifier == self.identifier
            && viewModel.value == self.value
        }
        return false
    }

    init(identifier: NSString, value: Int) {
        self.identifier = identifier
        self.value = value
    }
}

final class NestedAdapterViewController: UIViewController, ListAdapterDataSource {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var data: [NestedAdapterViewModel] = []

    var iterator: Int = 0

    @objc func updateData() {
        if iterator % 3 == 0 {
            data = [
                NestedAdapterViewModel(identifier: "A", value: 1),
                NestedAdapterViewModel(identifier: "B", value: 3),
                NestedAdapterViewModel(identifier: "C", value: 4)
            ]
        } else if iterator % 3 == 1 {
            data = [
                NestedAdapterViewModel(identifier: "A", value: 1),
                NestedAdapterViewModel(identifier: "B", value: 5),
                NestedAdapterViewModel(identifier: "C", value: 6)
            ]
        } else {
            data = [
                NestedAdapterViewModel(identifier: "A", value: 2),
                NestedAdapterViewModel(identifier: "B", value: 7),
                NestedAdapterViewModel(identifier: "C", value: 8)
            ]
        }
        iterator += 1
        adapter.performUpdates(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(updateData),
                userInfo: nil, repeats: true)

        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is NestedAdapterViewModel {
            return HorizontalSectionController()
        } else {
            return LabelSectionController()
        }
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}
