require 'feature_helper'

feature 'I want to be able to', js: true do
  background do
    @page = ProjectsPage.new
  end

  scenario 'add coments to my tasks' do
    task = FactoryGirl.create :task
    skip_auth_for(task.project.user)

    @page.load
    @page.task_comments[0].click
    @page.comments.new_comment_field.set 'Nice'
    @page.comments.add_new_comment.click

    expect(@page.comments.comment[0]).to have_text 'Nice'
  end

  scenario 'delete coments' do
    comment = FactoryGirl.create :comment
    skip_auth_for(comment.task.project.user)

    @page.load
    @page.task_comments[0].click
    @page.comments.remove_comment[0].click

    expect(@page.comments).to have_text 'No comments ...'
  end
end
