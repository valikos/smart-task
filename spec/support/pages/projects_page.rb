class ProjectsPage < SitePrism::Page
  set_url '/'

  # projects elements
  element :new_project,       '.project-add'
  element :new_project_name,  '.new-project-name'
  element :add_new_project,   '.add-new-project'
  element :edit_project,      '.edit-project'
  element :remove_project,    '.remove-project'

  # edit name elements
  element :edit_name_field,   '.edit-name'
  element :confirm_name_edit, '.apply-changes'

  # tasks elements
  elements :new_task_field, '.new-task'
  elements :add_new_task,   '.add-new-task'
  elements :task_item,      '.task'
  elements :edit_task,      '.edit-task'
  elements :remove_task,    '.remove-task'
  elements :task_due_date,  '.set-due-date'
  elements :reorder_task,   '.reorder-task'
  elements :task_status_checkbox, '.task-status-control'

  section :datepicker, DatepickerSection, "ul.dropdown-menu"
end
