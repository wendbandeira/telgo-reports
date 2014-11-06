class QueueLog < ActiveRecord::Base

 def self.events(datainicio, datafinal)

  if datainicio.blank? && datafinal.blank?
    datainicio = Date.current
    datafinal = Date.current
  end

  date_filter = "queue1.id in (select id from queue_logs where date(time) between '#{datainicio}' and '#{datafinal}') and "

  condition = " #{date_filter}
                queue2.event = 'ENTERQUEUE' and queue1.event = 'COMPLETECALLER'  
                or #{date_filter} queue2.event = 'ENTERQUEUE' and queue1.event = 'COMPLETEAGENT'
                or #{date_filter} queue2.event = 'ENTERQUEUE' and queue1.event = 'ABANDON'"

  sql = "select queue2.time, queue2.callid, queue1.queuename, queue1.agent, queue1.event, queue2.data2 as origem, 
        queue1.data1 as tempofila, queue1.data2 as tempoagente, queue2.data4 as solucao, queue2.data5 as nota from queue_logs queue1 
        inner join queue_logs queue2 on queue2.callid = queue1.callid 
        where #{condition} order by queue1.id desc;"

    QueueLog.find_by_sql (sql)

 end

 def status(event)
  case event
    when "COMPLETECALLER"
      then "Finalizada"
    when "COMPLETEAGENT"
      then "Finalizada p/ Agent"
      else "Abandonada"
  end
 end
end
