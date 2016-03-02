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
    hour_format ((end_call - start_call) * 24 * 60 * 60).to_i
  end

  def time_range
    hour = start_call.hour.to_i
    "#{hour}:00 - #{hour + 1}:00"
  end

  def history
    str = ''
    records.each do |record|
      str << "#{record.time.to_datetime.strftime("%d-%m-%Y - %H:%M:%S")} - "
      str << case record.event
             when 'ENTERQUEUE' then "Entrou na fila #{record.group.try(:name)}, origem: #{record.data2} <br>"
             when 'RINGNOANSWER' then "Não foi atendido por #{record.agent_relation.name} <br>"
             when 'CONNECT' then "Atendido por #{record.agent_relation.try(:name)} <br>"
             when 'EXITWITHTIMEOUT' then "Tempo expirado (#{record.data3} seg) <br>"
             when 'COMPLETEAGENT' then "Desligado pelo atendente <br>"
             when 'COMPLETECALLER' then "Completada <br>"
             when 'TRANSFER' then "Transferido (#{record.data2}) <br>"
             when 'ABANDON' then "Abandonada <br>"
             else ''
      end
    end
    str
  end

  def last_status
    record = records.last
    case record.event
    when 'ENTERQUEUE' then "Entrou na fila"
    when 'RINGNOANSWER' then "Não foi atendido"
    when 'CONNECT' then "Atendido"
    when 'EXITWITHTIMEOUT' then "Tempo expirado"
    when 'COMPLETEAGENT' then "Desligado pelo atendente"
    when 'COMPLETECALLER' then "Completada"
    when 'TRANSFER' then "Transferido"
    when 'ABANDON' then "Abandonada"
    else ''
    end
  end

  def source_number
    return if first_enterqueue.blank?

    first_enterqueue.data2
  end

  def last_queue
    queue = nil
    records.each do |record|
      name = record.group.try(:name)
      queue = name if name.present?
    end
    queue
  end

  def first_queue
    records.each do |record|
      name = record.group.try(:name)
      return name if name.present?
    end
    nil
  end

  def last_agent
    agent = nil
    records.each do |record|
      name = record.agent_relation.try(:name)
      agent = name if name.present?
    end
    agent
  end

  def in_call_time
    time = 0
    records.each do |record|
      if %w(COMPLETEAGENT COMPLETECALLER TRANSFER).include? record.event
        time += record.data2.to_i
      end
    end
    hour_format time
  end

  def in_queue_time
    time = 0
    records.each do |record|
      time += record.data1.to_i if %w(COMPLETEAGENT TRANSFER EXITWITHTIMEOUT).include? record.event
      time += record.data3.to_i if %w(CONNECT ENTERQUEUE EXITWITHTIMEOUT ABANDON COMPLETECALLER).include? record.event
    end
    hour_format time
  end

  def expiration_times
    count_events('EXITWITHTIMEOUT')
  end

  def try_times
    count_events('RINGNOANSWER')
  end

  def score
    last_enterqueue.data5 if last_enterqueue
  end

  def solution
    return if last_enterqueue.blank?
    return if last_enterqueue.data4.blank?

    last_enterqueue.data4 == '1' ? 'Solucionado' : 'Não solucionado'
  end

  def file
    "http://telefonia.telgo.com.br/gravacoes/monitor/#{last_record.callid}.wav"
  end

  private

  attr_reader :records

  def last_record
    @last_record ||= records.last
  end

  def enterqueue_records
    @enterqueue_records ||= records.select { |x| x.event == 'ENTERQUEUE' }
  end

  def last_enterqueue
    @last_enterqueue ||= enterqueue_records.last
  end

  def first_enterqueue
    @first_enterqueue ||= enterqueue_records.first
  end

  def count_events(event)
    records.select { |x| x.event == event }.size
  end

  def hour_format(total_seconds)
    seconds = total_seconds % 60
    minutes = (total_seconds / 60) % 60
    hours = total_seconds / (60 * 60)

    format("%02d:%02d:%02d", hours, minutes, seconds)
  end
end
