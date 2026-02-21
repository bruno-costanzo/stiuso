# frozen_string_literal: true

module Ciaobrowser
  module AgentTools
    # Reads model schema and validations
    class ReadModel < RubyLLM::Tool
      description "Returns model schema and validations. " \
                  "Use this to understand param types and required fields."

      param :model_name, type: "string",
                         desc: "Model class name (e.g., 'Profile' or 'Admin::Profile')"

      def execute(model_name:)
        model = model_name.constantize

        {
          columns: model.columns.map { |c| { name: c.name, type: c.type.to_s } },
          validations: model.validators.map do |v|
            { attributes: v.attributes, kind: v.kind.to_s }
          end
        }
      rescue NameError
        { error: "Model #{model_name} not found" }
      end
    end
  end
end
