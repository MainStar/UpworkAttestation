class FreelancerProfile
  attr_accessor :name, :title, :description, :skills

  def initialize(name, title, description, skills)
    @name = name
    @title = title
    @description = description
    @skills = skills
  end

  def attr_check(keyword)
    Logger.message("Checking attributes contains <#{keyword}> for #{@name} >>")

    if @title.include?(keyword) || @description.include?(keyword) || @skills.join(' ').include?(keyword)
      Logger.message(' ')
      @title.include?(keyword) ? Logger.message("Title attribute contains <#{keyword}>") : Logger.message("Title attribute NOT contains <#{keyword}>")
      @description.include?(keyword) ? Logger.message("Description attribute contains <#{keyword}>") : Logger.message("Description attribute NOT contains <#{keyword}>")
      @skills.join(' ').include?(keyword) ? Logger.message("Skills attribute contains <#{keyword}>") : Logger.message("Skills attribute NOT contains <#{keyword}>")

      true
    else

      Logger.message("No one attribute contains <#{keyword}>")

      false
    end
  end

end