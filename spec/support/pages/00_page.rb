module DynamicPageLookup
  def method_missing(meth, *args, &block)
    if page?(meth) && args.empty?
      page_object_for(meth)
    else
      super
    end
  end

  def page_object_for(page_name)
    class_name = page_name.to_s.camelize
    class_name.constantize.new
  rescue NameError
    raise "No page defined with name #{class_name}"
  end

  def page?(meth)
    meth =~ /_page$/ || meth =~ /_modal$/
  end
end

class Page
  include Rails.application.routes.url_helpers
  include DynamicPageLookup
  include Capybara::DSL
end

class RSpec::Core::ExampleGroup
  include DynamicPageLookup
end
