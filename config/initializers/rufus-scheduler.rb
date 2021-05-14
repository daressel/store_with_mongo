require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

s.every '1m' do
  p 123123
end
