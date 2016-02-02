class CallInfo
  def initialize(records)
    @records = records
  end

  def start_call
    @start_call ||= records.first.time.to_datetime
  end

  def end_call
    @end_call ||= last_record.time.to_datetime
  end

  def total_time
    ((end_call - start_call) * 24 * 60 * 60).to_i.to_s + ' seg'
  end

  def time_range
    start = start_call.hour.to_i
    ended = end_call.hour.to_i + 1
    "#{start}:00 - #{ended}:00"
  end

  def history
    str = ''
    records.each do |record|
      str << "#{record.time.to_datetime.strftime("%d-%m-%Y - %H:%M:%S")} - "
      str << case record.event
             when 'ENTERQUEUE' then "Entrou na fila #{record.group.try(:name)}, origem: #{record.data2} <br>"
             when 'RINGNOANSWER' then "Não foi atendido por #{record.agent_relation.name} <br>"
             when 'CONNECT' then "Atendido por #{record.agent_relation.name} <br>"
             when 'EXITWITHTIMEOUT' then "Tempo expirado (#{record.data3} seg) <br>"
             when 'COMPLETEAGENT' then "Desligado pelo atendente <br>"
             when 'COMPLETECALLER' then "Completada <br>"
             when 'TRANSFER' then "Transferido (#{record.data2}) <br>"
             else ''
      end
    end
    str
  end

  def file
    "http://127.0.0.1/gravacoes/monitor/q#{last_record.queuename}-#{last_record.callid}.gsm"
  end

  private

  attr_reader :records

  def last_record
    @last_record ||= records.last
  end
end
