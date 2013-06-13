module ApplicationHelper
    def add_to_set
    d = params[:dice]
    @die = session[:die]
    number_of_dice = @die.count(d.to_i)
    number_of_dice.times do 
      session[:die2] << d.to_i
    end
    @die = session[:die].delete(d.to_i) 
    
    
  end
end
