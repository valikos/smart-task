class DatepickerSection < SitePrism::Section
  element :today_date, 'button', text: 'Today'
  elements :due_dates, 'ul.dropdown-menu td.text-center.ng-scope button'
end