class QueueLog < ActiveRecord::Base

 def self.events
  QueueLog.find_by_sql ("
                        select queue1.time, queue1.callid, queue1.queuename, queue1.agent, queue1.event, queue2.data2 from queue_logs queue1 
                        inner join queue_logs queue2 on queue2.callid = queue1.callid 
                        where queue2.event = 'ENTERQUEUE' and queue1.event = 'COMPLETECALLER' or queue2.event = 'ENTERQUEUE' 
                        and queue1.event = 'COMPLETEAGENT';
                        ")
 end
end
