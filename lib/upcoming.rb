# Upcoming
module Upcoming
  module UpcomingHelper

    def upcoming title=nil, options={}, &block
      return unless UpcomingConfig.enabled?
      initialize_upcoming unless @upcoming_initialized
      title = title.nil? ? "Upcoming" : title.to_s
      title = UpcomingConfig.prefix + title if UpcomingConfig.prefix
      concat(render(:partial => "#{UpcomingConfig.view_dir}/upcoming", :locals => {:options=>options, :body => capture(&block), :title => title}))
    end

    def initialize_upcoming
      concat(render :partial => "#{UpcomingConfig.view_dir}/upcoming_js")
      concat(render :partial => "#{UpcomingConfig.view_dir}/upcoming_css")
      @upcoming_initialized=true
    end
  
  end

  class UpcomingConfig
    @prefix = nil
    @view_dir = "upcoming"
    @environments = ['development']
    
    class << self 
      attr_accessor :environments
      attr_accessor :view_dir
      attr_accessor :prefix
    end
  
    def self.enabled?
      environments.include?(ENV['RAILS_ENV'])
    end
  
    def self.enable
      environments.push ENV['RAILS_ENV']
    end
  
    def self.disable
      environments.delete ENV['RAILS_ENV']
    end
        
  end
  
end
