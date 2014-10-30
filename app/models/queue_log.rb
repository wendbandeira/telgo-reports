class QueueLog < ActiveRecord::Base

 def self.events(filter, datainicio, datafinal)

  if datainicio == '' && datafinal = ''
    datainicio = Date.current
    datafinal = Date.current
  end

  date_filter = "queue1.id in (select id from queue_logs where date(time) between '#{datainicio}' and '#{datafinal}') and "

    if filter == "complete"   
      condition = " 
                  #{date_filter}
                  queue2.event = 'ENTERQUEUE' and queue1.event = 'COMPLETECALLER' or queue2.event = 'ENTERQUEUE' and queue1.event = 'COMPLETEAGENT'"
    else
      condition = " 
                  #{date_filter}
                  queue2.event = 'ENTERQUEUE' and queue1.event = 'ABANDON' "
    end

    sql = "
          select queue2.time, queue2.callid, queue1.queuename, queue1.agent, queue1.event, queue2.data2 as origem, queue1.data1 as tempofila, queue1.data2 as tempoagente from queue_logs queue1 
          inner join queue_logs queue2 on queue2.callid = queue1.callid 
          where #{condition} order by queue1.id desc;
          "
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
