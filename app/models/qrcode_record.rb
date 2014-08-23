class QrcodeRecord < ActiveRecord::Base
  belongs_to :batch

  before_create :set_sn

  def set_sn
    1.times do
      candidate_sn = self.class.id_generator(6)
      redo if self.class.exists?(:sn => candidate_sn)
      self.sn = candidate_sn
    end
  end

  # TODO: refactor this method to utils
  def self.id_generator(num, chars=(0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a)
    chars.shuffle[0,num].join
  end
end
