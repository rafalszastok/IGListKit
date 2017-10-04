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

    var data: RailViewModel!
    var iterator = 0

    @objc func updateData() {
        iterator += 1
        if iterator % 3 == 0 {
            data = RailViewModel(railId: "abc", tiles: [
                    Tile(title: "bbb"),
                    Tile(title: "ccc"),
                    Tile(title: "ddd"),
                    ])
            print("A")
        } else if iterator % 3 == 1 {
            data = RailViewModel(railId: "abc", tiles: [
                    Tile(title: "ccc"),
                    Tile(title: "ddd"),
                    Tile(title: "eee"),
                    Tile(title: "fff"),
                    ])
            print("B")
        } else {
            data = RailViewModel(railId: "abc", tiles: [
                    Tile(title: "aaa"),
                    Tile(title: "bbb"),
                    Tile(title: "ccc"),
                    Tile(title: "ddd"),
                    Tile(title: "eee"),
                    Tile(title: "fff"),
                    Tile(title: "ggg"),
                    Tile(title: "hhh"),
                    ])
            print("C")
        }
        self.adapter.performUpdates(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        updateData()
        Timer.scheduledTimer(
            timeInterval: 2.0,
            target: self,
            selector: #selector(updateData),
            userInfo: nil,
            repeats: true)
        Timer.scheduledTimer(
            timeInterval: 2.1,
            target: self,
            selector: #selector(updateData),
            userInfo: nil,
            repeats: true)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {

        return [DiffBox(value: data, uniqueIdentifier: NSString(string: data.railId))]
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return RailSectionController(rail: data)
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}

