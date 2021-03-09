//  Created by yaoshuai on 2018/5/22.
//  Copyright © 2018 ys. All rights reserved.

import UIKit

open class YSBaseCell_tbv__subtitle: UITableViewCell {

    public private(set) weak var ys_sourceVC: UIViewController?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupProperty()
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupProperty()
        setupUI()
    }
    
    open func setupProperty(){
        backgroundColor = UIColor.white
        selectionStyle = .none
    }
    
    open func setupUI(){
        
    }
    
    open func ys_setupSourceVC(_ sourceVC: UIViewController?){
        self.ys_sourceVC = sourceVC
    }
}
