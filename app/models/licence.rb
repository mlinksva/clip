class Licence < ActiveRecord::Base
  attr_accessible :domain_content, :domain_data, :domain_software, :identifier, :version, :family,
    :maintainer, :maintainer_type, :title, :url,
    :compliance_attributes, :right_attributes, :obligation_attributes, :patent_clause_attributes,
    :attribution_clause_attributes, :copyleft_clause_attributes, :compatibility_attributes,
    :termination_attributes, :changes_to_term_attributes, :disclaimer_attributes, :conflict_of_law_attributes,
    :logo, :text
  MAINTAINER_TYPES = %w(gov_canada ngo private)

  has_one :compliance, dependent: :destroy
  has_one :right, dependent: :destroy
  has_one :obligation, dependent: :destroy
  has_one :patent_clause, dependent: :destroy
  has_one :attribution_clause, dependent: :destroy
  has_one :copyleft_clause, dependent: :destroy
  has_one :compatibility, dependent: :destroy
  has_one :termination, dependent: :destroy
  has_one :changes_to_term, dependent: :destroy
  has_one :disclaimer, dependent: :destroy
  has_one :conflict_of_law, dependent: :destroy
  has_one :score, dependent: :destroy

  has_attached_file :logo, styles: { medium: "220x220" }
  has_attached_file :text

  accepts_nested_attributes_for :compliance, :allow_destroy => true
  accepts_nested_attributes_for :right, :allow_destroy => true
  accepts_nested_attributes_for :obligation, :allow_destroy => true
  accepts_nested_attributes_for :patent_clause, :allow_destroy => true
  accepts_nested_attributes_for :attribution_clause, :allow_destroy => true
  accepts_nested_attributes_for :copyleft_clause, :allow_destroy => true
  accepts_nested_attributes_for :compatibility, :allow_destroy => true
  accepts_nested_attributes_for :termination, :allow_destroy => true
  accepts_nested_attributes_for :changes_to_term, :allow_destroy => true
  accepts_nested_attributes_for :disclaimer, :allow_destroy => true
  accepts_nested_attributes_for :conflict_of_law, :allow_destroy => true

  validates :identifier, uniqueness: true
  validates :identifier, :title, presence: true
  validates :maintainer_type, inclusion: MAINTAINER_TYPES

  def as_json(options={})
    # manually define json structure to provide a user-friendly ordering
    {
      id: self.identifier,
      title: self.title,
      url: self.url,
      maintainer: self.maintainer,
      maintainer_type: self.maintainer_type,
      domain_data: self.domain_data,
      domain_software: self.domain_software,
      domain_content: self.domain_content,
      compliance: self.compliance,
      rights: self.right,
      obligations: self.obligation,
      attribution: self.attribution_clause,
      copyleft: self.copyleft_clause,
      patents: self.patent_clause,
      compatibility: self.compatibility,
      termination: self.termination,
      changes_to_terms: self.changes_to_term,
      disclaimers: self.disclaimer,
      conflict_of_laws: self.conflict_of_law
    }
  end
end