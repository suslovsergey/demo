//
// Created by Sergey Suslov on 19.11.16.
// Copyright (c) 2016 SS. All rights reserved.
//

import UIKit
import Stevia
import RxSwift
import RxCocoa
import XLActionController
import Whisper
import ReachabilitySwift
import AlamofireImage
import Material
import SwiftyTimer

class ControllerPosts: UITableViewController {
    fileprivate var response: [StorageItemPost] = ModelStorage.posts()
    fileprivate let disposeBag = DisposeBag()
    fileprivate let reachability = Reachability()!
    //
    fileprivate let userImage = UIImage(named: "user")?.af_imageScaled(to: CGSize(width: 32.0, height: 32.0))
    fileprivate let postImage = UIImage(named: "post")?.af_imageScaled(to: CGSize(width: 32.0, height: 32.0))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = true
        tableView.estimatedRowHeight = 100.0
        tableView.separatorStyle = .none
        self.setupNavigationBar()
        self.observing()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupReachability()
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return response.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CellMain /* For AppCode beta*/ = tableView.cell(CellMain.self)

        if let item = response[safe: indexPath.section] {
            cell.body = item.body
            cell.nameAndDate = (name: item.name, date: item.date)
            cell.userPic = item.userPicUrl
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3.0
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3.0
    }
}

private extension ControllerPosts {
    func observing() {
        Notify.target(self).observe(NotifyLoadPostsStart.self) { [weak self] _ in
                  guard let s = self, let nav = s.navigationController else {
                      return
                  }
                  DispatchQueue.main.async {
                      Whisper.show(whisper: Message(title: "Updating...", backgroundColor: Color.orange.lighten1),
                              to: nav,
                              action: .present)
                  }
              }

        Notify.target(self).observe(NotifyLoadPostsStop.self) { [weak self] _ in
                  guard let s = self, let nav = s.navigationController else {
                      return
                  }
                  DispatchQueue.main.async {
                      hide(whisperFrom: nav, after: 2)
                  }
              }


        Notify.target(self).observe(NotifyUpdatePosts.self) { [weak self] _ in
                  guard let s = self else {
                      return
                  }

                  let n = ModelStorage.posts()
                  let delta = n.count - s.response.count
                  s.response = n

                  if delta > 0 {
                      s.tableView.beginUpdates()
                      for (i) in 0 ..< delta {
                          s.tableView.insertSections(NSIndexSet(index: i) as IndexSet, with: .top)
                      }
                      s.tableView.endUpdates()

                  }
                  else {
                      s.tableView.reloadData()
                  }

              }


        Notify.target(self).observe(NotifyUploadNotDeliveredPostsStart.self) { [weak self] _ in
                  guard let s = self, let nav = s.navigationController else {
                      return
                  }
                  Whisper.show(whisper: Message(title: "Synchronization...", backgroundColor: Color.orange.lighten1),
                          to: nav,
                          action: .present)
              }

        Notify.target(self).observe(NotifyUploadNotDeliveredPostsStop.self) { [weak self] _ in
                  guard let s = self, let nav = s.navigationController else {
                      return
                  }
                  hide(whisperFrom: nav, after: 2)
              }
    }

    func setupNavigationBar() {

        let addPostItem = UIBarButtonItem(image: postImage,
                landscapeImagePhone: postImage,
                style: .plain,
                target: nil,
                action: nil)

        addPostItem.rx.tap.bindNext({ [weak self] _ in
                              let action = ActionControllerAddPost()
                              action.headerData = "Add new post"
                              action.addAction(Action("", style: .default, handler: nil))
                              self?.present(action, animated: true, completion: nil)
                          }).addDisposableTo(disposeBag)


        let changeUserInfo = UIBarButtonItem(image: userImage,
                landscapeImagePhone: userImage,
                style: .plain,
                target: nil,
                action: nil)

        changeUserInfo.rx.tap.bindNext({ [weak self] _ in
                                 let action = ActionControllerUser()
                                 action.headerData = "Change user data"
                                 action.addAction(Action("", style: .default, handler: nil))
                                 self?.present(action, animated: true, completion: nil)
                             }).addDisposableTo(disposeBag)

        self.navigationItem.rightBarButtonItem = addPostItem
        self.navigationItem.leftBarButtonItem = changeUserInfo
    }

    func setupReachability() {
        reachability.whenReachable = { [weak self] r in
            Log.trace("Get inet")
            Cron.sharedInstance.run()

            guard let s = self else {
                return
            }
            DispatchQueue.main.async {
                s.title = "System Online"
                s.navigationController?.navigationBar.barTintColor = Color.green.lighten1
            }
            
        }

        reachability.whenUnreachable = { [weak self] r in
            Log.trace("lost inet")
            Cron.sharedInstance.stop()

            guard let s = self else {
                return
            }
            DispatchQueue.main.async {
            s.title = "System Offline"
            s.navigationController?.navigationBar.barTintColor = Color.red.lighten1
            }
        }

        do {
            try reachability.startNotifier()
        }
        catch {
            Log.error("Unable to start notifier")
        }
    }
}
