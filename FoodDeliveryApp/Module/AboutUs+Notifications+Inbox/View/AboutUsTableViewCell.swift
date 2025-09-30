import UIKit

class AboutUsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblText2: UILabel!
    @IBOutlet weak var lblTimezone: UILabel!
    @IBOutlet weak var btnStar: UIButton!
    @IBOutlet weak var timezoneWidth: NSLayoutConstraint!
    @IBOutlet weak var stackViewLeading: NSLayoutConstraint!
    @IBOutlet weak var stackViewTrailing: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        applyTheme()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuration Methods
    
    /// Configures the cell for "About Us" data.
    /// - Parameter details: The `AboutModel` containing about-us details.
    func configureCellAboutUs(details: AboutModel){
        lblText.text = details.strText
        lblText2.isHidden = true
        lblTimezone.isHidden = true
        btnStar.isHidden = true
        timezoneWidth.constant = 0
        stackViewLeading.constant = 9
    }
    
    /// Configures the cell for "Notifications" data.
    /// - Parameter details: The `AboutModel` containing notification details.
    func configureCellNotifications(details: AboutModel){
        lblText.text = details.strText
        lblText2.text = details.strTimezone
        lblTimezone.isHidden = true
        btnStar.isHidden = true
        timezoneWidth.constant = 0
    }
    
    /// Configures the cell for "Inbox" data.
    /// - Parameter details: The `AboutModel` containing inbox details.
    func configureCellInbox(details: AboutModel){
        lblText.text = details.strText
        lblText2.text = details.strText2
        lblTimezone.text = details.strRightSideText
        btnStar.isHidden = false
        stackViewLeading.constant = 5
        stackViewTrailing.constant = 12
    }
    
    func applyTheme() {
        let theme = ThemeManager.shared.currentTheme
        
        backgroundColor = theme.cardCellBackgroundColor
        contentView.backgroundColor = theme.cardCellBackgroundColor
        layer.borderColor = theme.cardCellBorderColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        lblText.textColor = theme.labelTextColor
        lblText2.textColor = theme.labelTextColor
        lblTimezone.textColor = theme.foodTitleColor
        
        btnStar.tintColor = theme.buttonColor
    }
    // MARK: - Actions
    @IBAction func btnStarClick(_ sender: Any) {
    }
}
