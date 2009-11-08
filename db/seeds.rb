require 'lorem'

namespace :options do
	if ENV['count']
		@count = ENV['count'].to_i
		if @count < 0 
			@count = 0
		elsif @count > 1000
			@count = 1000
		end
	else
		@count = 0
	end

	@append = true
	if ENV['method']
		method = ENV['method']
		if method == "delete"
			@append = false
		elsif method == "append"
			@append = true
		end
	end
end

p "Creating #{@count} pieces of test data."
if @append
	p "Appending to existing data."
else
	p "Deleting existing data first."
	Course.delete_all
end

@levels = ["", "Introduction to ", "Advanced ", "A quick glimpse of ", "Beyond ",
				"Tips and tricks of ", "In depth analysis of ", "Code camp: "]

@adjectives = ["Enterprise", "Agile", "Integrated", "Rich interface", "Social",
				"Service-oriented", "Scalable", "User-centric", "Proactive",
				"Solution-centric", "Autonomous", "Unsupervised", "Mobile",
				"Discrete", "Holistic", "Principles of", "In depth",
				"Performance Modeling for"]

@buzzwords = ["Ruby on Rails", "SAAS", "JBoss", "Ajax", "Design Pattern",
				"Innovation", "Web 2.0", "Struts", "J2EE", "Blog", "Microblogging",
				"Social Network", "Wiki", "Cloud", "Infrastructure",
				"Business Services", "Machine Learning", "Middleware", "Compilers",
				"Biodatabase", "Object-Relational Mapping", "Web Services", "SOAP",
				"CORBA", "Business Intelligence", "BDD", "TDD", "C", "C++", "C#", 
				"Java", "Database", "Python", "Jython", "Pascal", "ERP", ".NET"]

@nouns = ["Development", "Testing", "Programming", "Technologies", "Frameworks",
				"Reporting", "Data Mining", "Integration", "Design", "Analysis"]

def self.r(array)
	array[rand(array.size)]
end

@count.times do
	Course.create(:name => "#{r @levels}#{r @adjectives} #{r @buzzwords} #{r @nouns}",
									:description => Lorem::Base.new('paragraphs', 1).output)
end
