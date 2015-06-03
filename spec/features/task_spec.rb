require 'feature_helper'

feature 'I want to be able to', js: true do
  background do
    @page = ProjectsPage.new
  end

  scenario 'add tasks to my project' do
    project = FactoryGirl.create :project
    skip_auth_for(project.user)

    @page.load
    @page.new_task_field[0].set 'Todo'
    @page.add_new_task[0].click

    expect(@page).to have_text 'Todo'
  end

  scenario 'update tasks' do
    task = FactoryGirl.create :task
    skip_auth_for(task.project.user)

    new_task_name = Faker::Lorem.sentence(1, false, 0)

    @page.load
    @page.edit_task[0].click
    @page.edit_name_field.set new_task_name
    @page.confirm_name_edit.click

    expect(@page).to have_text new_task_name
  end

  scenario 'delete tasks' do
    task = FactoryGirl.create :task
    skip_auth_for(task.project.user)

    @page.load
    @page.remove_task[0].click

    expect(@page).to_not have_text task.name
  end

  scenario 'choose deadline for my task' do
    task = FactoryGirl.create :task
    skip_auth_for(task.project.user)

    @page.load
    @page.task_due_date[0].click
    @page.datepicker.today_date.click

    expect(@page).to have_text Time.new.strftime("%-m/%-d/%y")
  end

  scenario 'mark a task as `done`' do
    task = FactoryGirl.create :task
    skip_auth_for(task.project.user)

    @page.load
    @page.task_status_checkbox[0].click

    expect(@page.task_name[0][:class]).to include('completed')
  end

  scenario 'prioritise tasks into a project' do
    project = FactoryGirl.create :project
    tasks = FactoryGirl.create_list(:task, 3, project_id: project.id)
    skip_auth_for(project.user)

    @page.load

    source = @page.reorder_task[1]
    target = @page.reorder_task[0]
    source.drag_to(target)

    expect(@page.task_item[1].text).to eq tasks[0].name
    expect(@page.task_item[0].text).to eq tasks[1].name
  end
end
