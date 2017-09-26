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

final class RailsViewController: UIViewController, ListAdapterDataSource {

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var data: [RailViewModel] = []
    var iterator = 0

    func updateData() {
        iterator += 1
        if iterator % 3 == 0 {
            data = [
                RailViewModel(railId: "abc", tiles: [
                    Tile(title: "aaa"),
                    Tile(title: "bbb"),
                    Tile(title: "ccc"),
                    Tile(title: "ddd"),
                    ])
            ]
        } else if iterator % 3 == 1 {
            data = [
                RailViewModel(railId: "abc", tiles: [
                    Tile(title: "aaa"),
                    Tile(title: "bbb"),
                    Tile(title: "ccc"),
                    Tile(title: "ddd"),
                    Tile(title: "eee"),
                    Tile(title: "fff"),
                    ])
            ]
        } else {
            data = [
                RailViewModel(railId: "abc", tiles: [
                    Tile(title: "aaa"),
                    Tile(title: "bbb"),
                    Tile(title: "ccc"),
                    Tile(title: "ddd"),
                    Tile(title: "eee"),
                    Tile(title: "fff"),
                    Tile(title: "ggg"),
                    Tile(title: "hhh"),
                    ])
            ]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        updateData()
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.updateData()
                self.adapter.performUpdates(animated: true, completion: nil)
            }
            Timer.scheduledTimer(withTimeInterval: 1.1, repeats: true) { _ in
                self.updateData()
                self.adapter.performUpdates(animated: true, completion: nil)
            }
        }
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var boxedRails: [ListDiffable] = []
//        boxedRails.append(DiffBox(
//            value: "Title to show",
//            uniqueIdentifier: "railTitleId"))
        boxedRails.append(DiffBox(
            value: data.first!,
            uniqueIdentifier: NSString(string: "railId")))
        return boxedRails
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return RailSectionController(
            rail: data.first!,
            sectionController: TileSectionController(tiles: data.first!.tiles, railIdentifier: "zzz"))
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}

