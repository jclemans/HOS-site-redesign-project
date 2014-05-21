require 'spec_helper'

describe Track do |t|
	it { should belong_to :episode }
end