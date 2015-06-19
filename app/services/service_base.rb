class ServiceBase < BasicObject

  def self.set_model model
    define_method 'model' do
      model
    end
  end
end
