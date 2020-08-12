
import SnapKit

public extension Array {
    
    @available(swift, deprecated:3.0, message:"Use newer snp.* syntax.")
    func snp_prepareConstraints(_ closure: (_ make: ConstraintMaker) -> Void) -> [Constraint] {
        return self.snp.prepareConstraints(closure)
    }
    
    @available(swift, deprecated:3.0, message:"Use newer snp.* syntax.")
    func snp_makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.snp.makeConstraints(closure)
    }
    
    @available(swift, deprecated:3.0, message:"Use newer snp.* syntax.")
    func snp_remakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.snp.remakeConstraints(closure)
    }
    
    @available(swift, deprecated:3.0, message:"Use newer snp.* syntax.")
    func snp_updateConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        self.snp.updateConstraints(closure)
    }
    
    @available(swift, deprecated:3.0, message:"Use newer snp.* syntax.")
    func snp_removeConstraints() {
        self.snp.removeConstraints()
    }
    
    func snp_distributeViewsAlong(axisType: NSLayoutConstraint.Axis,
                                  fixedSpacing: CGFloat,
                                  leadSpacing: CGFloat = 0,
                                  tailSpacing: CGFloat = 0) {
        
        self.snp.distributeViewsAlong(axisType: axisType,
                                      fixedSpacing: fixedSpacing,
                                      leadSpacing: leadSpacing,
                                      tailSpacing: tailSpacing)
    }
    
    @available(swift, deprecated:3.0, message:"Use newer snp.* syntax.")
    func snp_distributeViewsAlong(axisType: NSLayoutConstraint.Axis,
                                  fixedItemLength: CGFloat,
                                  leadSpacing: CGFloat = 0,
                                  tailSpacing: CGFloat = 0) {
        
        self.snp.distributeViewsAlong(axisType: axisType,
                                      fixedItemLength: fixedItemLength,
                                      leadSpacing: leadSpacing,
                                      tailSpacing: tailSpacing)
    }
    
    @available(swift, deprecated:3.0, message:"Use newer snp.* syntax.")
    func snp_distributeSudokuViews(fixedItemWidth: CGFloat,
                                   fixedItemHeight: CGFloat,
                                   warpCount: Int,
                                   edgeInset: UIEdgeInsets = UIEdgeInsets.zero) {
        
        self.snp.distributeSudokuViews(fixedItemWidth: fixedItemWidth,
                                       fixedItemHeight: fixedItemHeight,
                                       warpCount: warpCount,
                                       edgeInset: edgeInset)
    }
    
    @available(swift, deprecated:3.0, message:"Use newer snp.* syntax.")
    func snp_distributeSudokuViews(fixedLineSpacing: CGFloat,
                                   fixedInteritemSpacing: CGFloat,
                                   warpCount: Int,
                                   edgeInset: UIEdgeInsets = UIEdgeInsets.zero) {
        
        self.snp.distributeSudokuViews(fixedLineSpacing: fixedLineSpacing,
                                       fixedInteritemSpacing: fixedInteritemSpacing,
                                       warpCount: warpCount,
                                       edgeInset: edgeInset)
    }
    
    var snp: ConstraintArrayDSL {
        return ConstraintArrayDSL(array: self as! Array<ConstraintView>)
    }
    
}
