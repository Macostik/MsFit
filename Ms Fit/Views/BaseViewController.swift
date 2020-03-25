//
//  BaseViewController.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 18.02.2020.
//  Copyright © 2020 Selecto. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import RealmSwift

typealias ViewModelItem = BaseViewModel<Object>

protocol ViewModelBased: class {
    associatedtype ViewModel
    var viewModel: ViewModel? { get set }
}

public protocol BaseInstance: class {}

public extension BaseInstance where Self: UIViewController {
    static func instance() -> Self {
        return Self()
    }
}

extension BaseInstance where Self: UIViewController & ViewModelBased {
    static func instantiate(with viewModel: ViewModel) -> Self {
        let viewController = Self.instance()
        viewController.viewModel = viewModel
        return viewController
    }
}

private func performWhenLoaded
    <T: BaseViewController<ViewModelItem>>(controller: T, block: @escaping (T) -> Void) {
    controller.whenLoaded { [weak controller] in
        if let controller = controller {
            block(controller)
        }
    }
}

class BaseViewController<T>: UIViewController, ViewModelBased, BaseInstance {
    
    typealias ViewModel = T
    var viewModel: T?
     
    var screenName: String = ""
    internal let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenName = NSStringFromClass(type(of: self))
        Logger.info("\(screenName) create")
        setupUI()
        setupBindings()
        
        if !whenLoadedBlocks.isEmpty {
            whenLoadedBlocks.forEach({ $0() })
            whenLoadedBlocks.removeAll()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LastVisibleScreen.lastAppearedScreenName = screenName
    }
    
    deinit {
        Logger.info("\(NSStringFromClass(type(of: self))) deinit")
    }
    
    private var whenLoadedBlocks = [(() -> Void)]()
       
       func whenLoaded(block: @escaping (() -> Void)) {
           if isViewLoaded {
               block()
           } else {
               whenLoadedBlocks.append(block)
           }
       }
    
    internal func setupUI() {}
    
    internal func setupBindings() {}
}

class BaseTabBarSceneCoordinator<C>: BaseSceneCoordinator<UINavigationController> {
    public var tabBarIcon: String = ""

    func controller() -> BaseViewController<C> {
        return BaseViewController<C>()
    }
        
    override func start() -> Observable<UINavigationController> {
        let navigationController = UINavigationController(rootViewController: controller())
        navigationController.isNavigationBarHidden = true
        navigationController.tabBarItem.image = UIImage(named: tabBarIcon)
        navigationController.tabBarItem.title = tabBarIcon.capitalized

        return Observable<UINavigationController>.just(navigationController)
    }
}

protocol CellIdentifierable {
    static var identifier: String { get }
}

extension CellIdentifierable where Self: UICollectionViewCell {
    static var identifier: String {
        return NSStringFromClass(Self.self)
    }
}

extension CellIdentifierable where Self: UITableViewCell {
    static var identifier: String {
        return NSStringFromClass(Self.self)
    }
}
