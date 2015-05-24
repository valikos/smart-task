require 'feature_helper'

feature 'I want to be able to', js: true do
  background do
    @projects = ProjectsPage.new
  end

  scenario 'create project' do
    skip_auth

    @projects.load
    @projects.new_project.click
    @projects.new_project_name.set 'Test Task'
    @projects.add_new_project.click

    expect(@projects).to have_text 'Test Task'
  end

  scenario 'update project' do
    project = FactoryGirl.create(:project)
    skip_auth_for(project.user)
    new_project_name = Faker::Lorem.sentence(2, false, 0)

    @projects.load
    @projects.edit_project.click
    @projects.edit_name_field.set new_project_name
    @projects.confirm_name_edit.click

    expect(@projects).to have_text new_project_name
  end

  scenario 'delete project', dd: true do
    project = FactoryGirl.create(:project)
    skip_auth_for(project.user)

    @projects.load
    @projects.remove_project.click

    expect(@projects).to_not have_text project.name
  end
end
