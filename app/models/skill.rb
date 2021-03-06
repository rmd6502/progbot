class Skill < ApplicationRecord

  has_and_belongs_to_many :project_needs, class_name: "Project", join_table: "needs_categories"

  has_and_belongs_to_many :users

  has_and_belongs_to_many :projects, join_table: "projects_skills"

  scope :tech_skills, -> () { where(tech: true).order("name ASC") }
  scope :non_tech_skills, -> () { where("tech = false OR tech IS NULL").order("name ASC") }
  scope :match_skill, -> (str) { where("lower(name) = lower(?)", str_or_arr) }
  scope :match_skills, -> (arr) { where("lower(name) IN (?)", arr.map(&:downcase)) }

  scope :simple_search,   -> (q) do
    q = "%#{q}%"
    where("name ILIKE ?", q).order("created_at ASC")
  end

  audited

    def self.match_with_airtable(airtable_skills: , tech:)
      airtable_skills.map do |skill|
        Skill.where('lower(name) = ?', skill.downcase).first_or_create(:name=>skill, :tech=>tech).id
      end
    end

    def designate
      case self.tech
      when true
        "Yes"
      when false
        "No"
      when nil
        "Unassigned"
      end
    end

    def self.tech_designated(designation =      'Unassigned')
      self.all.select{|skill| skill.designate == designation }
    end

    ransacker :by_tech_designation, { formatter: proc { |string|
      data = self.tech_designated(string).map(&:id)
      data = data.present? ? data : nil
    }, callable: proc { |parent|
      parent.table[:id]}}

end
