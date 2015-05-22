require 'feature_helper'

feature 'I want to be able to', js: true do
  background do
    skip_auth
    @projects = ProjectsPage.new
  end

  scenario 'create project' do
    @projects.load
    @projects.new_project.click
    @projects.new_project_name.set 'Test Task'
    @projects.add_new_project.click

    expect(@projects).to have_text 'Test Task'
  end
end
