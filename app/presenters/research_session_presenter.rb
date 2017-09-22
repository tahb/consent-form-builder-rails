class ResearchSessionPresenter < Struct.new(:research_session)
  delegate :id, :age, :topic, :purpose, :unable_to_consent?,
           :able_to_consent?, :other_methodology, :other_recording_method,
           :reached_step?, to: :research_session

  [:researcher_name, :researcher_email, :researcher_phone].each do |attr|
    define_method(attr) do
      research_session.researchers.first.send attr
    end
  end

  def methodology_list
    paras = research_session.methodologies.map do |methodology|
      translation = if methodology.to_s == 'other'
                      other_methodology
                    else
                      I18n.t("report.#{age}.#{methodology}")
                    end
      "<p class='highlight'>#{translation}</p>"
    end
    paras.join("\n").html_safe
  end

  def recording_methods_list
    lowercase_words = research_session.recording_methods.map do |method|
      if method.to_s == 'other'
        other_recording_method
      else
        RecordingMethods::NAME_VALUES.fetch(method.to_sym).downcase
      end
    end
    lowercase_words.to_sentence
  end
end
