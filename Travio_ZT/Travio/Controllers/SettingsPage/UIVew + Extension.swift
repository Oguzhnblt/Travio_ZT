import UIKit
import SnapKit

class CustomView: UIView {
    
    convenience init(icon: UIImage?, labelText: String) {
        self.init(frame: .zero)
        
        iconImageView.image = icon
        label.text = labelText
    }
    
    lazy var backView: UIView = {
        let view = UIView()
        view.size(CGSize(width: 358, height: 54))
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.backgroundColor = .content
        
        return view
    }()
    
    // Icon
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // Text
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        return label
    }()
    
    // Button
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.imgRightArrow, for: .normal)
        button.setTitleColor(.background, for: .normal)
        return button
    }()
    
    
    // Horizontal Stack View
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, label, button])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        
        addSubview(backView)
        backView.addSubview(stackView)
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            
        }
        
        button.snp.makeConstraints { buttonMake in
            buttonMake.right.equalTo(backView).offset(-19)
        }
    }
}

#if DEBUG
import SwiftUI

@available(iOS 13 , *)
struct CustomView_Preview: PreviewProvider {
    static var previews: some View {
        CustomView().showPreview()
    }
}
#endif
