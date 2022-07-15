import UIKit

final class WeatherSectionHeaderView: UIView {
    private lazy var backgroundView = UIView()
    private lazy var contentLayoutGuide = UILayoutGuide()
    private lazy var titleLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configure() {
        configureBackgroundView()
        configureContentLayoutGuide()
        configureTitleLabel()
    }
    
    private func configureBackgroundView() {
        addSubview(backgroundView)
        
        backgroundView.backgroundColor = UIColor(named: "cardBackgroundColor")
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func configureContentLayoutGuide() {
        addLayoutGuide(contentLayoutGuide)
        
        let horizontalPadding = 16.0
        NSLayoutConstraint.activate([
            contentLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
            contentLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
            contentLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.font = .systemFont(ofSize: 16.0, weight: .medium)
        titleLabel.textColor = UIColor(named: "textColor")
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentLayoutGuide.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
        ])
    }
    
    // MARK: - Actions
    
    func configureTitleLabelText(_ text: String?) {
        titleLabel.text = text
    }
}
