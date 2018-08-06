class ChairPage < Page
  include Capybara::DSL

  def visit_page
    User.first.create_chair(Session.find_by(name: "E").id, "aqua")
    visit "applicants"
  end

  def click_first_uin
    first('.applicant-link').click
  end

end
