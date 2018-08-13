class AdminPage < Page
  include Capybara::DSL

  def visit_page
    visit "/admin/index"
  end

  def make_other_user_a_guest(user)
    find("tr#user_#{user.id}").click_link('Make Guest')
  end

  def make_other_user_a_chair(user)
    find("tr#user_#{user.id}").click_link('Make Chair')
    select 'E', :from => 'session_id'
    select 'Aqua', :from => 'color'
    find('input[type="submit"]').click
  end

  def make_other_user_an_admin(user)
    find("tr#user_#{user.id}").click_link('Make Admin')
  end

  def visit_applicant_update_page(applicant)
    find("tr#applicant_#{applicant.id}").click_link("#{applicant.uin}")
  end
  
  def update_applicant(applicant)
    # byebug
    find("tr#applicant_#{applicant.id}").click_link("#{applicant.uin}")
    fill_in 'applicant[first_name]', :with => 'James'
    fill_in 'applicant[last_name]', :with => 'Vanderburg'
    find('input[type="submit"]').click
  end

end
