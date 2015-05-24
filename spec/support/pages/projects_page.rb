class ProjectsPage < SitePrism::Page
  set_url '/'

  element :new_project,       '.project-add'
  element :new_project_name,  '.new-project-name'
  element :add_new_project,   '.add-new-project'
  element :edit_project,      '.edit-project'
  element :edit_name_field,   '.edit-name'
  element :confirm_name_edit, '.apply-changes'
  element :remove_project,    '.remove-project'
end
