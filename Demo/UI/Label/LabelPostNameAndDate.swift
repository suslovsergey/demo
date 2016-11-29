import UIKit

final class LabelPostNameAndDate: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        self.font = .italicSystemFont(ofSize: 12.0)
        self.textColor = .lightGray
    }
}
