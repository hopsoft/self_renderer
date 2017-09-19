require "json"
require "active_support/core_ext/string/inflections"
require "self_renderer/version"

module SelfRenderer
  # Renders an HTML string reprsenting this object
  def render_to_html(template: nil, partial: nil, assigns: {}, locals: {})
    render_self extension: :html, template: template, partial: partial, assigns: assigns, locals: locals
  end

  # Renders a JSON string reprsenting this object
  def render_to_json(template: nil, partial: nil, assigns: {}, locals: {})
    render_self extension: :json, template: template, partial: partial, assigns: assigns, locals: locals
  end

  # Returns a Hash representation of this object as rendered by #render_to_json
  def render_to_hash(template: nil, partial: nil, assigns: {}, locals: {})
    JSON.load render_to_json(template: template, partial: partial, assigns: assigns, locals: locals)
  end

  protected

    def self_renderer
      @self_renderer ||= begin
        renderer = ApplicationController.renderer.new

        # get around limitations in devise/warden when rendering views outside the contect of a formal http request
        if defined? Warden
          env = renderer.instance_eval { @env }
          warden = Warden::Proxy.new(env, Warden::Manager.new(Rails.application))
          env["warden"] = warden
        end

        renderer
      end
    end

    def render_self(extension:, template: nil, partial: nil, assigns: {}, locals: {})
      name          = self.class.name.parameterize(separator: "_").to_sym
      assigns[name] = self
      locals[name]  = self

      if template.present?
        template = "#{template}.#{extension}" unless template.to_s.end_with?(extension.to_s)
        return self_renderer.render(template, assigns: assigns, locals: locals).squish
      end

      if partial.present?
        partial = "#{partial}.#{extension}" unless partial.to_s.end_with?(extension.to_s)
        return self_renderer.render(partial: partial, assigns: assigns, locals: locals).squish
      end

      nil
    end
end
