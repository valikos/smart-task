require 'feature_helper'

feature 'I want to be able to', js: true do
  background do
    @page = ProjectsPage.new
  end

  scenario 'create project' do
    skip_auth

    @page.load
    @page.new_project.click
    @page.new_project_name.set 'Test Task'
    @page.add_new_project.click

    expect(@page).to have_text 'Test Task'
  end

  scenario 'update project' do
    project = FactoryGirl.create(:project)
    skip_auth_for(project.user)
    new_project_name = Faker::Lorem.sentence(2, false, 0)

    @page.load
    @page.edit_project.click
    @page.edit_name_field.set new_project_name
    @page.confirm_name_edit.click

    expect(@page).to have_text new_project_name
  end

  scenario 'delete project' do
    project = FactoryGirl.create(:project)
    skip_auth_for(project.user)

    @page.load
    @page.remove_project.click

    expect(@page).to_not have_text project.name
  end
end
