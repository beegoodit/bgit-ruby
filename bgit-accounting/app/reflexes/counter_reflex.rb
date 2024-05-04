class CounterReflex < StimulusReflex::Reflex
  def increment(step = 1)
    session[:count] = session[:count].to_i + step
   end
end
