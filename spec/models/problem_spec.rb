require 'rails_helper'

RSpec.describe Problem, type: :model do
  it { should have_many(:submissions).dependent(:destroy)}
  it { should validate_presence_of(:pcode)}
end
