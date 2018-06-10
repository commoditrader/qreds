module Qreds
  module Endpoint
    def method_missing(name, query, **args, &_)
      config = ::Qreds::Config[name]
      functor_group = config.functor_group

      declared_params = declared(params, include_missing: false)[functor_group]

      ::Qreds::Reducer.new(
        query: query,
        params: declared_params,
        config: config,
        **args
      ).call
    end
  end
end