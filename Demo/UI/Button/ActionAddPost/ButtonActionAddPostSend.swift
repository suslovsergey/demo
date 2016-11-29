import UIKit
import Stevia
import Material
class ButtonActionAddPostSend: RaisedButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        self.layer.borderColor = UIColor.green.cgColor
        self.backgroundColor = Color.green.lighten1
        self.text("Send")
    }
}

