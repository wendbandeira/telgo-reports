class CreateQueueLogs < ActiveRecord::Migration
  def change
    create_table :queue_logs do |t|
      t.string :time, limit: 26, default: ''
      t.string :callid, limit: 32, null: false, default: ''
      t.string :queuename, limit: 32, null: false, default: ''
      t.string :agent, limit: 32, null: false, default: ''
      t.string :event, limit: 32, null: false, default: ''
      t.string :data1, limit: 100, null: false, default: ''
      t.string :data2, limit: 32, null: false, default: ''
      t.string :data3, limit: 32, null: false, default: ''
      t.string :data4, limit: 32, null: false, default: ''
      t.string :data5, limit: 32, null: false, default: ''

      t.timestamps
    end
  end
end
