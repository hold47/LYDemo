//  Created by yaoshuai on 2018/5/22.
//  Copyright © 2018 ys. All rights reserved.

import UIKit

class YSBaseCell_colv_headerFooter: UICollectionReusableView {
    
    public private(set) weak var ys_sourceVC: UIViewController?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
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
    }
    
    open func setupUI(){
        
    }
    
    open func ys_setupSourceVC(_ sourceVC: UIViewController?){
        self.ys_sourceVC = sourceVC
    }
}
