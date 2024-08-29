# frozen_string_literal: true

# custom component requires input group wrapper
module InputGroup
  def prepend(_wrapper_options = nil)
    if options[:prepend].nil?
      false
    else
      template.content_tag(:div, options[:prepend], class: 'input-group-prepend')
    end
  end

  def append(_wrapper_options = nil)
    if options[:append].nil?
      false
    else
      template.content_tag(:div, options[:append], class: 'input-group-append')
    end
  end
end

# Register the component in Simple Form.
SimpleForm.include_component(InputGroup)
