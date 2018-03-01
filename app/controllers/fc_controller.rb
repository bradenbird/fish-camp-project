class FcController < ApplicationController

  def index
    #default, load index
    @test_text = "This is a test"
    puts @test_text
  end

end