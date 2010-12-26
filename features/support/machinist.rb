require 'machinist/active_record'
require File.join(Rails.root, 'spec', 'blueprints')

Before { Sham.reset }
