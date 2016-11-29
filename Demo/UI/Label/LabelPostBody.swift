import UIKit

final class LabelPostBody: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        self.font =  UIFont.systemFont(ofSize: 14.0)
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    }
}
