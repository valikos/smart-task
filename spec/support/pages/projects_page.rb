class ProjectsPage < SitePrism::Page
  set_url '/'

  element :new_project,      '.project-add'
  element :new_project_name, '.new-project-name'
  element :add_new_project,  '.add-new-project'

end
