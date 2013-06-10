class Student < ActiveRecord::Base
  self.table_name = 'student_group'

  alias_attribute :id,  :student_group_id

  belongs_to :person, class_name: Person, primary_key: :student_id, foreign_key: :student_group_student
  belongs_to :group, class_name: Group, primary_key: :group_id, foreign_key: :student_group_group

  default_scope do
    select('student_group.*, student.*')
    .joins(:person)
    .joins('INNER JOIN dictionary fnames ON fnames.dictionary_id = student_fname')
    .joins('INNER JOIN dictionary inames ON inames.dictionary_id = student_iname')
    .joins('INNER JOIN dictionary onames ON onames.dictionary_id = student_oname')
    .order('fnames.dictionary_ip, inames.dictionary_ip, onames.dictionary_ip')
  end

  scope :with_group, -> { joins(:group) }

  scope :filter, -> filters {
    cond = all

    if filters.key?(:name)
      fields = %w(fnames.dictionary_ip inames.dictionary_ip onames.dictionary_ip)
      names = filters[:name].split(' ').map { |n| "%#{n}%" }

      cond = cond.where((["CONCAT_WS(' ', #{fields.join(',')}) LIKE ?"] * names.size).join(' AND '), *names)
    end

    if filters.key?(:status)
      cond = cond.where(student_group_status: filters[:status])
    end

    if filters.key?(:course)
      cond = cond.joins(:group).where(group: { group_course: filters[:course] })
    end

    cond
  }
end