class AdminPage < Page
  include Capybara::DSL

  def visit_page
    visit "admin/index"
  end
  
end
