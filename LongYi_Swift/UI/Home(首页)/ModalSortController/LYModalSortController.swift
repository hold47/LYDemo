//
//  LYModalSortController.swift
//  LongYiBusiness
//
//  Created by Hold on 2020/10/11.
//

import UIKit

extension LYModalSortController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        handleActions()
        loadData()
    }
    
    func bind() {
        
        viewModel.cateRelay.skip(1).subscribe(onNext: { [weak self] models in
            if models.count > 0 {
                self?.leftTable.reloadData()
                self?.leftTable.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
                self?.rightTable.reloadData()
            }
        }).disposed(by: disposeBag)
        
    }
    
    func handleActions() {

        resetButton.rx.tap.subscribe { [weak self] _ in
            self?.reset()
        }.disposed(by: disposeBag)
        
        confirmButton.rx.tap.subscribe { [weak self] _ in
            self?.selectCateIDClosure?(self?.viewModel.selectID)
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
        
    }
    
    func loadData() {
        indicator.isHidden = false
        indicator.startAnimating()
        viewModel.getCategory { [weak self] (error) in
            self?.indicator.stopAnimating()
            if error != LYRequestError.success {
                HUD.show(.error(error.errorDescription)).hide(HUDLastTime)
            }
        }
    }
    
    private func reset() {
        HUD.show(.toast("已重置")).hide(1)
        let indexZero = IndexPath(row: 0, section: 0)
        leftTable.selectRow(at: indexZero, animated: false, scrollPosition: .none)
        leftTable.scrollToRow(at: indexZero, at: .top, animated: false)
        rightTable.scrollToRow(at: indexZero, at: .top, animated: false)
        viewModel.selectID = nil
    }
    
}

extension LYModalSortController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == leftTable {
            return 1
        } else {
            return viewModel.cateRelay.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTable {
            return viewModel.cateRelay.value.count
        } else {
            guard viewModel.cateRelay.value.count > 0 else { return 0 }
            return viewModel.cateRelay.value[section].children?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTable {
            let cell = tableView.dequeueReusableCell(withClass: LYModalSortLeftCell.self, for: indexPath)
            let model = viewModel.cateRelay.value[indexPath.row]
            cell.titleLabel.text = model.name
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withClass: LYModalSortRightCell.self, for: indexPath)
            let model = viewModel.cateRelay.value[indexPath.section].children?[indexPath.row]
            cell.titleLabel.text = model?.name
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTable {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.setSelected(true, animated: false)
            let index = IndexPath(row: 0, section: indexPath.row)
            rightTable.scrollToRow(at: index, at: .top, animated: false)
        } else {
            viewModel.selectID = viewModel.cateRelay.value[indexPath.section].children?[indexPath.row].id
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == rightTable {
            leftTable.selectRow(at: IndexPath(row: indexPath.section, section: 0), animated: false, scrollPosition: .none)
        }
    }
}

class LYModalSortController: YSModal_presentedVC {
    
    var selectCateIDClosure: ((Int?) -> Void)?
    let viewModel = LYModalSortCategoryViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var leftTable: UITableView! {
        didSet {
            leftTable.dataSource = self
            leftTable.delegate = self
            leftTable.separatorStyle = .none
            leftTable.tableFooterView = UIView()
            leftTable.register(nib: UINib(nibName: "\(LYModalSortLeftCell.self)", bundle: nil), withCellClass: LYModalSortLeftCell.self)
        }
    }
    @IBOutlet weak var rightTable: UITableView! {
        didSet {
            rightTable.dataSource = self
            rightTable.delegate = self
            rightTable.separatorStyle = .none
            rightTable.tableFooterView = UIView()
            rightTable.register(nib: UINib(nibName: "\(LYModalSortRightCell.self)", bundle: nil), withCellClass: LYModalSortRightCell.self)
        }
    }
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    //  设置modal的maskView
    override func ys_setupMaskView() -> (bgC: UIColor, alpha: CGFloat) {
        return (.black, 0.4)
    }
    
    //  设置modal的方向和宽高
    override func ys_setupDirectionAndLength() -> (direction: YSModal_direction, length: CGFloat) {
        return (.toTop, 435 + Constant.safeArea.bottom)
    }

}
