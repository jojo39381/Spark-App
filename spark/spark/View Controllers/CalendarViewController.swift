//
//  CalendarViewController.swift
//  spark
//
//  Created by Joseph Yeh on 6/23/20.
//  Copyright © 2020 Joseph Yeh. All rights reserved.
//

import UIKit
import JTAppleCalendar
import ChameleonFramework
class CalendarViewController: UIViewController, JTACMonthViewDelegate, JTACMonthViewDataSource{

    
    let layout = UICollectionViewFlowLayout()
    let calendarView = JTACMonthView()
    let dayView = DayView()
    
    let theme = UIColor.rgb(red: 251, green: 228, blue: 85)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.rgb(red: 251, green: 228, blue: 85)
       
        
        self.view.addSubview(calendarView)
        
         self.view.addSubview(dayView)
        dayView.backgroundColor = .white
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: calendarView)
        view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: dayView)
        view.addConstraintsWithFormat(format: "V:|-100-[v0(300)]-20-[v1]-100-|", views: calendarView, dayView)
        
        
        
        calendarView.register(DateCell.self, forCellWithReuseIdentifier: "dateCell")
        calendarView.register(DateHeader.self, forSupplementaryViewOfKind:  UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DateHeader")
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        calendarView.isPagingEnabled = true
        calendarView.scrollDirection = .horizontal
      
        calendarView.backgroundColor = UIColor.white
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.layer.cornerRadius = 20
        dayView.layer.shadowColor = UIColor.flatPurple().cgColor
         dayView.layer.shadowOpacity = 1
         dayView.layer.shadowOffset = .zero
         dayView.layer.shadowRadius = 5
        
        calendarView.layer.cornerRadius = 20
       calendarView.layer.shadowColor = UIColor.flatPurple().cgColor
        calendarView.layer.shadowOpacity = 1
        calendarView.layer.shadowOffset = .zero
        calendarView.layer.shadowRadius = 5
        
        calendarView.clipsToBounds = false
        calendarView.layer.masksToBounds = false
       
       guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.backgroundColor = theme
        navigationBar.barTintColor = theme
        navigationBar.tintColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
       
        
        self.calendarView.selectDates([ Date() ])
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    

    
    
    
    
    
    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
    }

    func handleCellSelected(cell: DateCell, cellState: CellState) {
         
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius =  25
            cell.selectedView.isHidden = false
           let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
                  formatter.dateFormat = "EEE\nMM.dd.yy"
            print(cellState.date)
            let myCalendar = Calendar(identifier: .gregorian)
            
            dayView.dateLabel.text = formatter.string(from: cellState.date)
            
            
            
        } else {
            cell.selectedView.isHidden = true
        }
    }
        
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
       if cellState.dateBelongsTo == .thisMonth {
          cell.dateLabel.textColor = UIColor.black
       } else {
          cell.dateLabel.textColor = UIColor.gray
       }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
class DateCell: JTACDayCell {
    
    var dateLabel: UILabel = {
        let la = UILabel()
        return la
    }()
    var selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 251, green: 228, blue: 85)
        view.layer.cornerRadius = 100
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addSubview(selectedView)
        self.addSubview(dateLabel)
       
       
        
        addConstraintsWithFormat(format: "H:[v0]", views: dateLabel)
        addConstraintsWithFormat(format: "V:[v0]", views: dateLabel)
        addConstraints([NSLayoutConstraint(item: dateLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: dateLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        addConstraintsWithFormat(format: "H:[v0(50)]", views: selectedView)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: selectedView)
        
        addConstraints([NSLayoutConstraint(item: selectedView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: selectedView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    
}


class DateHeader: JTACMonthReusableView {
    var monthTitle: UILabel = {
           let la = UILabel()
           return la
       }()

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var weekStack: UIStackView = {
        let stackView = UIStackView()
        let mon = UILabel()
        mon.text = "Mon"
        mon.textAlignment = .center

        let tue = UILabel()
        tue.text = "Tue"
        tue.textAlignment = .center
   
        let wed = UILabel()
        wed.text  = "Wed"
        wed.textAlignment = .center
   
        let thu = UILabel()
        thu.text = "Thu"
        thu.textAlignment = .center
    
        let fri = UILabel()
        fri.text = "Fri"
        fri.textAlignment = .center
      
        let sat = UILabel()
        sat.text = "Sat"
        sat.textAlignment = .center
      
        
        let sun = UILabel()
        sun.text = "Sun"
        sun.textAlignment = .center
       
        
        
        stackView.addArrangedSubview(mon)
        stackView.addArrangedSubview(tue)
        stackView.addArrangedSubview(wed)
        stackView.addArrangedSubview(thu)
        stackView.addArrangedSubview(fri)
        stackView.addArrangedSubview(sat)
        stackView.addArrangedSubview(sun)
        
        stackView.distribution = .fillEqually
        
        
       
        return stackView
    }()
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addSubview(monthTitle)
        self.addSubview(weekStack)
       
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: monthTitle)
        addConstraintsWithFormat(format: "H:|[v0]|", views: weekStack)
        addConstraintsWithFormat(format: "V:|-[v0]-[v1]-|", views: monthTitle, weekStack)
        
        addConstraints([NSLayoutConstraint(item: monthTitle, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}
extension CalendarViewController {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"

        var dateComponent = DateComponents()
        dateComponent.year = 1
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: dateComponent, to: startDate)!
        return ConfigurationParameters(startDate: startDate,
                                       endDate: endDate,
                                       generateInDates: .forAllMonths,
                                       generateOutDates: .tillEndOfGrid)
    }
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
       let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
       self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
       return cell
    }
        
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
       configureCell(view: cell, cellState: cellState)
    }
    
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        formatter.dateFormat = "MMM"
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = formatter.string(from: range.start)
        header.monthTitle.textAlignment = .center
        return header
    }

    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 70)
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        print("seleced")
               configureCell(view: cell, cellState: cellState)
    }
    
   

    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        print("deselected")
         configureCell(view: cell, cellState: cellState)
        
    }
 
    
}
